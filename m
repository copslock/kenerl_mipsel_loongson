Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2004 21:36:02 +0000 (GMT)
Received: from mail.gmx.net ([IPv6:::ffff:213.165.64.20]:44676 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8224937AbUKRVfy>;
	Thu, 18 Nov 2004 21:35:54 +0000
Received: (qmail 16280 invoked by uid 65534); 18 Nov 2004 21:35:47 -0000
Received: from c210132.adsl.hansenet.de (EHLO [192.168.0.1]) (213.39.210.132)
  by mail.gmx.net (mp014) with SMTP; 18 Nov 2004 22:35:47 +0100
X-Authenticated: #947741
Message-ID: <419D171E.5040507@gmx.net>
Date: Thu, 18 Nov 2004 22:41:50 +0100
From: TheNop <TheNop@gmx.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Titan ethernet driver broken
References: <419D03DE.8090403@gmx.net> <419D04AA.50508@mvista.com>
In-Reply-To: <419D04AA.50508@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------070608030705010706000200"
Return-Path: <TheNop@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TheNop@gmx.net
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070608030705010706000200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Manish Lachwani wrote:

> TheNop wrote:
>
>> Hello,
>>
>> using DHCP support on the yosemite target with the current sources 
>> did not work anymore.
>> The DHCP request timed out.
>> Using the sources from cvs lable linux_2_6_8_1 for the titan ethernet 
>> driver works around this problem.
>>
>> Best regards
>> TheNop
>>
>>
>>
> Hello !
>
> Can you send the diff between the titan_ge (both .c and .h files) 
> driver version in linux_2_6_8_1 and the latest driver sources?
>
> Thanks
> Manish Lachwani
>
>
>
Hi Manish,

here are the diffs. You also need moduls.h from linux_2_6_8_1.

Best regards
TheNop



--------------070608030705010706000200
Content-Type: text/plain;
 name="module.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="module.h.diff"

47,60d46
< struct module;
< 
< struct module_attribute {
<         struct attribute attr;
<         ssize_t (*show)(struct module *, char *);
<         ssize_t (*store)(struct module *, const char *, size_t count);
< };
< 
< struct module_kobject
< {
< 	struct kobject kobj;
< 	struct module *mod;
< };
< 
76,77d61
< extern struct subsystem module_subsys;
< 
160c144,145
<   local headers in "srcversion".
---
>   local headers to the end.  Use MODULE_VERSION("") if you want just
>   this.  Macro includes room for this.
162c147,148
< #define MODULE_VERSION(_version) MODULE_INFO(version, _version)
---
> #define MODULE_VERSION(_version) \
>   MODULE_INFO(version, _version "\0xxxxxxxxxxxxxxxxxxxxxxxx")
224a211,227
> /* sysfs stuff */
> struct module_attribute
> {
> 	struct attribute attr;
> 	struct kernel_param *param;
> };
> 
> struct module_kobject
> {
> 	/* Everyone should have one of these. */
> 	struct kobject kobj;
> 
> 	/* We always have refcnt, we may have others from module_param(). */
> 	unsigned int num_attributes;
> 	struct module_attribute attr[0];
> };
> 
240d242
< struct param_kobject;
254d255
< 	struct param_kobject *params_kobject;
305a307,309
> 
> 	/* Fake kernel param for refcnt. */
> 	struct kernel_param refcnt_param;
444,448d447
< 
< struct device_driver;
< void module_add_driver(struct module *, struct device_driver *);
< void module_remove_driver(struct device_driver *);
< 
538,549d536
< 
< struct device_driver;
< struct module;
< 
< static inline void module_add_driver(struct module *module, struct device_driver *driver)
< {
< }
< 
< static inline void module_remove_driver(struct device_driver *driver)
< {
< }
< 
561,562d547
< 
< static inline void __deprecated MODULE_PARM_(void) { }
567c552,572
< { __stringify(var), type, &MODULE_PARM_ };
---
> { __stringify(var), type };
> 
> static inline void __deprecated MOD_INC_USE_COUNT(struct module *module)
> {
> 	__unsafe(module);
> 
> #if defined(CONFIG_MODULE_UNLOAD) && defined(MODULE)
> 	local_inc(&module->ref[get_cpu()].count);
> 	put_cpu();
> #else
> 	(void)try_module_get(module);
> #endif
> }
> 
> static inline void __deprecated MOD_DEC_USE_COUNT(struct module *module)
> {
> 	module_put(module);
> }
> 
> #define MOD_INC_USE_COUNT	MOD_INC_USE_COUNT(THIS_MODULE)
> #define MOD_DEC_USE_COUNT	MOD_DEC_USE_COUNT(THIS_MODULE)
569c574,576
< #define MODULE_PARM(var,type) static void __attribute__((__unused__)) *__parm_##var = &MODULE_PARM_;
---
> #define MODULE_PARM(var,type)
> #define MOD_INC_USE_COUNT	do { } while (0)
> #define MOD_DEC_USE_COUNT	do { } while (0)
576,582c583,587
< extern void __deprecated inter_module_register(const char *,
< 		struct module *, const void *);
< extern void __deprecated inter_module_unregister(const char *);
< extern const void * __deprecated inter_module_get(const char *);
< extern const void * __deprecated inter_module_get_request(const char *,
< 		const char *);
< extern void __deprecated inter_module_put(const char *);
---
> extern void inter_module_register(const char *, struct module *, const void *);
> extern void inter_module_unregister(const char *);
> extern const void *inter_module_get(const char *);
> extern const void *inter_module_get_request(const char *, const char *);
> extern void inter_module_put(const char *);

--------------070608030705010706000200
Content-Type: text/plain;
 name="titan_ge.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="titan_ge.c.diff"

50c50
< #include <linux/dma-mapping.h>
---
> #include <linux/version.h>
52a53
> #include <linux/config.h>
53a55,56
> #include <linux/ptrace.h>
> #include <linux/fcntl.h>
61a65
> #include <linux/pci.h>
97a102
> static int titan_ge_set_mac_address(struct net_device *, void *);
105a111
> static int titan_ge_init(int);
119a126
> #ifdef TITAN_RX_NAPI
120a128
> #endif
124,125d131
< static struct platform_device *titan_ge_device[3];
< 
132,133d137
< static char titan_string[] = "titan";
< 
450a455
> #ifdef TITAN_RX_NAPI
468,470d472
< 			if (port_num == 2)
< 				ack &= ~(0x30000);
< 
476a479,481
> #else
> 	titan_ge_free_tx_queue(titan_ge_eth);
> 	titan_ge_receive_queue(netdev, 0);
477a483
> #endif
612,613d617
< 	struct device *device = &titan_ge_device[titan_ge_port->port_num]->dev;
< 	volatile titan_ge_rx_desc *rx_desc;
614a619
> 	volatile titan_ge_rx_desc *rx_desc;
621,622c626,627
< 	       dma_map_single(device, skb->data, TITAN_GE_JUMBO_BUFSIZE - 2,
< 			      DMA_FROM_DEVICE);
---
>                pci_map_single(0, skb->data, TITAN_GE_JUMBO_BUFSIZE - 2,
>                                             PCI_DMA_FROMDEVICE);
625,626c630,631
< 		dma_map_single(device, skb->data, TITAN_GE_STD_BUFSIZE - 2,
< 			       DMA_FROM_DEVICE);
---
>                 pci_map_single(0, skb->data, TITAN_GE_STD_BUFSIZE - 2,
>                                             PCI_DMA_FROMDEVICE);
723d727
< 	unsigned long reg_data_1;
737c741
< 
---
> #ifdef TITAN_RX_NAPI
739c743,745
< 
---
> #else
> 		TITAN_GE_WRITE(0x000c, 0x00000100); /* No WCIMODE */
> #endif
748a755
> #ifdef TITAN_RX_NAPI
750a758
> #endif
905,950d912
< 	/*
< 	 * Titan 1.2 revision does support port #2
< 	 */
< 	if (port_num == 2) {
< 		/*
< 		 * Put the descriptors in the SRAM
< 		 */
< 		reg_data = TITAN_GE_READ(0x48a0);
< 
< 		reg_data |= 0x100000;
< 		reg_data |= (0xff << 10) | (2*(0xff + 1));
< 
< 		TITAN_GE_WRITE(0x48a0, reg_data);
< 		/*
< 		 * BAV2,BAV and DAV settings for the Rx FIFO
< 		 */
< 		reg_data1 = TITAN_GE_READ(0x48a4);
< 		reg_data1 |= ( (0x10 << 20) | (0x10 << 10) | 0x1);
< 		TITAN_GE_WRITE(0x48a4, reg_data1);
< 
< 		reg_data &= ~(0x00100000);
< 		reg_data |= 0x200000;
< 
< 		TITAN_GE_WRITE(0x48a0, reg_data);
< 		
< 		reg_data = TITAN_GE_READ(0x4958);
< 		reg_data |= 0x100000;
< 
< 		TITAN_GE_WRITE(0x4958, reg_data);
< 		reg_data |= (0xff << 10) | (2*(0xff + 1));
< 		TITAN_GE_WRITE(0x4958, reg_data);
< 
< 		/*
< 		 * BAV2, BAV and DAV settings for the Tx FIFO
< 		 */
< 		reg_data1 = TITAN_GE_READ(0x495c);
< 		reg_data1 = ( (0x1 << 20) | (0x1 << 10) | 0x10);
< 
< 		TITAN_GE_WRITE(0x495c, reg_data1);
< 
< 		reg_data &= ~(0x00100000);
< 		reg_data |= 0x200000;
< 
< 		TITAN_GE_WRITE(0x4958, reg_data);
< 	}
< 
995,1016d956
< 
< 	/*
< 	 * This is the 1.2 revision of the chip. It has fix for the
< 	 * IP header alignment. Now, the IP header begins at an
< 	 * aligned address and this wont need an extra copy in the
< 	 * driver. This performance drawback existed in the previous
< 	 * versions of the silicon
< 	 */
< 	reg_data_1 = TITAN_GE_READ(0x103c + (port_num << 12));
< 	reg_data_1 |= 0x40000000;
< 	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);
< 
< 	reg_data_1 |= 0x04000000;
< 	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);
< 
< 	mdelay(5);
< 
< 	reg_data_1 &= ~(0x04000000);
< 	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);
< 
< 	mdelay(5);
< 
1074,1076d1013
< 	if (port_num == 2)
< 		reg_data1 |= 0x30000;
< 
1107,1108d1043
< 	struct device *device = &titan_ge_device[titan_ge_eth->port_num]->dev;
< 	unsigned int curr_desc = titan_ge_eth->tx_curr_desc_q;
1110a1046,1047
> 	unsigned int curr_desc =
> 			titan_ge_eth->tx_curr_desc_q;
1114,1115c1051,1052
< 		dma_map_single(device, skb->data, skb_headlen(skb),
< 			       DMA_TO_DEVICE);
---
> 		pci_map_single(0, skb->data, skb_headlen(skb),
> 					PCI_DMA_TODEVICE);
1133a1071,1083
> #ifndef TITAN_RX_NAPI
> /*
>  * Coalescing for the Rx path
>  */
> static unsigned long titan_ge_rx_coal(unsigned long delay, int port)
> {
> 	TITAN_GE_WRITE(TITAN_GE_INT_COALESCING, delay);
> 	TITAN_GE_WRITE(0x5038, delay);
> 
> 	return delay;
> }
> #endif
> 
1141d1090
< 	struct device *device = &titan_ge_device[port_num]->dev;
1190,1196d1138
< 	if (port_num == 2) {
< 		titan_ge_eth->tx_desc_area =
< 		    (titan_ge_tx_desc *) (titan_ge_sram + 0x200);
< 
< 		titan_ge_eth->tx_dma = TITAN_SRAM_BASE + 0x200;
< 	}
< 
1231,1236d1172
< 	if (port_num == 2) {
< 		titan_ge_eth->rx_desc_area =
< 			(titan_ge_rx_desc *)(titan_ge_sram + 0x1200);
< 		titan_ge_eth->rx_dma = TITAN_SRAM_BASE + 0x1200;
< 	}
< 
1246c1182
< 		dma_free_coherent(device, titan_ge_eth->tx_desc_area_size,
---
> 		pci_free_consistent(0, titan_ge_eth->tx_desc_area_size,
1278a1215,1225
> #ifndef TITAN_RX_NAPI
> 	/* 
> 	 * If NAPI is turned on, we disable Rx interrupts
> 	 * completely. So, we dont need coalescing then. Tx side
> 	 * coalescing set to very high value. Maybe, disable
> 	 * Tx side interrupts completely
> 	 */
> 	if (TITAN_GE_RX_COAL) {
> 		titan_ge_eth->rx_int_coal =
> 		    titan_ge_rx_coal(TITAN_GE_RX_COAL, port_num);
> 	} 
1279a1227
> #endif
1408a1357,1395
>  * Do the slowpath route. This route is kicked off
>  * when the IP header is misaligned. Grrr ..
>  */
> static int titan_ge_slowpath(struct sk_buff *skb,
> 				titan_ge_packet *packet,
> 				struct net_device *netdev)
> {
> 	struct sk_buff *copy_skb;
> 
> 	copy_skb = dev_alloc_skb(packet->len + 2);
> 
> 	if (!copy_skb) {
> 		dev_kfree_skb_any(packet->skb);
> 		return -1;
> 	}
> 
> 	copy_skb->dev = netdev;
> 	skb_reserve(copy_skb, 2);
> 	skb_put(copy_skb, packet->len);
> 
> 	memcpy(copy_skb->data, skb->data, packet->len);
> 
> 	/* Titan supports Rx checksum offload */
> 	copy_skb->ip_summed = CHECKSUM_HW;
> 	copy_skb->csum = packet->checksum;
> 
> 	copy_skb->protocol = eth_type_trans(copy_skb, netdev);
> 
> 	dev_kfree_skb_any(packet->skb);
> #ifdef TITAN_RX_NAPI
> 	netif_receive_skb(copy_skb);
> #else
> 	netif_rx(copy_skb);
> #endif
> 
> 	return 0;
> }
> 
> /*
1436a1424
> #ifdef TITAN_RX_NAPI
1440c1428
< 
---
> #endif
1458a1447
> 		skb_put(skb, packet.len);
1460,1468c1449,1450
< 		skb_put(skb, packet.len - 2);
< 
< 		/*
< 		 * Increment data pointer by two since thats where
< 		 * the MAC starts
< 		 */
< 		skb_reserve(skb, 2);
< 		skb->protocol = eth_type_trans(skb, netdev);
< 		netif_receive_skb(skb);
---
> 		if (titan_ge_slowpath(skb, &packet, netdev) < 0) 
> 			goto out_next;
1469a1452
> #ifdef TITAN_RX_NAPI
1475a1459,1462
> #else
> 		ack = titan_ge_rx_task(netdev, titan_ge_eth);
> 		TITAN_GE_WRITE((0x5048 + (port_num << 8)), ack);
> #endif
1476a1464,1466
> out_next:
> 
> #ifdef TITAN_RX_NAPI
1482a1473
> #endif
1488a1480,1481
> #ifdef TITAN_RX_NAPI
> 
1589a1583
> #endif
1600a1595
> 	MOD_DEC_USE_COUNT;
1646,1647c1641
< 	dma_free_coherent(&titan_ge_device[port_num]->dev,
< 			  titan_ge_eth->tx_desc_area_size,
---
> 	pci_free_consistent(0, titan_ge_eth->tx_desc_area_size,
1693,1694c1687
< 	dma_free_coherent(&titan_ge_device[port_num]->dev,
< 			  titan_ge_eth->rx_desc_area_size,
---
> 	pci_free_consistent(0, titan_ge_eth->rx_desc_area_size,
1754a1748,1749
> 
> 	return;
1760c1755
< static int titan_ge_set_mac_address(struct net_device *dev, void *addr)
---
> int titan_ge_set_mac_address(struct net_device *netdev, void *addr)
1762,1765c1757
< 	titan_ge_port_info *tp = netdev_priv(dev);
< 	struct sockaddr *sa = addr;
< 
< 	memcpy(dev->dev_addr, sa->sa_data, dev->addr_len);
---
> 	int i;
1767,1769c1759,1760
< 	spin_lock_irq(&tp->lock);
< 	titan_ge_update_mac_address(dev);
< 	spin_unlock_irq(&tp->lock);
---
> 	for (i = 0; i < 6; i++)
> 		netdev->dev_addr[i] = ((unsigned char *) addr)[i + 2];
1770a1762
> 	titan_ge_update_mac_address(netdev);
1784a1777,1835
>  * Register the Titan GE with the kernel
>  */
> static int __init titan_ge_init_module(void)
> {
> 	unsigned int version, device;
> 
> 	printk(KERN_NOTICE
> 	       "PMC-Sierra TITAN 10/100/1000 Ethernet Driver \n");
> 
> 	titan_ge_base = (unsigned long) ioremap(TITAN_GE_BASE, TITAN_GE_SIZE);
> 	if (!titan_ge_base) {
> 		printk("Mapping Titan GE failed\n");
> 		goto out;
> 	}
> 
> 	device = TITAN_GE_READ(TITAN_GE_DEVICE_ID);
> 	version = (device & 0x000f0000) >> 16;
> 	device &= 0x0000ffff;
> 
> 	printk(KERN_NOTICE "Device Id : %x,  Version : %x \n", device, version);
> 
> #ifdef TITAN_RX_RING_IN_SRAM
> 	titan_ge_sram = (unsigned long) ioremap(TITAN_SRAM_BASE,
> 	                                        TITAN_SRAM_SIZE);
> 	if (!titan_ge_sram) {
> 		printk("Mapping Titan SRAM failed\n");
> 		goto out_unmap_ge;
> 	}
> #endif
> 
> 	/* Register only one port */ 
> 	if (titan_ge_init(0)) 
> 		printk(KERN_ERR
> 		       "Error registering the TITAN Ethernet driver"
> 			"for port 0 \n");
> 	
> 	if (titan_ge_init(1)) 
> 		printk(KERN_ERR "Error registering the TITAN Ethernet" 
> 				"driver for port 1\n");
> 
> 	return 0;
> 
> out_unmap_ge:
> 	iounmap((void *)titan_ge_base);
> 
> out:
> 	return -ENOMEM;
> }
> 
> /*
>  * Unregister the Titan GE from the kernel
>  */
> static void __init titan_ge_cleanup_module(void)
> {
> 	iounmap((void *)titan_ge_sram);
> 	iounmap((void *)titan_ge_base);
> }
> 
> /*
1878c1929
< static int __init titan_ge_probe(struct device *device)
---
> static int titan_ge_init(int port)
1882d1932
< 	int port = to_platform_device(device)->id;
1901a1952
> #ifdef TITAN_RX_NAPI
1905c1956
< 
---
> #endif
1938a1990
> #ifdef TITAN_RX_NAPI
1939a1992,1994
> #else
> 	printk(KERN_NOTICE "Rx and Tx Coalescing ON \n");
> #endif
2016,2131d2070
< static struct device_driver titan_soc_driver = {
< 	.name   = titan_string,
< 	.bus    = &platform_bus_type,
< 	.probe  = titan_ge_probe,
< 	.remove = __devexit_p(titan_device_remove),
< };
< 
< static void titan_platform_release (struct device *device)
< {
< 	struct platform_device *pldev;
< 
< 	/* free device */
< 	pldev = to_platform_device (device);
< 	kfree (pldev);
< }
< 
< /*
<  * Register the Titan GE with the kernel
<  */
< static int __init titan_ge_init_module(void)
< {
< 	struct platform_device *pldev;
< 	unsigned int version, device;
< 	int i;
< 
< 	printk(KERN_NOTICE
< 	       "PMC-Sierra TITAN 10/100/1000 Ethernet Driver \n");
< 
< 	titan_ge_base = (unsigned long) ioremap(TITAN_GE_BASE, TITAN_GE_SIZE);
< 	if (!titan_ge_base) {
< 		printk("Mapping Titan GE failed\n");
< 		goto out;
< 	}
< 
< 	device = TITAN_GE_READ(TITAN_GE_DEVICE_ID);
< 	version = (device & 0x000f0000) >> 16;
< 	device &= 0x0000ffff;
< 
< 	printk(KERN_NOTICE "Device Id : %x,  Version : %x \n", device, version);
< 
< #ifdef TITAN_RX_RING_IN_SRAM
< 	titan_ge_sram = (unsigned long) ioremap(TITAN_SRAM_BASE,
< 						TITAN_SRAM_SIZE);
< 	if (!titan_ge_sram) {
< 		printk("Mapping Titan SRAM failed\n");
< 		goto out_unmap_ge;
< 	}
< #endif
< 
< 	if (driver_register(&titan_soc_driver)) {
< 		printk(KERN_ERR "Driver registration failed\n");
< 		goto out_unmap_sram;
< 	}
< 
< 	for (i = 0; i < 3; i++) {
< 		titan_ge_device[i] = NULL;
< 
< 	        if (!(pldev = kmalloc (sizeof (*pldev), GFP_KERNEL)))
< 	                continue;
< 
<                 memset (pldev, 0, sizeof (*pldev));
<                 pldev->name		= titan_string;
<                 pldev->id		= i;
<                 pldev->dev.release	= titan_platform_release;
<                 titan_ge_device[i]	= pldev;
< 
<                 if (platform_device_register (pldev)) {
<                         kfree (pldev);
<                         titan_ge_device[i] = NULL;
<                         continue;
<                 }
<                                                                                 
<                 if (!pldev->dev.driver) {
< 	                /*
< 			 * The driver was not bound to this device, there was
< 	                 * no hardware at this address. Unregister it, as the
< 	                 * release fuction will take care of freeing the
< 	                 * allocated structure
< 			 */
<                         titan_ge_device[i] = NULL;
<                         platform_device_unregister (pldev);
<                 }
<         }
< 
< 	return 0;
< 
< out_unmap_sram:
< 	iounmap((void *)titan_ge_sram);
< 
< out_unmap_ge:
< 	iounmap((void *)titan_ge_base);
< 
< out:
< 	return -ENOMEM;
< }
< 
< /*
<  * Unregister the Titan GE from the kernel
<  */
< static void __exit titan_ge_cleanup_module(void)
< {
< 	int i;
< 
< 	driver_unregister(&titan_soc_driver);
< 
< 	for (i = 0; i < 3; i++) {
< 		if (titan_ge_device[i]) {
< 			platform_device_unregister (titan_ge_device[i]);
< 			titan_ge_device[i] = NULL;
< 		}
< 	}
< 
< 	iounmap((void *)titan_ge_sram);
< 	iounmap((void *)titan_ge_base);
< }
< 

--------------070608030705010706000200
Content-Type: text/plain;
 name="titan_ge.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="titan_ge.h.diff"

103a104,106
> /* Support for Rx side NAPI */
> #define TITAN_RX_NAPI
> 

--------------070608030705010706000200--
