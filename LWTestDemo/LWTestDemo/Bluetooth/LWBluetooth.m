//
//  LWBluetooth.m
//  LWTestDemo
//
//  Created by linwei on 2021/7/7.
//

#import "LWBluetooth.h"
#import <UIKit/UIKit.h>

@interface LWBluetooth ()<CBCentralManagerDelegate,CBPeripheralDelegate>

@property(nonatomic,strong) CBCentralManager *centralManager;
@property(nonatomic,strong) CBPeripheral *peripheral;
@property(nonatomic,strong) CBCharacteristic *characteristic;
@property(nonatomic,strong) NSMutableArray *peripheralArray;

- (void)initBluetooth; //初始化蓝牙
- (void)scanBluetooth; //扫描蓝牙
- (void)stopScanBluetooth; //停止扫描
- (void)connectPeripheral:(CBPeripheral *)peripheral; //连接蓝牙
- (void)disConnectPeripheral:(CBPeripheral *)peripheral; //取消连接蓝牙
- (void)sendData:(NSData *)data; //向扫描到的蓝牙Characteristic 发送数据

@end

@implementation LWBluetooth
// 初始化蓝牙
- (void)initBluetooth
{
//    NSDictionary *options = @{CBCentralManagerOptionShowPowerAlertKey:@NO};
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];//创建CBCentralManager对象
    _peripheralArray = [[NSMutableArray alloc] init];
}
//跳转授权页面
- (void)jumpBluetoothAuthorized{
    NSURL *url = [NSURL URLWithString:@"App-Prefs:root=Bluetooth"];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}
//扫描蓝牙
- (void)scanBluetooth
{
    NSLog(@"BluetoothBase scanBluetooth");
    //CBCentralManagerScanOptionAllowDuplicatesKey值为 No，表示不重复扫描已发现的设备
    //CBConnectPeripheralOptionNotifyOnConnectionKey: 在应用挂起后，与指定的peripheral成功建立连接，则发出通知
    //CBConnectPeripheralOptionNotifyOnDisconnectionKey: 在应用挂起后，如果与指定的peripheral断开连接，则发出通知
    //CBConnectPeripheralOptionNotifyOnNotificationKey: 在应用挂起后，指定的peripheral有任何通知都进行提示
    // CBCentralManagerScanOptionAllowDuplicatesKey | CBConnectPeripheralOptionNotifyOnConnectionKey | CBConnectPeripheralOptionNotifyOnDisconnectionKey | CBConnectPeripheralOptionNotifyOnNotificationKey
    NSDictionary *optionDic = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    
    [_centralManager scanForPeripheralsWithServices:nil options:optionDic];//如果你将第一个参数设置为nil，Central Manager就会开始寻找所有的服务。
}
//停止扫描蓝牙
- (void)stopScanBluetooth
{
    [self.centralManager stopScan];
    NSLog(@"BluetoothBase stopScanBluetooth，已经连接外设停止扫描或者手动停止扫描");
}
//连接蓝牙
- (void)connectPeripheral:(CBPeripheral *)peripheral
{
    [self.centralManager connectPeripheral:peripheral options:nil];
    self.peripheral = peripheral;
    peripheral.delegate = self;     //连接时设置代理
}
//取消连接蓝牙
- (void)disConnectPeripheral:(CBPeripheral *)peripheral
{
    [_centralManager cancelPeripheralConnection:peripheral];
}
//设置通知
-(void)notifyCharacteristic:(CBPeripheral *)peripheral
           characteristic:(CBCharacteristic *)characteristic{
   //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
   [peripheral setNotifyValue:YES forCharacteristic:characteristic];
}

//取消通知
-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral
            characteristic:(CBCharacteristic *)characteristic{

    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}
//如果发送的数据过大，就需要做分包处理了。至于传输的最大字节数是多大，就需要和硬件工程师讨论了。pl @PlatoJobs
//向蓝牙写入数据
- (void)sendData:(NSData *)data
{
//    [self initBluetoothDispatch];

    if (_characteristic.properties & CBCharacteristicPropertyWrite){
        [_peripheral writeValue:data forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
        NSLog(@"BluetoothBase writeDataToCharacteristic:%@",[_characteristic.UUID UUIDString]);
    }else{
        NSLog(@"没有发现可以写入的characteristic");
    }
}
#pragma mark -  蓝牙的一些代理方法(CBCentralManagerDelegate)：
//centralManager已经更新状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSString *strMessage = nil;
    NSString *buttonTitle = nil;
    switch (central.state) {
        case CBCentralManagerStateUnknown|CBManagerStateUnknown:
            {
                strMessage = @"手机没有识别到蓝牙，请检查手机。";
                buttonTitle = @"前往设置";
            }
            break;
        case CBCentralManagerStateResetting|CBManagerStateResetting:
            {
                strMessage = @"手机蓝牙已断开连接，重置中...";
                buttonTitle = @"前往设置";
            }
            break;
        case CBCentralManagerStateUnsupported|CBManagerStateUnsupported:
            {
                strMessage = @"手机不支持蓝牙功能，请更换手机。";
            }
            break;
        case CBCentralManagerStateUnauthorized|CBManagerStateUnauthorized:
            {
                strMessage = @"手机蓝牙功能没有权限，请前往设置。";
                buttonTitle = @"前往设置";
            }
            break;
        case CBCentralManagerStatePoweredOff|CBManagerStatePoweredOff:
            {
                strMessage = @"手机蓝牙功能关闭，请前往设置打开蓝牙及控制中心打开蓝牙。";
                buttonTitle = @"前往设置";
            }
            break;
        case CBCentralManagerStatePoweredOn|CBManagerStatePoweredOn:
            [self scanBluetooth];   //很重要，当蓝牙处于打开状态，开始扫描。
            break;
        default:
            break;
    }
    if (strMessage != nil && strMessage.length != 0) {

    }

}

//centralManager已经发现外设
//扫描到外设，停止扫描，连接设备(每扫描到一个外设都会调用一次这个函数，若要展示搜索到的蓝牙，可以逐一保存 peripheral 并展示)
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"peripheral=>>%@ identifier =>>%@ advertisementData===>%@ RSSI===>%@",peripheral,peripheral.identifier,advertisementData,RSSI);

//    if ([peripheral.name hasPrefix:@"lin"]){
//        [self connectPeripheral:peripheral];
//    }
    if (![[self nullToString: peripheral.name] isEqualToString: @"" ]&& ![self.peripheralArray containsObject:peripheral]) {
        [ self.peripheralArray addObject:peripheral];
    }
        
    
//    [PRTBluetoothModel share].peripheralArray = _peripheralArray;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"PRTBluetoothScanUpdatePeripheralList" object:nil];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"已经断开蓝牙设备：%@", peripheral.name);
}
//已经连接外设
//连接外设成功，扫描外设中的服务和特征
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
//    [PRTDispatchModel share].currentDispatchMode = PRTPrinterModeBle;  //将蓝牙模式保存到当前传输模式。
    NSLog(@"didConnectPeripheral:%@",peripheral.name);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PRTBluetoothScanDidConnectPeripheral" object:nil];

    [self stopScanBluetooth]; //连接成功后停止扫描

    [self.peripheral setDelegate:self];

    //数组中存放两个服务的 UUID
//    NSMutableArray *uuidArray = [[NSMutableArray alloc] initWithObjects:[CBUUID UUIDWithString:UUID_String_DeviceInfo_Service], [CBUUID UUIDWithString:UUIDSTR_ISSC_PROPRIETARY_SERVICE], nil];

//    [peripheral discoverServices:uuidArray];//发现服务，成功后执行：peripheral:didDiscoverServices委托方法
    [peripheral discoverServices:nil];
}
//连接外设失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"didFailToConnectPeripheral:%@",error);
}

#pragma mark -  CBPeripheralDelegate
//已经发现服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"didDiscoverServices:%@",peripheral.name);
    if (error) {
        NSLog(@"didDiscoverServices error:%@",[error localizedDescription]);
        return;
    }
    for (CBService *service in peripheral.services) {
        //发现特征，成功后执行：peripheral:didDiscoverCharacteristicsForService:error委托方法
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

//已经为服务发现特征
/*
蓝牙都会有几个服务，每个服务都会有几个特征，服务和特征都是用不同的 UUID 来标识的。
每个特征的 properties 是不同的，就是说有不同的功能属性，有的对应写入，有的对应读取。
蓝牙联盟有一个规范，但是这个也是可以自定义的，所以不清楚的话，联系硬件工程师问清楚
*/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"didDiscoverCharacteristicsForServic:%@",service.UUID);
    if (error)
    {
        NSLog(@"error Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }

    CBCharacteristic *characteristic = nil;

//    if ( [service.UUID isEqual:[CBUUID UUIDWithString:@"这里填你的蓝牙服务的 UUID"]]) {
        for (characteristic in service.characteristics)
        {
//            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"这里填你的蓝牙特征的 UUID"]]) {
                self.characteristic = characteristic;//重要，将满足条件的特征保存为全局特征，以便对齐进行写入操作。
//                [PRTBluetoothModel share].characteristicWrite = characteristic;
                // 监听外设特征值
//                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                
                //获取Characteristic的值，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
                [peripheral readValueForCharacteristic:characteristic];
                
                //搜索Characteristic的Descriptors，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
                [peripheral discoverDescriptorsForCharacteristic:characteristic];
                
            }
//        }
//    }

    if (error) {
        NSLog(@"didDiscoverCharacteristicsForService error:%@",[error localizedDescription]);
    }
}


// 已经更新特征的值
//获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取。
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"didUpdateValueForCharacteristic:%@",[characteristic.UUID UUIDString]);
    if (error) {
        NSLog(@"didUpdateValueForCharacteristic error:%@",[error localizedDescription]);
    }
    for (CBDescriptor *descriptor in characteristic.descriptors)
    {
        // 读到数据会进入方法 peripheral:didUpdateValueForDescriptor:error:
        [peripheral readValueForDescriptor:descriptor];
    }
    //打印出characteristic的UUID和值
    //!注意，value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据
    NSLog(@"发现%@ - 特征：UUID: %@, desc: %@, props: %zd, value: %@", peripheral.name, characteristic.UUID.UUIDString, characteristic.description, characteristic.properties, [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding]);

}
//已经写入特征的值
//委托方法：已经为特征【写入值】
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"didWriteValueForCharacteristic:%@",[characteristic.UUID UUIDString]);

    if (error) {
        NSLog(@"didWriteValueForCharacteristic error：%@",[error localizedDescription]);
    }

    [peripheral readValueForCharacteristic:characteristic]; //12.23新增
}
//已经发现特征的描述 搜索到Characteristic的Descriptors
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"didDiscoverDescriptorsForCharacteristic:%@",characteristic);
    for (CBDescriptor *d in characteristic.descriptors) {
        NSLog(@"Descriptor UUID:%@",d.UUID);
    }
}
// 已经更新描述的值 获取到Descriptors的值
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    NSLog(@"didUpdateValueForDescriptor:%@",descriptor);
    //打印出DescriptorsUUID 和value
    //这个descriptor都是对于characteristic的描述，一般都是字符串，所以这里我们转换成字符串去解析
    NSLog(@"characteristic uuid:%@  value:%@",[NSString stringWithFormat:@"%@",descriptor.UUID],descriptor.value);
}
//已经更新特征的通知状态
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"didUpdateNotificationStateForCharacteristic:%@",characteristic);
    if (error) {
        NSLog(@"Error changing notification state: %@",[error localizedDescription]);
    }
}



- (NSString *)nullToString:(id)string {
    if ([string isEqual:@"NULL"] || [string isKindOfClass:[NSNull class]] || [string isEqual:[NSNull null]] || [string isEqual:NULL] || [[string class] isSubclassOfClass:[NSNull class]] || string == nil || string == NULL || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"]) {
        return @"";
    } else {
        return (NSString *)string;
    }
}
@end


