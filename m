Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2004 22:11:45 +0000 (GMT)
Received: from mail.gmx.net ([IPv6:::ffff:213.165.64.20]:6574 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225007AbUKRWLg>;
	Thu, 18 Nov 2004 22:11:36 +0000
Received: (qmail 17960 invoked by uid 65534); 18 Nov 2004 22:11:29 -0000
Received: from c210132.adsl.hansenet.de (EHLO [192.168.0.1]) (213.39.210.132)
  by mail.gmx.net (mp006) with SMTP; 18 Nov 2004 23:11:29 +0100
X-Authenticated: #947741
Message-ID: <419D1F76.6010603@gmx.net>
Date: Thu, 18 Nov 2004 23:17:26 +0100
From: TheNop <TheNop@gmx.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Titan ethernet driver broken
References: <419D03DE.8090403@gmx.net> <419D04AA.50508@mvista.com> <419D171E.5040507@gmx.net> <419D173E.6050602@mvista.com> <419D1A2D.5000009@gmx.net>
In-Reply-To: <419D1A2D.5000009@gmx.net>
Content-Type: multipart/mixed;
 boundary="------------010709030108050202000102"
Return-Path: <TheNop@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TheNop@gmx.net
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010709030108050202000102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

TheNop wrote:

> Manish Lachwani wrote:
>
>> Hello !
>>
>> Can you please send the diffs using "diff -u" ? It would make the 
>> reading easy
>>
>> Thanks
>> Manish Lachwani
>>
>>
>>
> For sure.
>
> Best regards
> TheNop
>
Ups, something went wrong.
Next try.

CU

--------------010709030108050202000102
Content-Type: text/plain;
 name="module.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="module.h.diff"

--- linux/include/linux/module.h	2004-11-15 12:49:39.000000000 +0100
+++ linux_2_6_8_1/include/linux/module.h	2004-06-28 23:04:16.000000000 +0200
@@ -44,20 +44,6 @@
 	char name[MODULE_NAME_LEN];
 };
 
-struct module;
-
-struct module_attribute {
-        struct attribute attr;
-        ssize_t (*show)(struct module *, char *);
-        ssize_t (*store)(struct module *, const char *, size_t count);
-};
-
-struct module_kobject
-{
-	struct kobject kobj;
-	struct module *mod;
-};
-
 /* These are either module local, or the kernel's dummy ones. */
 extern int init_module(void);
 extern void cleanup_module(void);
@@ -73,8 +59,6 @@
 		  struct exception_table_entry *finish);
 void sort_main_extable(void);
 
-extern struct subsystem module_subsys;
-
 #ifdef MODULE
 #define ___module_cat(a,b) __mod_ ## a ## b
 #define __module_cat(a,b) ___module_cat(a,b)
@@ -157,9 +141,11 @@
            customizations, eg "rh3" or "rusty1".
 
   Using this automatically adds a checksum of the .c files and the
-  local headers in "srcversion".
+  local headers to the end.  Use MODULE_VERSION("") if you want just
+  this.  Macro includes room for this.
 */
-#define MODULE_VERSION(_version) MODULE_INFO(version, _version)
+#define MODULE_VERSION(_version) \
+  MODULE_INFO(version, _version "\0xxxxxxxxxxxxxxxxxxxxxxxx")
 
 /* Given an address, look for it in the exception tables */
 const struct exception_table_entry *search_exception_tables(unsigned long add);
@@ -222,6 +208,23 @@
 	MODULE_STATE_GOING,
 };
 
+/* sysfs stuff */
+struct module_attribute
+{
+	struct attribute attr;
+	struct kernel_param *param;
+};
+
+struct module_kobject
+{
+	/* Everyone should have one of these. */
+	struct kobject kobj;
+
+	/* We always have refcnt, we may have others from module_param(). */
+	unsigned int num_attributes;
+	struct module_attribute attr[0];
+};
+
 /* Similar stuff for section attributes. */
 #define MODULE_SECT_NAME_LEN 32
 struct module_sect_attr
@@ -237,7 +240,6 @@
 	struct module_sect_attr attrs[0];
 };
 
-struct param_kobject;
 
 struct module
 {
@@ -251,7 +253,6 @@
 
 	/* Sysfs stuff. */
 	struct module_kobject *mkobj;
-	struct param_kobject *params_kobject;
 
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
@@ -303,6 +304,9 @@
 
 	/* Destruction function. */
 	void (*exit)(void);
+
+	/* Fake kernel param for refcnt. */
+	struct kernel_param refcnt_param;
 #endif
 
 #ifdef CONFIG_KALLSYMS
@@ -441,11 +445,6 @@
 int unregister_module_notifier(struct notifier_block * nb);
 
 extern void print_modules(void);
-
-struct device_driver;
-void module_add_driver(struct module *, struct device_driver *);
-void module_remove_driver(struct device_driver *);
-
 #else /* !CONFIG_MODULES... */
 #define EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym)
@@ -535,18 +534,6 @@
 static inline void print_modules(void)
 {
 }
-
-struct device_driver;
-struct module;
-
-static inline void module_add_driver(struct module *module, struct device_driver *driver)
-{
-}
-
-static inline void module_remove_driver(struct device_driver *driver)
-{
-}
-
 #endif /* CONFIG_MODULES */
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
@@ -558,27 +545,45 @@
 	char type[64-sizeof(void *)];
 	void *addr;
 };
-
-static inline void __deprecated MODULE_PARM_(void) { }
 #ifdef MODULE
 /* DEPRECATED: Do not use. */
 #define MODULE_PARM(var,type)						    \
 struct obsolete_modparm __parm_##var __attribute__((section("__obsparm"))) = \
-{ __stringify(var), type, &MODULE_PARM_ };
+{ __stringify(var), type };
+
+static inline void __deprecated MOD_INC_USE_COUNT(struct module *module)
+{
+	__unsafe(module);
+
+#if defined(CONFIG_MODULE_UNLOAD) && defined(MODULE)
+	local_inc(&module->ref[get_cpu()].count);
+	put_cpu();
+#else
+	(void)try_module_get(module);
+#endif
+}
+
+static inline void __deprecated MOD_DEC_USE_COUNT(struct module *module)
+{
+	module_put(module);
+}
+
+#define MOD_INC_USE_COUNT	MOD_INC_USE_COUNT(THIS_MODULE)
+#define MOD_DEC_USE_COUNT	MOD_DEC_USE_COUNT(THIS_MODULE)
 #else
-#define MODULE_PARM(var,type) static void __attribute__((__unused__)) *__parm_##var = &MODULE_PARM_;
+#define MODULE_PARM(var,type)
+#define MOD_INC_USE_COUNT	do { } while (0)
+#define MOD_DEC_USE_COUNT	do { } while (0)
 #endif
 
 #define __MODULE_STRING(x) __stringify(x)
 
 /* Use symbol_get and symbol_put instead.  You'll thank me. */
 #define HAVE_INTER_MODULE
-extern void __deprecated inter_module_register(const char *,
-		struct module *, const void *);
-extern void __deprecated inter_module_unregister(const char *);
-extern const void * __deprecated inter_module_get(const char *);
-extern const void * __deprecated inter_module_get_request(const char *,
-		const char *);
-extern void __deprecated inter_module_put(const char *);
+extern void inter_module_register(const char *, struct module *, const void *);
+extern void inter_module_unregister(const char *);
+extern const void *inter_module_get(const char *);
+extern const void *inter_module_get_request(const char *, const char *);
+extern void inter_module_put(const char *);
 
 #endif /* _LINUX_MODULE_H */

--------------010709030108050202000102
Content-Type: text/plain;
 name="titan_ge.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="titan_ge.c.diff"

--- linux/drivers/net/titan_ge.c	2004-11-17 04:08:25.000000000 +0100
+++ linux_2_6_8_1/drivers/net/titan_ge.c	2004-08-19 22:31:47.000000000 +0200
@@ -47,10 +47,13 @@
  */
 
 #include <linux/config.h>
-#include <linux/dma-mapping.h>
+#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/ptrace.h>
+#include <linux/fcntl.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
@@ -59,6 +62,7 @@
 #include <linux/ip.h>
 #include <linux/init.h>
 #include <linux/in.h>
+#include <linux/pci.h>
 
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -95,6 +99,7 @@
 static int titan_ge_open(struct net_device *);
 static int titan_ge_start_xmit(struct sk_buff *, struct net_device *);
 static int titan_ge_stop(struct net_device *);
+static int titan_ge_set_mac_address(struct net_device *, void *);
 
 static unsigned long titan_ge_tx_coal(unsigned long, int);
 
@@ -103,6 +108,7 @@
 static int titan_ge_rx_task(struct net_device *, titan_ge_port_info *);
 static int titan_ge_port_start(struct net_device *, titan_ge_port_info *);
 
+static int titan_ge_init(int);
 static int titan_ge_return_tx_desc(titan_ge_port_info *, int);
 
 /*
@@ -117,20 +123,18 @@
  */
 static unsigned int oom_flag;
 
+#ifdef TITAN_RX_NAPI
 static int titan_ge_poll(struct net_device *netdev, int *budget);
+#endif
 
 static int titan_ge_receive_queue(struct net_device *, unsigned int);
 
-static struct platform_device *titan_ge_device[3];
-
 /* MAC Address */
 extern unsigned char titan_ge_mac_addr_base[6];
 
 unsigned long titan_ge_base;
 static unsigned long titan_ge_sram;
 
-static char titan_string[] = "titan";
-
 /*
  * The Titan GE has two alignment requirements:
  * -> skb->data to be cacheline aligned (32 byte)
@@ -448,6 +452,7 @@
 #endif
 		titan_ge_free_tx_queue(titan_ge_eth);
 
+#ifdef TITAN_RX_NAPI
 	/* Handle the Rx next */
 #ifdef CONFIG_SMP
 	if ( (eth_int_cause1 & 0x10101) ||
@@ -465,16 +470,17 @@
 			if (port_num == 1)
 				ack &= ~(0x300);
 
-			if (port_num == 2)
-				ack &= ~(0x30000);
-
 			/* Interrupts have been disabled */
 			TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_IE, ack);
 
 			__netif_rx_schedule(netdev);
 		}
 	}
+#else
+	titan_ge_free_tx_queue(titan_ge_eth);
+	titan_ge_receive_queue(netdev, 0);
 
+#endif
 	/* Handle error interrupts */
 	if (eth_int_cause_error && (eth_int_cause_error != 0x2)) {
 		printk(KERN_ERR
@@ -609,21 +615,20 @@
 static int titan_ge_rx_return_buff(titan_ge_port_info * titan_ge_port,
 					struct sk_buff *skb)
 {
-	struct device *device = &titan_ge_device[titan_ge_port->port_num]->dev;
-	volatile titan_ge_rx_desc *rx_desc;
 	int rx_used_desc;
+	volatile titan_ge_rx_desc *rx_desc;
 
 	rx_used_desc = titan_ge_port->rx_used_desc_q;
 	rx_desc = &(titan_ge_port->rx_desc_area[rx_used_desc]);
 
 #ifdef TITAN_GE_JUMBO_FRAMES
 	rx_desc->buffer_addr =
-	       dma_map_single(device, skb->data, TITAN_GE_JUMBO_BUFSIZE - 2,
-			      DMA_FROM_DEVICE);
+               pci_map_single(0, skb->data, TITAN_GE_JUMBO_BUFSIZE - 2,
+                                            PCI_DMA_FROMDEVICE);
 #else
 	rx_desc->buffer_addr =
-		dma_map_single(device, skb->data, TITAN_GE_STD_BUFSIZE - 2,
-			       DMA_FROM_DEVICE);
+                pci_map_single(0, skb->data, TITAN_GE_STD_BUFSIZE - 2,
+                                            PCI_DMA_FROMDEVICE);
 #endif
 
 	titan_ge_port->rx_skb[rx_used_desc] = skb;
@@ -720,7 +725,6 @@
 	volatile unsigned long reg_data, reg_data1;
 	int port_num = titan_port->port_num;
 	int count = 0;
-	unsigned long reg_data_1;
 
 	if (config_done == 0) {
 		reg_data = TITAN_GE_READ(0x0004);
@@ -734,9 +738,11 @@
 		reg_data = TITAN_GE_READ(TITAN_GE_TSB_CTRL_1);
 		reg_data |= 0x00000700;
 		reg_data &= ~(0x00800000); /* Fencing */
-
+#ifdef TITAN_RX_NAPI
 		TITAN_GE_WRITE(0x000c, 0x00001100);
-
+#else
+		TITAN_GE_WRITE(0x000c, 0x00000100); /* No WCIMODE */
+#endif
 		TITAN_GE_WRITE(TITAN_GE_TSB_CTRL_1, reg_data);
 
 		/* Set the CPU Resource Limit register */
@@ -746,8 +752,10 @@
 		TITAN_GE_WRITE(0x0068, 0x4);
 	}
 
+#ifdef TITAN_RX_NAPI
 	titan_port->tx_threshold = 0;
 	titan_port->rx_threshold = 0;
+#endif
 
 	/* We need to write the descriptors for Tx and Rx */
 	TITAN_GE_WRITE((TITAN_GE_CHANNEL0_TX_DESC + (port_num << 8)),
@@ -902,52 +910,6 @@
 		TITAN_GE_WRITE(0x494c, reg_data);
 	}
 
-	/*
-	 * Titan 1.2 revision does support port #2
-	 */
-	if (port_num == 2) {
-		/*
-		 * Put the descriptors in the SRAM
-		 */
-		reg_data = TITAN_GE_READ(0x48a0);
-
-		reg_data |= 0x100000;
-		reg_data |= (0xff << 10) | (2*(0xff + 1));
-
-		TITAN_GE_WRITE(0x48a0, reg_data);
-		/*
-		 * BAV2,BAV and DAV settings for the Rx FIFO
-		 */
-		reg_data1 = TITAN_GE_READ(0x48a4);
-		reg_data1 |= ( (0x10 << 20) | (0x10 << 10) | 0x1);
-		TITAN_GE_WRITE(0x48a4, reg_data1);
-
-		reg_data &= ~(0x00100000);
-		reg_data |= 0x200000;
-
-		TITAN_GE_WRITE(0x48a0, reg_data);
-		
-		reg_data = TITAN_GE_READ(0x4958);
-		reg_data |= 0x100000;
-
-		TITAN_GE_WRITE(0x4958, reg_data);
-		reg_data |= (0xff << 10) | (2*(0xff + 1));
-		TITAN_GE_WRITE(0x4958, reg_data);
-
-		/*
-		 * BAV2, BAV and DAV settings for the Tx FIFO
-		 */
-		reg_data1 = TITAN_GE_READ(0x495c);
-		reg_data1 = ( (0x1 << 20) | (0x1 << 10) | 0x10);
-
-		TITAN_GE_WRITE(0x495c, reg_data1);
-
-		reg_data &= ~(0x00100000);
-		reg_data |= 0x200000;
-
-		TITAN_GE_WRITE(0x4958, reg_data);
-	}
-
 	if (port_num == 2) {
 		reg_data = TITAN_GE_READ(0x48a0);
 
@@ -992,28 +954,6 @@
 	 * Step 3:  TRTG block enable
 	 */
 	reg_data = TITAN_GE_READ(TITAN_GE_TRTG_CONFIG + (port_num << 12));
-
-	/*
-	 * This is the 1.2 revision of the chip. It has fix for the
-	 * IP header alignment. Now, the IP header begins at an
-	 * aligned address and this wont need an extra copy in the
-	 * driver. This performance drawback existed in the previous
-	 * versions of the silicon
-	 */
-	reg_data_1 = TITAN_GE_READ(0x103c + (port_num << 12));
-	reg_data_1 |= 0x40000000;
-	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);
-
-	reg_data_1 |= 0x04000000;
-	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);
-
-	mdelay(5);
-
-	reg_data_1 &= ~(0x04000000);
-	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);
-
-	mdelay(5);
-
 	reg_data |= 0x0001;
 	TITAN_GE_WRITE((TITAN_GE_TRTG_CONFIG + (port_num << 12)), reg_data);
 
@@ -1071,9 +1011,6 @@
 		reg_data1 |= 0x300;
 	}
 
-	if (port_num == 2)
-		reg_data1 |= 0x30000;
-
 	TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_IE, reg_data1);
 	TITAN_GE_WRITE(0x003c, 0x300);
 
@@ -1104,15 +1041,15 @@
 static void titan_ge_tx_queue(titan_ge_port_info * titan_ge_eth,
 				struct sk_buff * skb)
 {
-	struct device *device = &titan_ge_device[titan_ge_eth->port_num]->dev;
-	unsigned int curr_desc = titan_ge_eth->tx_curr_desc_q;
 	volatile titan_ge_tx_desc *tx_curr;
 	int port_num = titan_ge_eth->port_num;
+	unsigned int curr_desc =
+			titan_ge_eth->tx_curr_desc_q;
 
 	tx_curr = &(titan_ge_eth->tx_desc_area[curr_desc]);
 	tx_curr->buffer_addr =
-		dma_map_single(device, skb->data, skb_headlen(skb),
-			       DMA_TO_DEVICE);
+		pci_map_single(0, skb->data, skb_headlen(skb),
+					PCI_DMA_TODEVICE);
 
 	titan_ge_eth->tx_skb[curr_desc] = (struct sk_buff *) skb;
 	tx_curr->buffer_len = skb_headlen(skb);
@@ -1131,6 +1068,19 @@
 		 &titan_ge_eth->tx_desc_area[titan_ge_eth->tx_curr_desc_q]);
 }
 
+#ifndef TITAN_RX_NAPI
+/*
+ * Coalescing for the Rx path
+ */
+static unsigned long titan_ge_rx_coal(unsigned long delay, int port)
+{
+	TITAN_GE_WRITE(TITAN_GE_INT_COALESCING, delay);
+	TITAN_GE_WRITE(0x5038, delay);
+
+	return delay;
+}
+#endif
+
 /*
  * Actually does the open of the Ethernet device
  */
@@ -1138,7 +1088,6 @@
 {
 	titan_ge_port_info *titan_ge_eth = netdev_priv(netdev);
 	unsigned int port_num = titan_ge_eth->port_num;
-	struct device *device = &titan_ge_device[port_num]->dev;
 	unsigned int size, phy_reg;
 	unsigned long reg_data;
 	int err = 0;
@@ -1187,13 +1136,6 @@
 		titan_ge_eth->tx_dma = TITAN_SRAM_BASE + 0x100;
 	}
 
-	if (port_num == 2) {
-		titan_ge_eth->tx_desc_area =
-		    (titan_ge_tx_desc *) (titan_ge_sram + 0x200);
-
-		titan_ge_eth->tx_dma = TITAN_SRAM_BASE + 0x200;
-	}
-
 	if (!titan_ge_eth->tx_desc_area) {
 		printk(KERN_ERR
 		       "%s: Cannot allocate Tx Ring (size %d bytes) for port %d\n",
@@ -1228,12 +1170,6 @@
 		titan_ge_eth->rx_dma = TITAN_SRAM_BASE + 0x1100;
 	}
 
-	if (port_num == 2) {
-		titan_ge_eth->rx_desc_area =
-			(titan_ge_rx_desc *)(titan_ge_sram + 0x1200);
-		titan_ge_eth->rx_dma = TITAN_SRAM_BASE + 0x1200;
-	}
-
 	if (!titan_ge_eth->rx_desc_area) {
 		printk(KERN_ERR
 		       "%s: Cannot allocate Rx Ring (size %d bytes)\n",
@@ -1243,7 +1179,7 @@
 		       "%s: Freeing previously allocated TX queues...",
 		       netdev->name);
 
-		dma_free_coherent(device, titan_ge_eth->tx_desc_area_size,
+		pci_free_consistent(0, titan_ge_eth->tx_desc_area_size,
 				    (void *) titan_ge_eth->tx_desc_area,
 				    titan_ge_eth->tx_dma);
 
@@ -1276,7 +1212,19 @@
 	 * (8 x 64 nanoseconds) to determine when an interrupt should
 	 * be sent to the CPU.
 	 */
+#ifndef TITAN_RX_NAPI
+	/* 
+	 * If NAPI is turned on, we disable Rx interrupts
+	 * completely. So, we dont need coalescing then. Tx side
+	 * coalescing set to very high value. Maybe, disable
+	 * Tx side interrupts completely
+	 */
+	if (TITAN_GE_RX_COAL) {
+		titan_ge_eth->rx_int_coal =
+		    titan_ge_rx_coal(TITAN_GE_RX_COAL, port_num);
+	} 
 
+#endif
 	if (TITAN_GE_TX_COAL) {
 		titan_ge_eth->tx_int_coal =
 		    titan_ge_tx_coal(TITAN_GE_TX_COAL, port_num);
@@ -1406,6 +1354,45 @@
 }
 
 /*
+ * Do the slowpath route. This route is kicked off
+ * when the IP header is misaligned. Grrr ..
+ */
+static int titan_ge_slowpath(struct sk_buff *skb,
+				titan_ge_packet *packet,
+				struct net_device *netdev)
+{
+	struct sk_buff *copy_skb;
+
+	copy_skb = dev_alloc_skb(packet->len + 2);
+
+	if (!copy_skb) {
+		dev_kfree_skb_any(packet->skb);
+		return -1;
+	}
+
+	copy_skb->dev = netdev;
+	skb_reserve(copy_skb, 2);
+	skb_put(copy_skb, packet->len);
+
+	memcpy(copy_skb->data, skb->data, packet->len);
+
+	/* Titan supports Rx checksum offload */
+	copy_skb->ip_summed = CHECKSUM_HW;
+	copy_skb->csum = packet->checksum;
+
+	copy_skb->protocol = eth_type_trans(copy_skb, netdev);
+
+	dev_kfree_skb_any(packet->skb);
+#ifdef TITAN_RX_NAPI
+	netif_receive_skb(copy_skb);
+#else
+	netif_rx(copy_skb);
+#endif
+
+	return 0;
+}
+
+/*
  * Threshold beyond which we do the cleaning of
  * Tx queue and new allocation for the Rx
  * queue
@@ -1434,10 +1421,11 @@
 
 		titan_ge_eth->rx_ring_skbs--;
 
+#ifdef TITAN_RX_NAPI
 		if (--titan_ge_eth->rx_work_limit < 0)
 			break;
 		received_packets++;
-
+#endif
 		stats->rx_packets++;
 		stats->rx_bytes += packet.len;
 
@@ -1456,36 +1444,41 @@
 		 * idea is to cut down the number of checks and improve
 		 * the fastpath.
 		 */
+		skb_put(skb, packet.len);
 
-		skb_put(skb, packet.len - 2);
-
-		/*
-		 * Increment data pointer by two since thats where
-		 * the MAC starts
-		 */
-		skb_reserve(skb, 2);
-		skb->protocol = eth_type_trans(skb, netdev);
-		netif_receive_skb(skb);
+		if (titan_ge_slowpath(skb, &packet, netdev) < 0) 
+			goto out_next;
 
+#ifdef TITAN_RX_NAPI
 		if (titan_ge_eth->rx_threshold > RX_THRESHOLD) {
 			ack = titan_ge_rx_task(netdev, titan_ge_eth);
 			TITAN_GE_WRITE((0x5048 + (port_num << 8)), ack);
 			titan_ge_eth->rx_threshold = 0;
 		} else
 			titan_ge_eth->rx_threshold++;
+#else
+		ack = titan_ge_rx_task(netdev, titan_ge_eth);
+		TITAN_GE_WRITE((0x5048 + (port_num << 8)), ack);
+#endif
 
+out_next:
+
+#ifdef TITAN_RX_NAPI
 		if (titan_ge_eth->tx_threshold > TX_THRESHOLD) {
 			titan_ge_eth->tx_threshold = 0;
 			titan_ge_free_tx_queue(titan_ge_eth);
 		}
 		else
 			titan_ge_eth->tx_threshold++;
+#endif
 
 	}
 	return received_packets;
 }
 
 
+#ifdef TITAN_RX_NAPI
+
 /*
  * Enable the Rx side interrupts
  */
@@ -1587,6 +1580,7 @@
 
 	return 0;
 }
+#endif
 
 /*
  * Close the network device
@@ -1598,6 +1592,7 @@
 	spin_lock_irq(&(titan_ge_eth->lock));
 	titan_ge_eth_stop(netdev);
 	free_irq(netdev->irq, netdev);
+	MOD_DEC_USE_COUNT;
 	spin_unlock_irq(&titan_ge_eth->lock);
 
 	return TITAN_OK;
@@ -1643,8 +1638,7 @@
 		     titan_ge_eth->tx_ring_skbs);
 
 #ifndef TITAN_RX_RING_IN_SRAM
-	dma_free_coherent(&titan_ge_device[port_num]->dev,
-			  titan_ge_eth->tx_desc_area_size,
+	pci_free_consistent(0, titan_ge_eth->tx_desc_area_size,
 			  (void *) titan_ge_eth->tx_desc_area,
 			  titan_ge_eth->tx_dma);
 #endif
@@ -1690,8 +1684,7 @@
 		       titan_ge_eth->rx_ring_skbs);
 
 #ifndef TITAN_RX_RING_IN_SRAM
-	dma_free_coherent(&titan_ge_device[port_num]->dev,
-			  titan_ge_eth->rx_desc_area_size,
+	pci_free_consistent(0, titan_ge_eth->rx_desc_area_size,
 			  (void *) titan_ge_eth->rx_desc_area,
 			  titan_ge_eth->rx_dma);
 #endif
@@ -1752,22 +1745,21 @@
 		       ((p_addr[3] << 8) | p_addr[2]));
 	TITAN_GE_WRITE((TITAN_GE_RMAC_STATION_LOW + (port_num << 12)),
 		       ((p_addr[1] << 8) | p_addr[0]));
+
+	return;
 }
 
 /*
  * Set the MAC address of the Ethernet device
  */
-static int titan_ge_set_mac_address(struct net_device *dev, void *addr)
+int titan_ge_set_mac_address(struct net_device *netdev, void *addr)
 {
-	titan_ge_port_info *tp = netdev_priv(dev);
-	struct sockaddr *sa = addr;
-
-	memcpy(dev->dev_addr, sa->sa_data, dev->addr_len);
+	int i;
 
-	spin_lock_irq(&tp->lock);
-	titan_ge_update_mac_address(dev);
-	spin_unlock_irq(&tp->lock);
+	for (i = 0; i < 6; i++)
+		netdev->dev_addr[i] = ((unsigned char *) addr)[i + 2];
 
+	titan_ge_update_mac_address(netdev);
 	return 0;
 }
 
@@ -1782,6 +1774,65 @@
 }
 
 /*
+ * Register the Titan GE with the kernel
+ */
+static int __init titan_ge_init_module(void)
+{
+	unsigned int version, device;
+
+	printk(KERN_NOTICE
+	       "PMC-Sierra TITAN 10/100/1000 Ethernet Driver \n");
+
+	titan_ge_base = (unsigned long) ioremap(TITAN_GE_BASE, TITAN_GE_SIZE);
+	if (!titan_ge_base) {
+		printk("Mapping Titan GE failed\n");
+		goto out;
+	}
+
+	device = TITAN_GE_READ(TITAN_GE_DEVICE_ID);
+	version = (device & 0x000f0000) >> 16;
+	device &= 0x0000ffff;
+
+	printk(KERN_NOTICE "Device Id : %x,  Version : %x \n", device, version);
+
+#ifdef TITAN_RX_RING_IN_SRAM
+	titan_ge_sram = (unsigned long) ioremap(TITAN_SRAM_BASE,
+	                                        TITAN_SRAM_SIZE);
+	if (!titan_ge_sram) {
+		printk("Mapping Titan SRAM failed\n");
+		goto out_unmap_ge;
+	}
+#endif
+
+	/* Register only one port */ 
+	if (titan_ge_init(0)) 
+		printk(KERN_ERR
+		       "Error registering the TITAN Ethernet driver"
+			"for port 0 \n");
+	
+	if (titan_ge_init(1)) 
+		printk(KERN_ERR "Error registering the TITAN Ethernet" 
+				"driver for port 1\n");
+
+	return 0;
+
+out_unmap_ge:
+	iounmap((void *)titan_ge_base);
+
+out:
+	return -ENOMEM;
+}
+
+/*
+ * Unregister the Titan GE from the kernel
+ */
+static void __init titan_ge_cleanup_module(void)
+{
+	iounmap((void *)titan_ge_sram);
+	iounmap((void *)titan_ge_base);
+}
+
+/*
  * Initialize the Rx descriptor ring for the Titan Ge
  */
 static int titan_ge_init_rx_desc_ring(titan_ge_port_info * titan_eth_port,
@@ -1875,11 +1926,10 @@
 /*
  * Initialize the device as an Ethernet device
  */
-static int __init titan_ge_probe(struct device *device)
+static int titan_ge_init(int port)
 {
 	titan_ge_port_info *titan_ge_eth;
 	struct net_device *netdev;
-	int port = to_platform_device(device)->id;
 	int err;
 
 	netdev = alloc_etherdev(sizeof(titan_ge_port_info));
@@ -1899,10 +1949,11 @@
 	netdev->tx_timeout = titan_ge_tx_timeout;
 	netdev->watchdog_timeo = 2 * HZ;
 
+#ifdef TITAN_RX_NAPI
 	/* Set these to very high values */
 	netdev->poll = titan_ge_poll;
 	netdev->weight = 64;
-
+#endif
 	netdev->tx_queue_len = TITAN_GE_TX_QUEUE;
 	netif_carrier_off(netdev);
 	netdev->base_addr = 0;
@@ -1936,7 +1987,11 @@
 	       netdev->dev_addr[3], netdev->dev_addr[4],
 	       netdev->dev_addr[5]);
 
+#ifdef TITAN_RX_NAPI
 	printk(KERN_NOTICE "Rx NAPI supported, Tx Coalescing ON \n");
+#else
+	printk(KERN_NOTICE "Rx and Tx Coalescing ON \n");
+#endif
 
 	return 0;
 
@@ -2013,122 +2068,6 @@
 	return delay;
 }
 
-static struct device_driver titan_soc_driver = {
-	.name   = titan_string,
-	.bus    = &platform_bus_type,
-	.probe  = titan_ge_probe,
-	.remove = __devexit_p(titan_device_remove),
-};
-
-static void titan_platform_release (struct device *device)
-{
-	struct platform_device *pldev;
-
-	/* free device */
-	pldev = to_platform_device (device);
-	kfree (pldev);
-}
-
-/*
- * Register the Titan GE with the kernel
- */
-static int __init titan_ge_init_module(void)
-{
-	struct platform_device *pldev;
-	unsigned int version, device;
-	int i;
-
-	printk(KERN_NOTICE
-	       "PMC-Sierra TITAN 10/100/1000 Ethernet Driver \n");
-
-	titan_ge_base = (unsigned long) ioremap(TITAN_GE_BASE, TITAN_GE_SIZE);
-	if (!titan_ge_base) {
-		printk("Mapping Titan GE failed\n");
-		goto out;
-	}
-
-	device = TITAN_GE_READ(TITAN_GE_DEVICE_ID);
-	version = (device & 0x000f0000) >> 16;
-	device &= 0x0000ffff;
-
-	printk(KERN_NOTICE "Device Id : %x,  Version : %x \n", device, version);
-
-#ifdef TITAN_RX_RING_IN_SRAM
-	titan_ge_sram = (unsigned long) ioremap(TITAN_SRAM_BASE,
-						TITAN_SRAM_SIZE);
-	if (!titan_ge_sram) {
-		printk("Mapping Titan SRAM failed\n");
-		goto out_unmap_ge;
-	}
-#endif
-
-	if (driver_register(&titan_soc_driver)) {
-		printk(KERN_ERR "Driver registration failed\n");
-		goto out_unmap_sram;
-	}
-
-	for (i = 0; i < 3; i++) {
-		titan_ge_device[i] = NULL;
-
-	        if (!(pldev = kmalloc (sizeof (*pldev), GFP_KERNEL)))
-	                continue;
-
-                memset (pldev, 0, sizeof (*pldev));
-                pldev->name		= titan_string;
-                pldev->id		= i;
-                pldev->dev.release	= titan_platform_release;
-                titan_ge_device[i]	= pldev;
-
-                if (platform_device_register (pldev)) {
-                        kfree (pldev);
-                        titan_ge_device[i] = NULL;
-                        continue;
-                }
-                                                                                
-                if (!pldev->dev.driver) {
-	                /*
-			 * The driver was not bound to this device, there was
-	                 * no hardware at this address. Unregister it, as the
-	                 * release fuction will take care of freeing the
-	                 * allocated structure
-			 */
-                        titan_ge_device[i] = NULL;
-                        platform_device_unregister (pldev);
-                }
-        }
-
-	return 0;
-
-out_unmap_sram:
-	iounmap((void *)titan_ge_sram);
-
-out_unmap_ge:
-	iounmap((void *)titan_ge_base);
-
-out:
-	return -ENOMEM;
-}
-
-/*
- * Unregister the Titan GE from the kernel
- */
-static void __exit titan_ge_cleanup_module(void)
-{
-	int i;
-
-	driver_unregister(&titan_soc_driver);
-
-	for (i = 0; i < 3; i++) {
-		if (titan_ge_device[i]) {
-			platform_device_unregister (titan_ge_device[i]);
-			titan_ge_device[i] = NULL;
-		}
-	}
-
-	iounmap((void *)titan_ge_sram);
-	iounmap((void *)titan_ge_base);
-}
-
 MODULE_AUTHOR("Manish Lachwani <lachwani@pmc-sierra.com>");
 MODULE_DESCRIPTION("Titan GE Ethernet driver");
 MODULE_LICENSE("GPL");

--------------010709030108050202000102
Content-Type: text/plain;
 name="titan_ge.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="titan_ge.h.diff"

--- linux/drivers/net/titan_ge.h	2004-10-26 03:46:16.000000000 +0200
+++ linux_2_6_8_1/drivers/net/titan_ge.h	2004-08-19 22:31:47.000000000 +0200
@@ -101,6 +101,9 @@
 /* Debugging info only */
 #undef TITAN_DEBUG
 
+/* Support for Rx side NAPI */
+#define TITAN_RX_NAPI
+
 /* Keep the rings in the Titan's SSRAM */
 #define TITAN_RX_RING_IN_SRAM
 

--------------010709030108050202000102--
