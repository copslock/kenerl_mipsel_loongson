Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2005 20:34:37 +0000 (GMT)
Received: from amsfep18-int.chello.nl ([IPv6:::ffff:213.46.243.20]:34868 "EHLO
	amsfep19-int.chello.nl") by linux-mips.org with ESMTP
	id <S8225240AbVA0UeD>; Thu, 27 Jan 2005 20:34:03 +0000
Received: from [127.0.0.1] (really [62.195.248.222])
          by amsfep19-int.chello.nl
          (InterMail vM.6.01.03.05 201-2131-111-107-20040910) with ESMTP
          id <20050127203354.ERTQ16287.amsfep19-int.chello.nl@[127.0.0.1]>
          for <linux-mips@linux-mips.org>; Thu, 27 Jan 2005 21:33:54 +0100
Message-ID: <41F9503E.5030004@amsat.org>
Date:	Thu, 27 Jan 2005 21:34:06 +0100
From:	Jeroen Vreeken <pe1rxq@amsat.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] ADM5120 for 2.6.10
Content-Type: multipart/mixed;
 boundary="------------050005050601070706030904"
Return-Path: <pe1rxq@amsat.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pe1rxq@amsat.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050005050601070706030904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I finally succeeded in getting 2.6.10 working on my adm5120 router.
Attached is a patch against 2.6.10 with the needed changes.

First a list of what it does NOT do:
-ethernet
-usb
-pci (my board doesn't have pci)
-anything usefull :)

What it does do:
-Boot
-Serial support (with improved timing compared to the official 2.4.18 
kernels)
-Simplified init code (the 2.4.18 code was way to complex)

I also found the most probable reason people had problems porting the 
released sources to other kernels: the bootloader jumps to a fixed 
address that just happens to be the kernel_entry in 2.4.18
I 'solved' it by adding a jump on this address to the real kernel_entry 
(which is at the other end of the kernel in 2.6)
I also had some great fun figuring out how the hell initramfs is 
supposed to work.... To finally find out after two days I had one slash 
to little in the configured path..... I also found that standard 2.6.10 
doesn't support symlinks and my initramfs ended up being 14Mb.

Next I plan to port the ethernet driver and usb. I don't think I will 
port the led driver as is, its much easier to just offer a character 
device with access to the GPIO port than the 'LED BLINK' stuff used in 
the ADMtek led driver.

Jeroen


--------------050005050601070706030904
Content-Type: text/x-patch;
 name="linux-2.6.10-adm.1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.10-adm.1.diff"

diff -ruN linux-2.6.10/Makefile linux-2.6.10-adm.1/Makefile
--- linux-2.6.10/Makefile	2004-12-24 22:35:01.000000000 +0100
+++ linux-2.6.10-adm.1/Makefile	2005-01-27 21:07:04.000000000 +0100
@@ -4,6 +4,8 @@
 EXTRAVERSION =
 NAME=Woozy Numbat
 
+ARCH=mips
+
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
 # More info can be located in ./README
@@ -722,6 +724,10 @@
 vmlinux: $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) $(kallsyms.o) FORCE
 	$(call if_changed_rule,vmlinux__)
 
+vmlinuz: vmlinux
+	$(OBJCOPY) -O binary vmlinux vmlinux.bin
+	gzip vmlinux.bin -c >vmlinuz
+
 # The actual objects are generated when descending, 
 # make sure no implicit rule kicks in
 $(sort $(vmlinux-init) $(vmlinux-main)) $(vmlinux-lds): $(vmlinux-dirs) ;
diff -ruN linux-2.6.10/arch/mips/Kconfig linux-2.6.10-adm.1/arch/mips/Kconfig
--- linux-2.6.10/arch/mips/Kconfig	2004-12-24 22:34:45.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/Kconfig	2005-01-27 21:06:17.000000000 +0100
@@ -46,6 +46,10 @@
 	  the MIPS architecture, check out the Linux/MIPS FAQ on the WWW at
 	  <http://www.linux-mips.org/>.
 
+config MIPS_AM5120
+	bool "Support for ADM5120 board"
+	select DMA_NONCOHERENT
+
 config MIPS_MAGNUM_4000
 	bool "Support for MIPS Magnum 4000"
 	depends on MACH_JAZZ
diff -ruN linux-2.6.10/arch/mips/Makefile linux-2.6.10-adm.1/arch/mips/Makefile
--- linux-2.6.10/arch/mips/Makefile	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/Makefile	2005-01-27 21:06:16.000000000 +0100
@@ -49,7 +49,7 @@
 endif
 
 ifdef CONFIG_CROSSCOMPILE
-CROSS_COMPILE		:= $(tool-prefix)
+CROSS_COMPILE		:= /export/tools/bin/$(tool-prefix)
 endif
 
 ifdef CONFIG_BUILD_ELF64
@@ -232,6 +232,13 @@
 load-$(CONFIG_MACH_JAZZ)	+= 0xffffffff80080000
 
 #
+# ADMtek 5120
+#
+
+core-$(CONFIG_MIPS_AM5120)	+= arch/mips/am5120/
+load-$(CONFIG_MIPS_AM5120)	+= 0xffffffff80002000
+
+#
 # Common Alchemy Au1x00 stuff
 #
 core-$(CONFIG_SOC_AU1X00)	+= arch/mips/au1000/common/
diff -ruN linux-2.6.10/arch/mips/am5120/5120_rtc.c linux-2.6.10-adm.1/arch/mips/am5120/5120_rtc.c
--- linux-2.6.10/arch/mips/am5120/5120_rtc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/am5120/5120_rtc.c	2005-01-27 21:06:17.000000000 +0100
@@ -0,0 +1,73 @@
+/*****************************************************************************
+;
+;   (C) Unpublished Work of ADMtek Incorporated.  All Rights Reserved.
+;
+;       THIS WORK IS AN UNPUBLISHED WORK AND CONTAINS CONFIDENTIAL,
+;       PROPRIETARY AND TRADESECRET INFORMATION OF ADMTEK INCORPORATED.
+;       ACCESS TO THIS WORK IS RESTRICTED TO (I) ADMTEK EMPLOYEES WHO HAVE A
+;       NEED TO KNOW TO PERFORM TASKS WITHIN THE SCOPE OF THEIR ASSIGNMENTS
+;       AND (II) ENTITIES OTHER THAN ADMTEK WHO HAVE ENTERED INTO APPROPRIATE
+;       LICENSE AGREEMENTS.  NO PART OF THIS WORK MAY BE USED, PRACTICED,
+;       PERFORMED, COPIED, DISTRIBUTED, REVISED, MODIFIED, TRANSLATED,
+;       ABBRIDGED, CONDENSED, EXPANDED, COLLECTED, COMPILED, LINKED, RECAST,
+;       TRANSFORMED OR ADAPTED WITHOUT THE PRIOR WRITTEN CONSENT OF ADMTEK.
+;       ANY USE OR EXPLOITATION OF THIS WORK WITHOUT AUTHORIZATION COULD
+;       SUBJECT THE PERPERTRATOR TO CRIMINAL AND CIVIL LIABILITY.
+;
+;------------------------------------------------------------------------------
+;
+;    Project : ADM5120
+;    Creator : daniell@admtek.com.tw
+;    File    : arch/mips/am5120/5120_rtc.c
+;	 Date    : 2003.3.4
+;    Abstract: 
+;
+;Modification History:
+;
+;*****************************************************************************/
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/serial.h>
+#include <linux/types.h>
+#include <linux/string.h>
+
+#include <asm/reboot.h>
+#include <asm/io.h>
+#include <asm/time.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+
+#include <linux/mc146818rtc.h>
+#include <asm/am5120/adm5120.h>
+#include <asm-arm/rtc.h>
+
+struct rtc_ops *rtc_ops=NULL;
+/*
+static unsigned char am5120_rtc_read_data(unsigned long addr)
+{
+	//outb(addr, MALTA_RTC_ADR_REG);
+	//return inb(MALTA_RTC_DAT_REG);
+	return 0;
+}
+
+static void am5120_rtc_write_data(unsigned char data, unsigned long addr)
+{
+	//outb(addr, MALTA_RTC_ADR_REG);
+	//outb(data, MALTA_RTC_DAT_REG);
+}
+
+static int am5120_rtc_bcd_mode(void)
+{
+	return 0;
+}
+
+struct rtc_ops am5120_rtc_ops = {
+	&am5120_rtc_read_data,
+	&am5120_rtc_write_data,
+	&am5120_rtc_bcd_mode
+};
+*/
diff -ruN linux-2.6.10/arch/mips/am5120/Makefile linux-2.6.10-adm.1/arch/mips/am5120/Makefile
--- linux-2.6.10/arch/mips/am5120/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/am5120/Makefile	2005-01-27 21:06:17.000000000 +0100
@@ -0,0 +1,3 @@
+
+obj-y	:= setup.o prom.o irq.o serial.o memory.o mipsIRQ.o time.o pci.o
+# 5120_rtc.o led.o
diff -ruN linux-2.6.10/arch/mips/am5120/irq.c linux-2.6.10-adm.1/arch/mips/am5120/irq.c
--- linux-2.6.10/arch/mips/am5120/irq.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/am5120/irq.c	2005-01-27 21:06:17.000000000 +0100
@@ -0,0 +1,181 @@
+/*****************************************************************************
+;
+;   (C) Unpublished Work of ADMtek Incorporated.  All Rights Reserved.
+;
+;       THIS WORK IS AN UNPUBLISHED WORK AND CONTAINS CONFIDENTIAL,
+;       PROPRIETARY AND TRADESECRET INFORMATION OF ADMTEK INCORPORATED.
+;       ACCESS TO THIS WORK IS RESTRICTED TO (I) ADMTEK EMPLOYEES WHO HAVE A
+;       NEED TO KNOW TO PERFORM TASKS WITHIN THE SCOPE OF THEIR ASSIGNMENTS
+;       AND (II) ENTITIES OTHER THAN ADMTEK WHO HAVE ENTERED INTO APPROPRIATE
+;       LICENSE AGREEMENTS.  NO PART OF THIS WORK MAY BE USED, PRACTICED,
+;       PERFORMED, COPIED, DISTRIBUTED, REVISED, MODIFIED, TRANSLATED,
+;       ABBRIDGED, CONDENSED, EXPANDED, COLLECTED, COMPILED, LINKED, RECAST,
+;       TRANSFORMED OR ADAPTED WITHOUT THE PRIOR WRITTEN CONSENT OF ADMTEK.
+;       ANY USE OR EXPLOITATION OF THIS WORK WITHOUT AUTHORIZATION COULD
+;       SUBJECT THE PERPERTRATOR TO CRIMINAL AND CIVIL LIABILITY.
+;
+;------------------------------------------------------------------------------
+;
+;    Project : ADM5120
+;    Creator : daniell@admtek.com.tw
+;    File    : arch/mips/am5120/irq.c
+;	 Date    : 2003.3.4
+;    Abstract: 
+;
+;Modification History:
+;
+;	Jeroen Vreeken (pe1rxq@amsat.org)
+;	Simplified and merged with 5120_int.c
+;
+;	Includes code by:
+;	Carsten Langgaard, carstenl@mips.com
+;	Copyright (C) 2000, 2001 MIPS Technologies, Inc.
+;	Copyright (C) 2001 Ralf Baechle
+;
+;*****************************************************************************/
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel_stat.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <linux/pm.h>
+
+#include <asm/irq.h>
+#include <asm/mipsregs.h>
+#include <asm/gdb-stub.h>
+
+#include <asm/am5120/adm5120.h>
+
+extern void breakpoint(void);
+extern int setup_irq(unsigned int irq, struct irqaction *irqaction);
+extern irq_desc_t irq_desc[];
+extern asmlinkage void mipsIRQ(void);
+
+int mips_int_lock(void);
+void mips_int_unlock(int);
+
+static spinlock_t mips_irq_lock = SPIN_LOCK_UNLOCKED;
+
+void am5120_hw0_irqdispatch(struct pt_regs *regs)
+{
+	unsigned long flags;
+	unsigned long intsrc;
+	int i;
+
+	/* We don't have multiple cpus, is this locking really needed???
+		- Jeroen
+	 */
+	spin_lock_irqsave(&mips_irq_lock, flags);
+
+	intsrc = ADM5120_INTC_REG(IRQ_STATUS_REG) & IRQ_MASK;
+
+	for (i = 0; intsrc; intsrc >>= 1, i++)
+		if (intsrc & 0x1)
+			do_IRQ(i, regs);
+
+	spin_unlock_irqrestore(&mips_irq_lock, flags);
+}
+
+
+void enable_am5120_irq(unsigned int irq)
+{
+	int s;
+
+	/* Disable all interrupts (FIQ/IRQ) */
+	s = mips_int_lock();
+
+	if ((irq < 0) || (irq > INT_LVL_MAX)) 
+		goto err_exit;
+
+	ADM5120_INTC_REG(IRQ_ENABLE_REG) = (1<<irq);
+
+err_exit:
+
+	/* Restore the interrupts states */
+	mips_int_unlock(s);
+}
+
+
+void disable_am5120_irq(unsigned int irq)
+{
+	int s;
+
+	/* Disable all interrupts (FIQ/IRQ) */
+	s = mips_int_lock();
+
+	if ((irq < 0) || (irq > INT_LVL_MAX)) 
+		goto err_exit;
+
+	ADM5120_INTC_REG(IRQ_DISABLE_REG) = (1<<irq);
+
+err_exit:
+	/* Restore the interrupts states */
+	mips_int_unlock(s);
+}
+
+unsigned int startup_am5120_irq(unsigned int irq)
+{
+	enable_am5120_irq(irq);
+	return 0;
+}
+
+void shutdown_am5120_irq(unsigned int irq)
+{
+	disable_am5120_irq(irq);
+}
+
+static inline void ack_am5120_irq(unsigned int irq_nr)
+{
+	ADM5120_INTC_REG(IRQ_DISABLE_REG) = (1 << irq_nr);
+}
+
+
+static void end_am5120_irq(unsigned int irq_nr)
+{
+	ADM5120_INTC_REG(IRQ_ENABLE_REG) = (1 << irq_nr);
+}
+
+
+void set_affinity_am5120_irq(unsigned int irq, cpumask_t mask)
+{
+	return;
+}
+
+	
+static hw_irq_controller am5120_irq_type = {
+	"ADM5120 INTC",
+	startup_am5120_irq,
+	shutdown_am5120_irq,
+	enable_am5120_irq,
+	disable_am5120_irq,
+	ack_am5120_irq,
+	end_am5120_irq,
+	set_affinity_am5120_irq
+};
+
+
+void __init arch_init_irq(void)
+{
+	int i;
+	set_except_vector(0, mipsIRQ);
+	
+	for (i=0; i<=INT_LVL_MAX; i++) {
+		irq_desc[i].status=IRQ_DISABLED;
+		irq_desc[i].action=0;
+		irq_desc[i].depth=1;
+		irq_desc[i].handler=&am5120_irq_type;
+	}
+
+#ifdef CONFIG_REMOTE_DEBUG
+ 	printk("Setting debug traps - please connect the remote debugger.\n");
+
+	set_debug_traps();
+
+	breakpoint();
+#endif
+}
+
diff -ruN linux-2.6.10/arch/mips/am5120/led.c linux-2.6.10-adm.1/arch/mips/am5120/led.c
--- linux-2.6.10/arch/mips/am5120/led.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/am5120/led.c	2005-01-27 21:06:17.000000000 +0100
@@ -0,0 +1,493 @@
+/*
+ * LED interface for WP3200
+ *
+ * Copyright (C) 2002, by Allen Hung
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include "led.h"
+
+#define BUF_LEN		30
+
+struct LED_DATA  {
+    char sts_buf[BUF_LEN+1];
+    unsigned long sts;
+};
+
+struct LED_DATA led_data[LED_DEV_NUM];
+// sam 01-30-2004 for watchdog
+static struct timer_list watchdog;
+// end sam
+
+static struct timer_list blink_timer[LED_DEV_NUM];
+static char cmd_buf[BUF_LEN+1];
+
+//------------------------------------------------------------
+static long atoh(char *p) 
+{
+    long v = 0, c;
+    while ( (c = *p++) )  {
+        if      ( c >= '0' && c <= '9' )  v = (v << 4) + c - '0';
+        else if ( c >= 'a' && c <= 'f' )  v = (v << 4) + c - 'a' + 0xA;
+        else if ( c >= 'A' && c <= 'F' )  v = (v << 4) + c - 'A' + 0xA;
+        else  break;
+    }
+    return v;
+}
+
+
+#define GPIO_VAL		(*(unsigned long *)0xb20000b8)
+#define GPIO_SEL		(*(unsigned long *)0xb20000bc)
+#define GPIO_SEL_I_O 	(*(unsigned long *)0xb20000b8)
+#define GPIO_O_EN		(*(unsigned long *)0xb20000b8)
+#define INIT_WATCHDOG_REGISTER 0x20
+
+// sam 1-30-2004 LED status 
+// bit map as following
+// BIT 4:0  Link status   -->PHY Link ->1 = up, 0 = down
+#define LINK_STATUS     (*(unsigned long *)0xb2000014)
+#define WATCHDOG_VAL    (*(unsigned long *)0xb20000c0)
+#define WATCHDOG_PERIOD 2000 // unit ms
+#define EXPIRE_TIME     300 // unit 10 ms
+#define CLEAR_TIMEER    0xffffa000l  // bit 14:0 -> count up timer, write 0 to clear
+#define ENABLE_WATCHDOG 0x80000000l  // bit 31 -> 1 enable , 0 disable watchdog
+#define WATCHDOG_SET_TMR_SHIFT 16    // bit 16:30 -> watchdog timer set
+// end sam
+//------------------------------------------------------------
+static void turn_led(int id, int on)
+{
+    unsigned long led_bit = 1 << (id);
+	unsigned long led_bit_val;
+
+	led_bit_val = led_bit << 24;
+	
+    switch ( on ) {
+      case 0:  GPIO_VAL |=  led_bit_val;	break; // LED OFF
+      case 1:  GPIO_VAL &= ~led_bit_val;	break; // LED ON
+      case 2:  GPIO_VAL ^=  led_bit_val;	break; // LED inverse
+    }
+}
+
+static void blink_wrapper(u_long id)
+{
+    u_long sts = led_data[id].sts;
+    if ( (sts & LED_BLINK_CMD) == LED_BLINK_CMD )  {
+	int period = sts & LED_BLINK_PERIOD;
+	blink_timer[id].expires = jiffies + (period * HZ / 1000);
+	turn_led(id, 2);
+	add_timer(&blink_timer[id]);
+    }
+    else if ( sts == LED_ON || sts == LED_OFF )
+	turn_led(id, sts==LED_ON ? 1 : 0);
+}
+//------------------------------------------------------------
+static void get_token_str(char *str, char token[][21], int token_num)
+{
+    int t, i;
+    for ( t = 0 ; t < token_num ; t++ )  {
+    	memset(token[t], 0, 21);
+    	while ( *str == ' ' )  str++;
+    	for ( i = 0 ; str[i] ; i++ )  {
+    	    if ( str[i] == '\t' || str[i] == ' ' || str[i] == '\n' )  break;
+    	    if ( i < 20 )  token[t][i] = str[i];
+    	}
+    	str += i;
+    }
+}
+
+//------------------------------------------------------------
+static void set_led_status_by_str(int id)
+{
+    char token[3][21], *p;
+
+    get_token_str(led_data[id].sts_buf, token, 3);
+    if ( strcmp(token[0], "LED") )   
+        goto set_led_off;
+    if ( !strcmp(token[1], "ON") )  {
+    	turn_led(id, 1);
+    	led_data[id].sts = LED_ON;
+    }
+    else if ( !strcmp(token[1], "OFF") )  {
+	    goto set_led_off;
+    }
+    else if ( !strcmp(token[1], "BLINK") ) {
+    	int period = 0;
+    	p = token[2];
+    	if ( !strcmp(p, "FAST") )
+    	    period = LED_BLINK_FAST & LED_BLINK_PERIOD;
+    	else if ( !strcmp(p, "SLOW") )
+    	    period = LED_BLINK_SLOW & LED_BLINK_PERIOD;
+    	else if ( !strcmp(p, "EXTRA_SLOW") )
+    	    period = LED_BLINK_EXTRA_SLOW & LED_BLINK_PERIOD;
+    	else if ( !strcmp(p, "OFF") )
+	    goto set_led_off;
+	else if ( *p >= '0' && *p <= '9' )  {
+    	while ( *p >= '0' && *p <= '9' )
+    	    period = period * 10 + (*p++) - '0';
+    	if ( period > 10000 )  period = 10000;
+	}
+	else
+    	period = LED_BLINK & LED_BLINK_PERIOD;
+    	if ( period == 0 )
+    	    goto set_led_off;
+	    sprintf(led_data[id].sts_buf, "LED BLINK %d\n", period);
+    	led_data[id].sts = LED_BLINK_CMD + period;
+    	turn_led(id, 2);
+     // Set timer for next blink
+	    del_timer(&blink_timer[id]);
+        blink_timer[id].function = blink_wrapper;
+        blink_timer[id].data = id;
+        init_timer(&blink_timer[id]);
+        blink_timer[id].expires = jiffies + (period * HZ / 1000);
+        add_timer(&blink_timer[id]);
+    }
+    else
+        goto set_led_off;
+    return;
+  set_led_off:
+    strcpy(led_data[id].sts_buf, "LED OFF\n");
+    led_data[id].sts = LED_OFF;
+    turn_led(id, 0);
+}
+
+//----------------------------------------------------------------------
+static int led_read_proc(char *buf, char **start, off_t fpos, int length, int *eof, void *data)
+{
+    int len, dev;
+    for ( len = dev = 0 ; dev < LED_DEV_NUM ; dev++ )  {
+    	len += sprintf(buf+len, "%d: %s", dev, led_data[dev].sts_buf);
+    }
+    len = strlen(buf) - fpos;
+    if ( len <= 0 ) {
+	*start = buf;
+	*eof = 1;
+	return 0;
+    }
+    *start = buf + fpos;
+    if ( len <= length )   *eof = 1;
+    return len < length ? len : length;
+}
+
+//----------------------------------------------------------------------
+static int led_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+    int id = (int)file->private_data;
+
+    switch ( cmd )  {
+      case LED_ON:
+    	strcpy(led_data[id].sts_buf, "LED ON\n");
+	set_led_status_by_str(id);
+	break;
+      case LED_OFF:
+    	strcpy(led_data[id].sts_buf, "LED OFF\n");
+	set_led_status_by_str(id);
+	break;
+      default:
+        if ( (cmd & LED_BLINK_CMD) != LED_BLINK_CMD )
+	    break;
+      case LED_BLINK:
+      case LED_BLINK_FAST:
+      case LED_BLINK_SLOW:
+      case LED_BLINK_EXTRA_SLOW:
+        sprintf(led_data[id].sts_buf, "LED BLINK %d\n", (int)(cmd & LED_BLINK_PERIOD));
+	set_led_status_by_str(id);
+	break;
+    }
+    return 0;
+}
+
+static int led_open(struct inode *inode, struct file *file)
+{
+    int led_id = MINOR(inode->i_rdev);
+    unsigned long led_bit = 1 << (led_id);
+    if ( led_id >= LED_DEV_NUM )
+        return -ENODEV;
+
+    GPIO_SEL_I_O &= ~led_bit;   // 0 to GPIO
+    GPIO_O_EN |= (led_bit << 16);   // 0 to Output
+	
+    file->private_data = (void*)led_id;
+    return 0;
+}
+
+static long led_read(struct file *file, char *buf, size_t count, loff_t *fpos)
+{
+    int  rem, len;
+    int  id = (int)file->private_data;
+    char *p = led_data[id].sts_buf;
+    len = strlen(p);
+    rem = len - *fpos;
+    if ( rem <= 0 )  {
+    	*fpos = len;
+    	return 0;
+    }
+    if ( rem > count )   rem = count;
+    memcpy(buf, p+(*fpos), rem);
+    *fpos += rem;
+    return rem;
+}
+
+static long led_write(struct file *file, char *buf, size_t count, loff_t *fpos)
+{
+    int  len;
+    int  id = (int)file->private_data;
+    char *p = id == REG_MINOR ? cmd_buf : led_data[id].sts_buf;
+    memset(p, 0, BUF_LEN);
+    p += *fpos;
+    len = 0;
+    while ( count > 0 )  {
+    	if ( *fpos < BUF_LEN )  {
+    	    int c = *buf++;
+            p[len] = c>='a' && c<='z' ? c-'a'+'A' : c;
+        }
+    	(*fpos)++;
+	    len++;
+    	count--;
+    }
+    return len;
+}
+
+static int led_flush(struct file *file)
+{
+    int  id = (int)file->private_data;
+    if ( file->f_mode & FMODE_WRITE )
+    	set_led_status_by_str(id);
+    return 0;
+}
+
+static struct file_operations led_fops = {
+    read:	led_read,
+    write:	led_write,
+    flush:	led_flush,
+    ioctl:	led_ioctl,
+    open:	led_open,
+};
+
+//----------------------------------------------
+static unsigned long *reg_addr;
+static int  dump_len;
+
+static int dump_content(char *buf)
+{
+    int  i, j, len;
+    unsigned long *p = reg_addr;
+    j = dump_len/4 + ((dump_len&3) ? 1 : 0);
+    len = sprintf(buf, "Reg Addr = %08lX,  Value = \n", (unsigned long)p);
+    for ( i = 0 ; i < j ; i++, p++ )
+        len += sprintf(buf+len,"%08lX%c", *p, (i&7)==7||i==j-1?'\n':' ');
+    return len;
+}
+
+static long gpio_read(struct file *file, char *buf, size_t count, loff_t *fpos)
+{
+    int  rem, len;
+    int  id = (int)file->private_data;
+    char temp[80*10];
+    if ( id < GPIO_DEV_NUM )  {
+        int  gpio_bit = 1 << id;
+        len = sprintf(temp, "%d\n", ((GPIO_VAL >> 8)&gpio_bit) ? 1 : 0);
+    }
+    else   // REG device
+        len = dump_content(temp);
+    rem = len - *fpos;
+    if ( rem <= 0 )  {
+    	*fpos = len;
+    	return 0;
+    }
+    if ( rem > count )   rem = count;
+    memcpy(buf, temp+(*fpos), rem);
+    *fpos += rem;
+    return rem;
+}
+
+static int gpio_flush(struct file *file)
+{
+    long v, addr;
+    int  id = (int)file->private_data;
+
+    if ( id == REG_MINOR && (file->f_mode & FMODE_WRITE) )  {
+        char token[3][21], *p;
+        get_token_str(cmd_buf, token, 3);
+        // get reg address
+        p = token[0];
+        if ( *p == 0 )   return 0;
+        addr = atoh(p);
+        //---------------------
+        p = token[1];
+        if ( *p == 'W' )  {
+            int width = 0;
+            if ( !strcmp(p, "W") || !strcmp(p, "WW") )
+                width = 4;
+            else if ( !strcmp(p, "WH") )
+                width = 2;
+            else if ( !strcmp(p, "WB") )
+                width = 1;
+            else
+                return 0;
+            p = token[2];
+            if ( *p == 0 )   return 0;
+            v = atoh(p);
+            switch ( width )  {
+              case 1:  *((char *)addr) = (v & 0xFF);    break;
+              case 2:  *((short*)addr) = (v & 0xFFFF);  break;
+              case 4:  *((long *)addr) =  v;            break;
+            }
+        }
+        else  { // get dump len
+            char temp[80*10];
+            reg_addr = (unsigned long *)(addr & ~3);
+            dump_len = 4;
+            if ( *p )   {
+                dump_len = atoh(p);
+                dump_len = dump_len < 4 ? 4 : dump_len > 32*10 ? 32*10 : dump_len;
+            }
+            dump_content(temp);
+            printk( KERN_INFO "%s", temp);
+        }
+        cmd_buf[0] = 0;
+    }
+    return 0;
+}
+
+static int gpio_open(struct inode *inode, struct file *file)
+{
+    int id = MINOR(inode->i_rdev);
+    if ( id >= GPIO_DEV_NUM && id != REG_MINOR )
+        return -ENODEV;
+    if ( id < GPIO_DEV_NUM )  {
+        int gpio_bit = 1 << id;
+		
+		GPIO_SEL = 0;
+      	GPIO_SEL |= gpio_bit;   // bit=0 for GPIO
+    }
+    file->private_data = (void*)id;
+    return 0;
+}
+
+static struct file_operations gpio_fops = {
+    read:	gpio_read,
+    open:	gpio_open,
+    flush:	gpio_flush,
+    write:	led_write,
+};
+
+//----------------------------------------------
+static void watchdog_wrapper(unsigned int period)
+{
+	// clear timer count
+	WATCHDOG_VAL &= CLEAR_TIMEER;
+	watchdog.expires = jiffies + (period * HZ / 1000);
+	add_timer(&watchdog);
+}
+//----------------------------------------------
+static int init_status;
+
+#define INIT_REGION	        0x01
+#define INIT_LED_REGISTER	0x02
+#define INIT_LED_PROC_READ	0x04
+#define INIT_GPIO_REGISTER	0x08
+
+static void led_exit(void)
+{
+    int id;
+    for ( id = 0 ; id < LED_DEV_NUM ; id++ )  {
+        del_timer(&blink_timer[id]);
+        turn_led(id, 0);
+    }
+    if ( init_status & INIT_LED_PROC_READ )
+    	remove_proc_entry("driver/led", NULL);
+    	
+    if ( init_status & INIT_LED_REGISTER )
+    	unregister_chrdev(LED_MAJOR, "led");
+
+    if ( init_status & INIT_GPIO_REGISTER )
+    	unregister_chrdev(GPIO_MAJOR, "gpio");
+
+    if ( init_status & INIT_REGION )
+    	release_region(GPIO_IO_BASE, GPIO_IO_EXTENT);
+}
+
+static int __init led_init(void)
+{
+    int result, id;
+    init_status = 0;
+	
+  //---- request region --------------------------
+  /*
+    if ( check_region(GPIO_IO_BASE, GPIO_IO_EXTENT) )  {
+	    printk(KERN_ERR "gpio: I/O port %lX is not free.\n", GPIO_IO_BASE);
+	    return -EIO;
+    }
+    request_region(GPIO_IO_BASE, GPIO_IO_EXTENT, "gpio");
+    init_status |= INIT_REGION;
+  */
+  //----- register device (LED)-------------------------
+    result = register_chrdev(LED_MAJOR, "led", &led_fops);
+    if ( result < 0 )   {
+    	printk(KERN_ERR "led: can't register char device\n" );
+    	led_exit();
+    	return result;
+    }
+    init_status |= INIT_LED_REGISTER;
+  //----- register device (GPIO)-------------------------
+    result = register_chrdev(GPIO_MAJOR, "gpio", &gpio_fops);
+    if ( result < 0 )   {
+    	printk(KERN_ERR "gpio: can't register char device\n" );
+    	led_exit();
+    	return result;
+    }
+    init_status |= INIT_GPIO_REGISTER;
+  // sam 1-30-2004 LAN Status
+  // ----- register device (LAN_STATUS)-------------------
+/*    result = register_chrdev(LAN_STATUS_MAJOR, "lanSt", &lanSt_fops);
+    if ( result < 0 )   {
+    	printk(KERN_ERR "lanSt: can't register char device\n" );
+    	led_exit();
+    	return result;
+    }
+    init_status |= INIT_LAN_STATUS_REGISTER;
+	*/
+ // -----------init watchdog timer-------------------------
+	 //del_timer(&blink_timer[id]);
+	 WATCHDOG_VAL = ENABLE_WATCHDOG | ( EXPIRE_TIME  << WATCHDOG_SET_TMR_SHIFT);
+    watchdog.function = watchdog_wrapper;
+    watchdog.data = WATCHDOG_PERIOD;
+    init_timer(&watchdog);
+    watchdog.expires = jiffies + (WATCHDOG_PERIOD * HZ / 1000);
+    add_timer(&watchdog);
+    init_status |= INIT_WATCHDOG_REGISTER;
+  
+ // end sam   
+  //------ read proc -------------------
+    if ( !create_proc_read_entry("driver/led", 0, 0, led_read_proc, NULL) )  {
+	printk(KERN_ERR "led: can't create /proc/driver/led\n");
+    	led_exit();
+    	return -ENOMEM;
+    }
+    init_status |= INIT_LED_PROC_READ;
+  //------------------------------
+    reg_addr = (unsigned long *)0xB4000000;
+    dump_len = 4;
+    for ( id = 0 ; id < LED_DEV_NUM ; id++ )  {
+    	strcpy(led_data[id].sts_buf, "LED OFF\n" );
+    	set_led_status_by_str(id);
+    }
+    printk(KERN_INFO "LED & GPIO Driver " LED_VERSION "\n");
+    return 0;
+}
+
+module_init(led_init);
+module_exit(led_exit);
+EXPORT_NO_SYMBOLS;
diff -ruN linux-2.6.10/arch/mips/am5120/led.h linux-2.6.10-adm.1/arch/mips/am5120/led.h
--- linux-2.6.10/arch/mips/am5120/led.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/am5120/led.h	2005-01-27 21:06:17.000000000 +0100
@@ -0,0 +1,26 @@
+#ifndef _LED_H_INCLUDED
+#define _LED_H_INCLUDED
+
+#include <linux/config.h>
+
+#define LED_VERSION 		"v1.0"
+#define LED_MAJOR       	166
+#define LED_DEV_NUM		    8 
+#define LED_GPIO_START      1
+#define GPIO_MAJOR       	167
+#define GPIO_DEV_NUM		16
+#define REG_MINOR           128
+//#define GPIO_IO_BASE        0xB4002480
+#define GPIO_IO_BASE        ((unsigned long)0xb20000b8)
+#define GPIO_IO_EXTENT		0x40
+
+#define LED_ON              0x010000
+#define LED_OFF             0x020000
+#define LED_BLINK_CMD       0x030000
+#define LED_BLINK_PERIOD    0x00FFFF
+#define LED_BLINK           (LED_BLINK_CMD|1000)
+#define LED_BLINK_FAST      (LED_BLINK_CMD|250)
+#define LED_BLINK_SLOW      (LED_BLINK_CMD|500)
+#define LED_BLINK_EXTRA_SLOW    (LED_BLINK_CMD|2000)
+
+#endif
diff -ruN linux-2.6.10/arch/mips/am5120/memory.c linux-2.6.10-adm.1/arch/mips/am5120/memory.c
--- linux-2.6.10/arch/mips/am5120/memory.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/am5120/memory.c	2005-01-27 21:06:17.000000000 +0100
@@ -0,0 +1,84 @@
+/*****************************************************************************
+;
+;   (C) Unpublished Work of ADMtek Incorporated.  All Rights Reserved.
+;
+;       THIS WORK IS AN UNPUBLISHED WORK AND CONTAINS CONFIDENTIAL,
+;       PROPRIETARY AND TRADESECRET INFORMATION OF ADMTEK INCORPORATED.
+;       ACCESS TO THIS WORK IS RESTRICTED TO (I) ADMTEK EMPLOYEES WHO HAVE A
+;       NEED TO KNOW TO PERFORM TASKS WITHIN THE SCOPE OF THEIR ASSIGNMENTS
+;       AND (II) ENTITIES OTHER THAN ADMTEK WHO HAVE ENTERED INTO APPROPRIATE
+;       LICENSE AGREEMENTS.  NO PART OF THIS WORK MAY BE USED, PRACTICED,
+;       PERFORMED, COPIED, DISTRIBUTED, REVISED, MODIFIED, TRANSLATED,
+;       ABBRIDGED, CONDENSED, EXPANDED, COLLECTED, COMPILED, LINKED, RECAST,
+;       TRANSFORMED OR ADAPTED WITHOUT THE PRIOR WRITTEN CONSENT OF ADMTEK.
+;       ANY USE OR EXPLOITATION OF THIS WORK WITHOUT AUTHORIZATION COULD
+;       SUBJECT THE PERPERTRATOR TO CRIMINAL AND CIVIL LIABILITY.
+;
+;------------------------------------------------------------------------------
+;
+;    Project : ADM5120
+;    Creator : daniell@admtek.com.tw
+;    File    : arch/mips/am5120/memory.c
+;	 Date    : 2003.3.4
+;    Abstract: 
+;
+;Modification History:
+;
+;	Jeroen Vreeken (pe1rxq@amsat.org)
+;	Simplified by ripping out fake env stuff.
+;
+;*****************************************************************************/
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+
+#include <asm/bootinfo.h>
+#include <asm/page.h>
+#include <asm/am5120/prom.h>
+#include <asm/am5120/adm5120.h>
+
+
+/* References to section boundaries */
+extern char _end;
+
+#define PFN_ALIGN(x)    (((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
+#define ADM5120_MEMSIZE	0x1000000 /* 16 Mb */
+
+void __init prom_meminit(void)
+{
+	unsigned long base=CPHYSADDR(PFN_ALIGN(&_end));
+	unsigned long size=ADM5120_MEMSIZE;
+
+	add_memory_region(base, size-base, BOOT_MEM_RAM);
+}
+
+
+void __init prom_free_prom_memory (void)
+{
+	int i;
+	unsigned long freed = 0;
+	unsigned long addr;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) 
+	{
+		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
+			continue;
+
+		addr = boot_mem_map.map[i].addr;
+		while (addr < boot_mem_map.map[i].addr
+			      + boot_mem_map.map[i].size) 
+		{
+			ClearPageReserved(virt_to_page(__va(addr)));
+			set_page_count(virt_to_page(__va(addr)), 1);
+			free_page((unsigned long)__va(addr));
+			addr += PAGE_SIZE;
+			freed += PAGE_SIZE;
+		}
+	}
+
+	printk("Freeing prom memory: %ldkb freed\n", freed >> 10);
+}
+
+
diff -ruN linux-2.6.10/arch/mips/am5120/mipsIRQ.S linux-2.6.10-adm.1/arch/mips/am5120/mipsIRQ.S
--- linux-2.6.10/arch/mips/am5120/mipsIRQ.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/am5120/mipsIRQ.S	2005-01-27 21:06:17.000000000 +0100
@@ -0,0 +1,135 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999, 2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ *
+ * Interrupt exception dispatch code.
+ *
+ */
+#include <linux/config.h>
+
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+
+#define STATUS_IE	0x00000001
+
+/* A lot of complication here is taken away because:
+ *
+ * 1) We handle one interrupt and return, sitting in a loop and moving across
+ *    all the pending IRQ bits in the cause register is _NOT_ the answer, the
+ *    common case is one pending IRQ so optimize in that direction.
+ *
+ * 2) We need not check against bits in the status register IRQ mask, that
+ *    would make this routine slow as hell.
+ *
+ * 3) Linux only thinks in terms of all IRQs on or all IRQs off, nothing in
+ *    between like BSD spl() brain-damage.
+ *
+ * Furthermore, the IRQs on the MIPS board look basically (barring software
+ * IRQs which we don't use at all and all external interrupt sources are
+ * combined together on hardware interrupt 0 (MIPS IRQ 2)) like:
+ *
+ *	MIPS IRQ	Source
+ *      --------        ------
+ *             0	Software (ignored)
+ *             1        Software (ignored)
+ *             2        Combined hardware interrupt (hw0)
+ *             3        Hardware (ignored)
+ *             4        Hardware (ignored)
+ *             5        Hardware (ignored)
+ *             6        Hardware (ignored)
+ *             7        R4k timer (what we use)
+ *
+ * Note: On the SEAD board thing are a little bit different.
+ *       Here IRQ 2 (hw0) is wired to the UART0 and IRQ 3 (hw1) is wired
+ *       wired to UART1.
+ *	
+ * We handle the IRQ according to _our_ priority which is:
+ *
+ * Highest ----     R4k Timer
+ * Lowest  ----     Combined hardware interrupt
+ *
+ * then we just return, if multiple IRQs are pending then we will just take
+ * another exception, big deal.
+ */
+
+	.text
+	.set	noreorder
+	.set	noat
+	.align	5
+
+NESTED(mipsIRQ, PT_SIZE, sp)
+	SAVE_ALL
+	CLI
+	.set	at
+
+	mfc0	s0, CP0_CAUSE		
+	mfc0	s1, CP0_STATUS
+	and     s0, s0, s1
+	
+	/* First we check for r4k counter/timer IRQ. */
+	andi	a0, s0, CAUSEF_IP7
+	beq		a0, zero, 1f
+	nop
+
+	move	a0, sp
+	jal		mips_timer_interrupt
+	nop
+
+	j		ret_from_irq
+	nop				
+
+1:
+	andi	a0, s0, CAUSEF_IP2
+	beq		a0, zero, 1f	
+	nop
+	
+	move	a0, sp			
+	jal		am5120_hw0_irqdispatch	 
+	nop
+1:
+	j		ret_from_irq
+	nop							
+
+END(mipsIRQ)
+
+
+LEAF(mips_int_lock)
+	.set noreorder
+	mfc0	v0, CP0_STATUS
+	li		v1, ~STATUS_IE
+	and		v1, v1, v0
+	mtc0	v1, CP0_STATUS
+	j		ra
+	and		v0, v0, STATUS_IE
+	.set reorder
+END(mips_int_lock)
+
+
+LEAF(mips_int_unlock)
+	mfc0	v0, CP0_STATUS
+	and		a0, a0, STATUS_IE
+	or		v0, v0, a0
+	mtc0	v0, CP0_STATUS
+	j		ra
+	nop
+END(mips_int_unlock)
+
diff -ruN linux-2.6.10/arch/mips/am5120/pci.c linux-2.6.10-adm.1/arch/mips/am5120/pci.c
--- linux-2.6.10/arch/mips/am5120/pci.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/am5120/pci.c	2005-01-27 21:06:17.000000000 +0100
@@ -0,0 +1,214 @@
+/*****************************************************************************
+;
+;   (C) Unpublished Work of ADMtek Incorporated.  All Rights Reserved.
+;
+;       THIS WORK IS AN UNPUBLISHED WORK AND CONTAINS CONFIDENTIAL,
+;       PROPRIETARY AND TRADESECRET INFORMATION OF ADMTEK INCORPORATED.
+;       ACCESS TO THIS WORK IS RESTRICTED TO (I) ADMTEK EMPLOYEES WHO HAVE A
+;       NEED TO KNOW TO PERFORM TASKS WITHIN THE SCOPE OF THEIR ASSIGNMENTS
+;       AND (II) ENTITIES OTHER THAN ADMTEK WHO HAVE ENTERED INTO APPROPRIATE
+;       LICENSE AGREEMENTS.  NO PART OF THIS WORK MAY BE USED, PRACTICED,
+;       PERFORMED, COPIED, DISTRIBUTED, REVISED, MODIFIED, TRANSLATED,
+;       ABBRIDGED, CONDENSED, EXPANDED, COLLECTED, COMPILED, LINKED, RECAST,
+;       TRANSFORMED OR ADAPTED WITHOUT THE PRIOR WRITTEN CONSENT OF ADMTEK.
+;       ANY USE OR EXPLOITATION OF THIS WORK WITHOUT AUTHORIZATION COULD
+;       SUBJECT THE PERPERTRATOR TO CRIMINAL AND CIVIL LIABILITY.
+;
+;------------------------------------------------------------------------------
+;
+;    Project : ADM5120
+;    Creator : 
+;    File    : 
+;    Abstract: 
+;
+;Modification History:
+; 
+;
+;*****************************************************************************/
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+#ifdef CONFIG_PCI
+
+#include <asm/pci_channel.h>
+#include <asm/am5120/adm5120.h>
+
+
+volatile u32* pci_config_address_reg = (volatile u32*)KSEG1ADDR(0x115ffff0);
+volatile u32* pci_config_data_reg = (volatile u32*)KSEG1ADDR(0x115ffff8);
+
+#define PCI_ENABLE 0x80000000
+#define PCI_CMM_IOACC_EN		0x1
+#define PCI_CMM_MEMACC_EN		0x2
+#define PCI_CMM_MASTER_EN		0x4
+#define PCI_CMM_DEF				(PCI_CMM_IOACC_EN | PCI_CMM_MEMACC_EN | PCI_CMM_MASTER_EN)
+
+#define PCI_DEF_CACHE_LINE_SZ	4
+#define PCI_DEF_LATENCY_TIMER	0x20
+#define PCI_DEF_CACHE_LATENCY	((PCI_DEF_LATENCY_TIMER << 8) | PCI_DEF_CACHE_LINE_SZ)
+
+
+                             
+#define cfgaddr(dev, where) (((dev->bus->number & 0xff) << 0x10) |  \
+                             ((dev->devfn & 0xff) << 0x08) |        \
+                             (where & 0xfc)) | PCI_ENABLE
+
+
+/*
+ * We can't address 8 and 16 bit words directly.  Instead we have to
+ * read/write a 32bit word and mask/modify the data we actually want.
+ */
+static int am5120_read_config_byte (struct pci_dev *dev,
+                                   int where, unsigned char *val)
+{
+    *pci_config_address_reg = cfgaddr(dev, where);
+    *val = ((*pci_config_data_reg) >> ((where&3)<<3)) & 0xff;
+//	printk("pci_read_byte 0x%x == 0x%x\n", where, *val);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int am5120_read_config_word (struct pci_dev *dev,
+                                   int where, unsigned short *val)
+{
+	if (where & 1)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	*pci_config_address_reg = cfgaddr(dev, where);
+	*val = ((*pci_config_data_reg) >> ((where&3)<<3)) & 0xffff;
+//	printk("pci_read_word 0x%x == 0x%x\n", where, *val);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+int am5120_read_config_dword (struct pci_dev *dev,
+                                    int where, unsigned int *val)
+{
+	if (where & 3)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	*pci_config_address_reg = cfgaddr(dev, where);
+	*val = (*pci_config_data_reg);
+//	printk("pci_read_dword 0x%x == 0x%x\n", where, *val);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int am5120_write_config_byte (struct pci_dev *dev,
+                                    int where, unsigned char val)
+{
+	*pci_config_address_reg = cfgaddr(dev, where);
+	*(volatile u8 *)(((int)pci_config_data_reg) + (where & 3)) = val;
+//	printk("pci_write_byte 0x%x = 0x%x\n", where, val);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int am5120_write_config_word (struct pci_dev *dev,
+                                    int where, unsigned short val)
+{
+	if (where & 1)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	*pci_config_address_reg = cfgaddr(dev, where);
+	*(volatile u16 *)(((int)pci_config_data_reg) + (where & 2)) = (val);
+//	printk("pci_write_word 0x%x = 0x%x\n", where, val);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int am5120_write_config_dword (struct pci_dev *dev,
+                                     int where, unsigned int val)
+{
+	if (where & 3)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	*pci_config_address_reg = cfgaddr(dev, where);
+	*pci_config_data_reg = (val);
+//	printk("pci_write_dword 0x%x = 0x%x\n", where, val);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+
+struct pci_ops am5120_pci_ops = {
+	am5120_read_config_byte,
+	am5120_read_config_word,
+	am5120_read_config_dword,
+	am5120_write_config_byte,
+	am5120_write_config_word,
+	am5120_write_config_dword
+};
+struct resource pciioport_resource = {
+	"pci IO space", 
+	0x11500000,  
+	0x115ffff0-1,
+	IORESOURCE_IO
+};
+
+struct resource pciiomem_resource = {
+	"pci memory space", 
+	0x11400000,
+	0x11500000-1,
+	IORESOURCE_MEM
+};
+
+static void am5120_pcibios_fixup(struct pci_dev *dev)
+{
+	printk("am5120 fix up\n");
+	pci_write_config_word(dev, PCI_COMMAND, PCI_CMM_DEF);
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, PCI_DEF_CACHE_LATENCY);
+	pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0);
+	pci_write_config_dword(dev, PCI_BASE_ADDRESS_1, 0);
+
+}
+
+struct pci_channel mips_pci_channels[] = {
+	{ &am5120_pci_ops, &pciioport_resource, &pciiomem_resource,0,0xff},
+	{ NULL, NULL, NULL , NULL , NULL}
+};
+
+
+
+unsigned __init int pcibios_assign_all_busses(void)
+{
+        return 1;
+}
+
+void __init pcibios_fixup(void)
+{
+	printk("pcibios_fixup\n");
+}
+
+void __init pcibios_fixup_irqs(void)
+{
+   struct pci_dev *dev;
+   int slot_num;
+
+   printk("fixup IRQ\n");	
+   pci_for_each_dev(dev) {
+      slot_num = PCI_SLOT(dev->devfn);
+      switch(slot_num) {
+         case 2: 
+		 dev->irq = 6;  
+		 pci_write_config_word(dev, PCI_INTERRUPT_LINE, 6);
+		 break;
+         case 3: 
+		 dev->irq = 7;  
+		 pci_write_config_word(dev, PCI_INTERRUPT_LINE, 7);
+		 break;
+         case 4: 
+		 dev->irq = 8;  
+		 pci_write_config_word(dev, PCI_INTERRUPT_LINE, 8);
+		 break;
+         default: break;
+      }
+   }
+}
+
+void __init pcibios_fixup_resources(struct pci_dev *dev)
+{
+	printk("fixup resource\n");
+	if (dev->devfn == 0)
+	{
+		printk("fixup host controller\n");
+		am5120_pcibios_fixup(dev);
+	}
+}
+
+#endif /* CONFIG_PCI */
diff -ruN linux-2.6.10/arch/mips/am5120/prom.c linux-2.6.10-adm.1/arch/mips/am5120/prom.c
--- linux-2.6.10/arch/mips/am5120/prom.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/am5120/prom.c	2005-01-27 21:06:17.000000000 +0100
@@ -0,0 +1,70 @@
+/*****************************************************************************
+;
+;   (C) Unpublished Work of ADMtek Incorporated.  All Rights Reserved.
+;
+;       THIS WORK IS AN UNPUBLISHED WORK AND CONTAINS CONFIDENTIAL,
+;       PROPRIETARY AND TRADESECRET INFORMATION OF ADMTEK INCORPORATED.
+;       ACCESS TO THIS WORK IS RESTRICTED TO (I) ADMTEK EMPLOYEES WHO HAVE A
+;       NEED TO KNOW TO PERFORM TASKS WITHIN THE SCOPE OF THEIR ASSIGNMENTS
+;       AND (II) ENTITIES OTHER THAN ADMTEK WHO HAVE ENTERED INTO APPROPRIATE
+;       LICENSE AGREEMENTS.  NO PART OF THIS WORK MAY BE USED, PRACTICED,
+;       PERFORMED, COPIED, DISTRIBUTED, REVISED, MODIFIED, TRANSLATED,
+;       ABBRIDGED, CONDENSED, EXPANDED, COLLECTED, COMPILED, LINKED, RECAST,
+;       TRANSFORMED OR ADAPTED WITHOUT THE PRIOR WRITTEN CONSENT OF ADMTEK.
+;       ANY USE OR EXPLOITATION OF THIS WORK WITHOUT AUTHORIZATION COULD
+;       SUBJECT THE PERPERTRATOR TO CRIMINAL AND CIVIL LIABILITY.
+;
+;------------------------------------------------------------------------------
+;
+;    Project : ADM5120
+;    Creator : daniell@admtek.com.tw
+;    File    : arch/mips/am5120/prom.c
+;	 Date    : 2003.3.4
+;    Abstract: 
+;
+;Modification History:
+;
+;	Jeroen Vreeken (pe1rxq@amsat.org)
+;	Ripped out cmdline and env stuff left over from YAMON cut-and-paste.
+;
+;*****************************************************************************/
+
+#include <linux/init.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+
+#include <asm/bootinfo.h>
+#include <asm/addrspace.h>
+
+extern void am5120_serial_console_init(void);
+void setup_prom_printf(int);
+void prom_printf(char *, ...);
+void prom_meminit(void);
+
+/*
+ * initialize the prom module.
+ */
+void __init prom_init(void)
+{
+	/* you should these macros defined in include/asm/bootinfo.h */
+	mips_machgroup = MACH_GROUP_ADM_GW;
+	mips_machtype = MACH_ADM_GW_5120;
+
+	/* set IO port base to zero */ 
+
+	/* init print from uart0 */
+	setup_prom_printf(0);
+
+	prom_printf("\nLINUX started...\n");
+	
+	/* init command line */
+	strcpy(&(arcs_cmdline[0]), ""/*"root=/dev/ram0 console=ttyS0"*/);
+
+	/* init memory map */
+	prom_meminit();
+}
+
+
diff -ruN linux-2.6.10/arch/mips/am5120/serial.c linux-2.6.10-adm.1/arch/mips/am5120/serial.c
--- linux-2.6.10/arch/mips/am5120/serial.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/am5120/serial.c	2005-01-27 21:06:17.000000000 +0100
@@ -0,0 +1,1711 @@
+/*****************************************************************************
+;
+;   (C) Unpublished Work of ADMtek Incorporated.  All Rights Reserved.
+;
+;       THIS WORK IS AN UNPUBLISHED WORK AND CONTAINS CONFIDENTIAL,
+;       PROPRIETARY AND TRADESECRET INFORMATION OF ADMTEK INCORPORATED.
+;       ACCESS TO THIS WORK IS RESTRICTED TO (I) ADMTEK EMPLOYEES WHO HAVE A
+;       NEED TO KNOW TO PERFORM TASKS WITHIN THE SCOPE OF THEIR ASSIGNMENTS
+;       AND (II) ENTITIES OTHER THAN ADMTEK WHO HAVE ENTERED INTO APPROPRIATE
+;       LICENSE AGREEMENTS.  NO PART OF THIS WORK MAY BE USED, PRACTICED,
+;       PERFORMED, COPIED, DISTRIBUTED, REVISED, MODIFIED, TRANSLATED,
+;       ABBRIDGED, CONDENSED, EXPANDED, COLLECTED, COMPILED, LINKED, RECAST,
+;       TRANSFORMED OR ADAPTED WITHOUT THE PRIOR WRITTEN CONSENT OF ADMTEK.
+;       ANY USE OR EXPLOITATION OF THIS WORK WITHOUT AUTHORIZATION COULD
+;       SUBJECT THE PERPERTRATOR TO CRIMINAL AND CIVIL LIABILITY.
+;
+;------------------------------------------------------------------------------
+;
+;    Project : ADM5120
+;    Creator : daniell@admtek.com.tw
+;    File    : arch/mips/am5120/printf.c
+;	 Date    : 2003.3.4
+;    Abstract: 
+;
+;Modification History:
+;
+;*****************************************************************************/
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/serial.h>
+#include <linux/serialP.h>
+#include <linux/serial_reg.h>
+#include <linux/console.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/tty_flip.h>
+#include <linux/devpts_fs.h>
+
+#include <linux/major.h>
+#include <linux/string.h>
+#include <linux/fcntl.h>
+#include <linux/ptrace.h>
+#include <linux/ioport.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/serial.h>
+#include <asm/am5120/adm5120.h>
+
+
+//#define SERIAL_DEBUG_OPEN	1
+//#define SERIAL_DEBUG_INTR	1
+
+static struct tty_driver dev_tty_driver;
+
+/*
+ * IN_W
+ */
+static inline unsigned long IN_W(unsigned long _addr)
+{
+	return (*(volatile unsigned long *)(_addr));
+}
+
+
+/*
+ * OUT_W
+ */
+static inline void OUT_W(unsigned long _addr, unsigned long _value)
+{
+	(*((volatile unsigned long *)(_addr))) = _value;
+}
+
+
+/*
+ * serial_in
+ */
+static unsigned int serial_in(struct async_struct *info, int offset)
+{
+	return IN_W(info->port + offset);
+}
+
+
+/*
+ * serial_out
+ */
+static void serial_out(struct async_struct *info, int offset,
+				int value)
+{
+	OUT_W(info->port + offset, value);
+}
+
+
+/*
+ * serial state 
+ */
+static struct serial_state rs_table[] = 
+{
+	{baud_base:UART_115200bps_DIVISOR, port:KSEG1ADDR(UART0_BASE), irq:1, flags:STD_COM_FLAGS, type:SERIAL_IO_MEM}
+};
+
+
+/*-------------------------------------------------------
+ * prom_printf 
+ * 
+ *-----------------------------------------------------*/
+/*
+ * Hooks to fake "prom" console I/O before devices 
+ * are fully initialized. 
+ */
+static struct async_struct prom_port_info = {0};
+
+void __init setup_prom_printf(int tty_no) 
+{
+	struct serial_state *ser = &rs_table[tty_no];
+
+	prom_port_info.state = ser;
+	prom_port_info.magic = SERIAL_MAGIC;
+	prom_port_info.port = ser->port;
+	prom_port_info.flags = ser->flags;
+
+	/* set baudrate to 115200 */
+	serial_out(&prom_port_info, UART_LCR_L_REG, prom_port_info.state->baud_base); 
+	serial_out(&prom_port_info, UART_LCR_M_REG, prom_port_info.state->baud_base >> 8);
+	
+	/* Set default line mode */
+	serial_out(&prom_port_info, UART_LCR_H_REG, UART_WLEN_8BITS | UART_ENABLE_FIFO);
+
+	/* Enable uart port */
+	serial_out(&prom_port_info, UART_CR_REG, UART_PORT_EN);
+}
+
+
+/* 
+ * putPromChar
+ */
+int putPromChar(char c)
+{
+	if (!prom_port_info.state) { 	/* need to init device first */
+		return 0;
+	}
+
+	while ((serial_in(&prom_port_info, UART_FR_REG) &
+	    UART_TX_FIFO_FULL) != 0);
+
+	serial_out(&prom_port_info, UART_DR_REG, c);
+
+	return 1;
+}
+
+
+/* 
+ * getPromChar
+ */
+char getPromChar(void)
+{
+	if (!prom_port_info.state) 	/* need to init device first */
+		return 0;
+
+	if ((serial_in(&prom_port_info, UART_FR_REG) & UART_RX_FIFO_EMPTY))
+		return 0;
+
+	return(serial_in(&prom_port_info, UART_DR_REG));
+}
+
+
+static char buf[1024];
+
+/*
+ * prom_printf
+ */
+void __init prom_printf(char *fmt, ...)
+{
+	va_list args;
+	int l;
+	char *p, *buf_end;
+	long flags;
+
+	int putPromChar(char);
+
+	/* Low level, brute force, not SMP safe... */
+	save_and_cli(flags);
+	va_start(args, fmt);
+	l = vsprintf(buf, fmt, args); /* hopefully i < sizeof(buf) */
+	va_end(args);
+
+	buf_end = buf + l;
+
+	for (p = buf; p < buf_end; p++) {
+		/* Crude cr/nl handling is better than none */
+		if(*p == '\n')putPromChar('\r');
+		putPromChar(*p);
+	}
+	restore_flags(flags);
+}
+
+
+/*-------------------------------------------------------
+ * console driver
+ * 
+ *-----------------------------------------------------*/
+/*
+ *	Print a string to the serial port trying not to disturb
+ *	any possible real use of the port...
+ *
+ *	The console_lock must be held when we get here.
+ */
+static void serial_console_write(struct console *co, const char *s,
+				unsigned count)
+{
+	int i;
+
+	for (i = 0; i < count; i++, s++)
+	{
+		if (*s == '\n')
+			putPromChar('\r');
+		putPromChar(*s);
+	}
+}
+
+
+/*
+ *	Receive character from the serial port
+ */
+static int serial_console_wait_key(struct console *co)
+{
+	return 0;
+}
+
+
+/*
+ * Get serial console device
+ */
+static struct tty_driver *serial_console_device(struct console *c, int *index)
+{
+	*index=c->index;
+	return &dev_tty_driver;
+}
+
+
+/*
+ *	Setup initial baud/bits/parity. We do two things here:
+ *	- construct a cflag setting for the first rs_open()
+ *	- initialize the serial port
+ *	Return non-zero if we didn't find a serial port.
+ */
+static int __init serial_console_setup(struct console *co, char *options)
+{
+	return 0;
+}
+
+
+/* 
+ * Console data structure
+ */
+static struct console sercons = {
+	name:		"ttyS",
+	write:		serial_console_write,
+	device:		serial_console_device,
+//	wait_key:	serial_console_wait_key,
+	setup:		serial_console_setup,
+	flags:		CON_PRINTBUFFER,
+	index:		-1,
+};
+
+/*
+ *	Register console.
+ */
+static int __init am5120_serial_console_init(void)
+{
+	register_console(&sercons);
+	return 0;
+}
+console_initcall(am5120_serial_console_init);
+
+/*------------------------------------------------------
+ * Register tty driver
+ *
+ *----------------------------------------------------*/
+
+static char *serial_version = "0.01";
+static char *serial_revdate = "2003-04-17";
+
+#define LOCAL_VERSTRING ""
+
+#define NR_PORTS	(sizeof(rs_table)/sizeof(struct serial_state))
+#define WAKEUP_CHARS 256
+#define RS_ISR_PASS_LIMIT 256
+
+static unsigned char *tmp_buf;
+#ifdef DECLARE_MUTEX
+static DECLARE_MUTEX(tmp_buf_sem);
+#else
+static struct semaphore tmp_buf_sem = MUTEX;
+#endif
+
+static int serial_refcount;
+static struct tty_struct *serial_table[NR_PORTS];
+static struct termios *serial_termios[NR_PORTS];
+static struct termios *serial_termios_locked[NR_PORTS];
+static unsigned char *tmp_buf = 0;
+static struct async_struct *IRQ_ports[NR_IRQS] = {0};
+
+
+
+
+static void do_softint(void *private_)
+{
+	struct async_struct	*info = (struct async_struct *) private_;
+	struct tty_struct	*tty;
+	
+	tty = info->tty;
+	if (!tty)
+		return;
+
+	if (test_and_clear_bit(RS_EVENT_WRITE_WAKEUP, &info->event)) {
+		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+		    tty->ldisc.write_wakeup)
+			(tty->ldisc.write_wakeup)(tty);
+		wake_up_interruptible(&tty->write_wait);
+#ifdef SERIAL_HAVE_POLL_WAIT
+		wake_up_interruptible(&tty->poll_wait);
+#endif
+	}
+}
+
+
+static int get_async_struct(int line, struct async_struct **ret_info)
+{
+	struct async_struct *info;
+	struct serial_state *sstate;
+
+	sstate = rs_table + line;
+	sstate->count++;
+	if (sstate->info) {
+		*ret_info = sstate->info;
+		return 0;
+	}
+
+	info = kmalloc(sizeof(struct async_struct), GFP_KERNEL);
+	if (!info) {
+		sstate->count--;
+		return -ENOMEM;
+	}
+
+	memset(info, 0, sizeof(struct async_struct));
+	init_waitqueue_head(&info->open_wait);
+	init_waitqueue_head(&info->close_wait);
+	init_waitqueue_head(&info->delta_msr_wait);
+	info->magic = SERIAL_MAGIC;
+	info->port = sstate->port;
+	info->flags = sstate->flags;
+	info->io_type = sstate->io_type;
+	info->iomem_base = sstate->iomem_base;
+	info->iomem_reg_shift = sstate->iomem_reg_shift;
+	info->xmit_fifo_size = sstate->xmit_fifo_size;
+	info->line = line;
+	INIT_WORK(&info->work, do_softint, info);
+//	info->tqueue.routine = do_softint;
+//	info->tqueue.data = info;
+	info->state = sstate;
+	if (sstate->info) {
+		kfree(info);
+		*ret_info = sstate->info;
+		return 0;
+	}
+	*ret_info = sstate->info = info;
+	return 0;
+}
+
+
+static void transmit_chars(struct async_struct *info, int *intr_done)
+{
+	if (info->x_char) {
+		serial_out(info, UART_DR_REG, info->x_char);
+		info->state->icount.tx++;
+		info->x_char = 0;
+		if (intr_done)
+			*intr_done = 0;
+		return;
+	}
+
+	if (info->xmit.head == info->xmit.tail
+	    || info->tty->stopped
+	    || info->tty->hw_stopped) {
+		info->IER &= ~UART_TX_INT_EN;
+		serial_out(info, UART_CR_REG, info->IER);
+		return;
+	}
+	
+	do {
+		while ((serial_in(info, UART_FR_REG) & UART_TX_FIFO_FULL) != 0)
+			;
+
+		serial_out(info, UART_DR_REG, info->xmit.buf[info->xmit.tail]);
+		info->xmit.tail = (info->xmit.tail + 1) & (SERIAL_XMIT_SIZE-1);
+		info->state->icount.tx++;
+		if (info->xmit.head == info->xmit.tail)
+			break;
+	} while (1);
+	
+	//if (CIRC_CNT(info->xmit.head,
+	//	     info->xmit.tail,
+	//	     SERIAL_XMIT_SIZE) < WAKEUP_CHARS)
+		//rs_sched_event(info, RS_EVENT_WRITE_WAKEUP);
+
+#ifdef SERIAL_DEBUG_INTR
+	printk("THRE...");
+#endif
+
+	if (intr_done)
+		*intr_done = 0;
+
+	if (info->xmit.head == info->xmit.tail) {
+		info->IER &= ~UART_TX_INT_EN;
+		serial_out(info, UART_CR_REG, info->IER);
+	}
+}
+
+
+
+static void receive_chars(struct async_struct *info,
+				 struct pt_regs * regs)
+{
+	struct tty_struct *tty = info->tty;
+	unsigned char ch;
+	//int ignored = 0;
+	struct	async_icount *icount;
+	unsigned int status;
+	unsigned int rsr_flag;
+
+	icount = &info->state->icount;
+
+	do {
+		ch = serial_in(info, UART_DR_REG);
+
+		rsr_flag = serial_in(info, UART_RSR_REG);
+		serial_out(info, UART_RSR_REG, rsr_flag);
+
+		if (rsr_flag & UART_RX_ERROR)
+			goto ignore_char;
+			
+		if (tty->flip.count >= TTY_FLIPBUF_SIZE)
+			goto ignore_char;
+
+		*tty->flip.char_buf_ptr = ch;
+		icount->rx++;
+		
+#ifdef SERIAL_DEBUG_INTR
+		printk("DR%02x...", ch);
+#endif
+		*tty->flip.flag_buf_ptr = 0;
+
+		tty->flip.flag_buf_ptr++;
+		tty->flip.char_buf_ptr++;
+		tty->flip.count++;
+
+		status = serial_in(info, UART_FR_REG);
+
+	} while (!(status & UART_RX_FIFO_EMPTY));
+
+ignore_char:
+
+	tty_flip_buffer_push(tty);
+}
+
+
+/*
+ * This is the serial driver's interrupt routine for a single port
+ */
+irqreturn_t rs_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+{
+	int status;
+	int pass_counter = 0;
+	struct async_struct * info;
+	int handled=IRQ_NONE;
+	
+#ifdef SERIAL_DEBUG_INTR
+	printk("rs_interrupt(%d)...", irq);
+#endif
+
+	info = IRQ_ports[irq];
+	if (!info || !info->tty)
+		return handled;
+
+	do {
+		status = serial_in(info, UART_IIR_REG);
+
+		if (status & (UART_RX_INT | UART_RX_TIMEOUT_INT))
+		{
+			//if ((serial_in(info, UART_FR_REG) & UART_RX_FIFO_EMPTY))
+			//	break;
+			handled=IRQ_HANDLED;
+			receive_chars(info, regs);
+		}
+
+		if (status & UART_TX_INT)
+		{
+			handled=IRQ_HANDLED;
+			transmit_chars(info, 0);
+		}
+		
+		if (pass_counter++ > RS_ISR_PASS_LIMIT) {
+			break;
+		}
+
+	} while (serial_in(info, UART_IIR_REG) & (UART_RX_INT | UART_RX_TIMEOUT_INT | UART_TX_INT));
+
+	info->last_active = jiffies;
+	return handled;
+}
+
+
+static int startup(struct async_struct * info)
+{
+	unsigned long flags;
+	int	retval=0;
+	irqreturn_t (*handler)(int, void *, struct pt_regs *);
+	struct serial_state *state= info->state;
+	unsigned long page;
+
+	if (info->flags & ASYNC_INITIALIZED) 
+		return retval;
+
+	page = get_zeroed_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	save_flags(flags); 
+	
+	cli();
+
+	if (!CONFIGURED_SERIAL_PORT(state) || !state->type) 
+	{
+		if (info->tty)
+			set_bit(TTY_IO_ERROR, &info->tty->flags);
+		free_page(page);
+		goto errout;
+	}
+	
+	if (info->xmit.buf)
+		free_page(page);
+	else
+		info->xmit.buf = (unsigned char *) page;
+
+#ifdef SERIAL_DEBUG_OPEN
+	printk("starting up ttyS%d (irq %d)...", info->line, state->irq);
+#endif
+
+	/*
+	 * Allocate the IRQ if necessary
+	 */
+	if ((!IRQ_ports[state->irq] || !IRQ_ports[state->irq]->next_port)) 
+	{
+		if (IRQ_ports[state->irq]) 
+		{
+			retval = -EBUSY;
+			goto errout;
+		} 
+		else 
+			handler = rs_interrupt;
+
+		retval = request_irq(state->irq, handler, SA_SHIRQ,
+							"serial", &IRQ_ports[state->irq]);
+		if (retval) 
+		{
+			if (capable(CAP_SYS_ADMIN)) 
+			{
+				if (info->tty)
+					set_bit(TTY_IO_ERROR, &info->tty->flags);
+			}
+			goto errout;
+		}
+	}
+
+	/*
+	 * Insert serial port into IRQ chain.
+	 */
+	info->prev_port = 0;
+	info->next_port = IRQ_ports[state->irq];
+	
+	if (info->next_port)
+		info->next_port->prev_port = info;
+	
+	IRQ_ports[state->irq] = info;
+
+	/*
+	 * Now, initialize the UART 
+	 */
+	serial_out(info, UART_LCR_L_REG, info->state->baud_base); 
+	serial_out(info, UART_LCR_M_REG, info->state->baud_base >> 8);
+	serial_out(info, UART_LCR_H_REG, (UART_WLEN_8BITS | UART_ENABLE_FIFO));
+
+	/*
+	 * Finally, enable interrupts
+	 */
+	info->IER = UART_RX_INT_EN | UART_RX_TIMEOUT_INT_EN | UART_PORT_EN;
+	serial_out(info, UART_CR_REG, info->IER);
+
+	if (info->tty)
+		clear_bit(TTY_IO_ERROR, &info->tty->flags);
+
+	info->xmit.head = info->xmit.tail = 0;
+	
+	/*
+	 * and set the speed of the serial port
+	 */
+	info->flags |= ASYNC_INITIALIZED;
+	restore_flags(flags);
+
+	return 0;
+	
+errout:
+	restore_flags(flags);
+	return retval;
+}
+
+
+/*
+ * This routine is called whenever a serial port is opened.  It
+ * enables interrupts for a serial port, linking in its async structure into
+ * the IRQ chain.   It also performs the serial-specific
+ * initialization for the tty structure.
+ */
+static int rs_open(struct tty_struct *tty, struct file * filp)
+{
+	struct async_struct	*info;
+	int 			retval, line;
+	unsigned long		page;
+
+//	line = MINOR(tty->device) - tty->driver.minor_start;
+	line=0;
+	if ((line < 0) || (line >= NR_PORTS)) 
+	{
+		return -ENODEV;
+	}
+
+	retval = get_async_struct(line, &info);
+	if (retval) 
+	{
+		return retval;
+	}
+
+	tty->driver_data = info;
+	info->tty = tty;
+
+#ifdef SERIAL_DEBUG_OPEN
+	printk("rs_open %s%d, count = %d\n", tty->driver.name, info->line,
+	       info->state->count);
+#endif
+	
+	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
+
+	if (!tmp_buf) 
+	{
+		page = get_zeroed_page(GFP_KERNEL);
+		if (!page) 
+		{
+			return -ENOMEM;
+		}
+
+		if (tmp_buf)
+			free_page(page);
+		else
+			tmp_buf = (unsigned char *) page;
+	}
+
+	/*
+	 * If the port is the middle of closing, bail out now
+	 */
+	if (tty_hung_up_p(filp) || (info->flags & ASYNC_CLOSING)) 
+	{
+		if (info->flags & ASYNC_CLOSING)
+			interruptible_sleep_on(&info->close_wait);
+
+		return -EAGAIN;
+	}
+
+	/*
+	 * Start up serial port
+	 */
+	retval = startup(info);
+	if (retval) 
+	{
+		return retval;
+	}
+
+#if 0
+	retval = block_til_ready(tty, filp, info);
+	if (retval) {
+#ifdef SERIAL_DEBUG_OPEN
+		printk("rs_open returning after block_til_ready with %d\n",
+		       retval);
+#endif
+		return retval;
+	}
+#endif
+
+	if ((info->state->count == 1) &&
+	    (info->flags & ASYNC_SPLIT_TERMIOS)) 
+	{
+//		if (tty->driver.subtype == SERIAL_TYPE_NORMAL)
+//			*tty->termios = info->state->normal_termios;
+//		else 
+//			*tty->termios = info->state->callout_termios;
+	}
+
+//	info->session = current->session;
+//	info->pgrp = current->pgrp;
+
+#ifdef SERIAL_DEBUG_OPEN
+	printk("rs_open ttys%d successful...", info->line);
+#endif
+
+	return 0;
+}
+
+
+/*
+ * rs_close()
+ * 
+ * This routine is called when the serial port gets closed.  First, we
+ * wait for the last remaining data to be sent.  Then, we unlink its
+ * async structure from the interrupt chain if necessary, and we free
+ * that IRQ if nothing is left in the chain.
+ */
+static void rs_close(struct tty_struct *tty, struct file * filp)
+{
+	struct async_struct * info = (struct async_struct *)tty->driver_data;
+	struct serial_state *state;
+	unsigned long flags;
+
+	state = info->state;
+	
+	save_flags(flags); 
+	cli();
+	
+	//if (tty_hung_up_p(filp)) {
+	//	DBG_CNT("before DEC-hung");
+	//	restore_flags(flags);
+	//	return;
+	//}
+	
+#ifdef SERIAL_DEBUG_OPEN
+	printk("rs_close ttys%d, count = %d\n", info->line, state->count);
+#endif
+
+	if ((tty->count == 1) && (state->count != 1)) {
+		/*
+		 * Uh, oh.  tty->count is 1, which means that the tty
+		 * structure will be freed.  state->count should always
+		 * be one in these conditions.  If it's greater than
+		 * one, we've got real problems, since it means the
+		 * serial port won't be shutdown.
+		 */
+		//printk("rs_close: bad serial port count; tty->count is 1, "
+		 //      "state->count is %d\n", state->count);
+		state->count = 1;
+	}
+
+	if (--state->count < 0) {
+		//printk("rs_close: bad serial port count for ttys%d: %d\n",
+		   //    info->line, state->count);
+		state->count = 0;
+	}
+
+	restore_flags(flags);
+	return;
+
+#if 0
+	info->flags |= ASYNC_CLOSING;
+	restore_flags(flags);
+	/*
+	 * Save the termios structure, since this port may have
+	 * separate termios for callout and dialin.
+	 */
+	if (info->flags & ASYNC_NORMAL_ACTIVE)
+		info->state->normal_termios = *tty->termios;
+	if (info->flags & ASYNC_CALLOUT_ACTIVE)
+		info->state->callout_termios = *tty->termios;
+	/*
+	 * Now we wait for the transmit buffer to clear; and we notify 
+	 * the line discipline to only process XON/XOFF characters.
+	 */
+	tty->closing = 1;
+
+	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, info->closing_wait);
+
+	/*
+	 * At this point we stop accepting input.  To do this, we
+	 * disable the receive line status interrupts, and tell the
+	 * interrupt driver to stop checking the data ready bit in the
+	 * line status register.
+	 */
+	//info->IER &= ~UART_IER_RLSI;
+	//info->read_status_mask &= ~UART_LSR_DR;
+	//if (info->flags & ASYNC_INITIALIZED) {
+	//	serial_out(info, UART_IER, info->IER);
+		/*
+		 * Before we drop DTR, make sure the UART transmitter
+		 * has completely drained; this is especially
+		 * important if there is a transmit FIFO!
+		 */
+	//	rs_wait_until_sent(tty, info->timeout);
+	//}
+	//shutdown(info);
+
+	if (tty->driver.flush_buffer)
+		tty->driver.flush_buffer(tty);
+	if (tty->ldisc.flush_buffer)
+		tty->ldisc.flush_buffer(tty);
+	tty->closing = 0;
+	info->event = 0;
+	info->tty = 0;
+	//if (info->blocked_open) {
+	//	if (info->close_delay) {
+	//		set_current_state(TASK_INTERRUPTIBLE);
+	//		schedule_timeout(info->close_delay);
+	//	}
+	//	wake_up_interruptible(&info->open_wait);
+	//}
+	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CALLOUT_ACTIVE|
+			 ASYNC_CLOSING);
+	
+	wake_up_interruptible(&info->close_wait);
+#endif
+}
+
+
+static int rs_write(struct tty_struct * tty, const unsigned char *buf,
+	int count)
+{
+	int	c, ret = 0;
+	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	unsigned long flags;
+
+	if (!tty || !info->xmit.buf || !tmp_buf)
+		return 0;
+
+	save_flags(flags);
+	if (0/*from_user*/) {
+		down(&tmp_buf_sem);
+		while (1) {
+			int c1;
+			c = CIRC_SPACE_TO_END(info->xmit.head,
+					      info->xmit.tail,
+					      SERIAL_XMIT_SIZE);
+			if (count < c)
+				c = count;
+			if (c <= 0)
+				break;
+
+			c -= copy_from_user(tmp_buf, buf, c);
+			if (!c) {
+				if (!ret)
+					ret = -EFAULT;
+				break;
+			}
+			cli();
+			c1 = CIRC_SPACE_TO_END(info->xmit.head,
+					       info->xmit.tail,
+					       SERIAL_XMIT_SIZE);
+			if (c1 < c)
+				c = c1;
+			memcpy(info->xmit.buf + info->xmit.head, tmp_buf, c);
+			info->xmit.head = ((info->xmit.head + c) &
+					   (SERIAL_XMIT_SIZE-1));
+			restore_flags(flags);
+			buf += c;
+			count -= c;
+			ret += c;
+		}
+		up(&tmp_buf_sem);
+	} else {
+		cli();
+		while (1) {
+			c = CIRC_SPACE_TO_END(info->xmit.head,
+					      info->xmit.tail,
+					      SERIAL_XMIT_SIZE);
+			if (count < c)
+				c = count;
+			if (c <= 0) {
+				break;
+			}
+			memcpy(info->xmit.buf + info->xmit.head, buf, c);
+			info->xmit.head = ((info->xmit.head + c) &
+					   (SERIAL_XMIT_SIZE-1));
+			buf += c;
+			count -= c;
+			ret += c;
+		}
+		restore_flags(flags);
+	}
+	if (info->xmit.head != info->xmit.tail
+	    && !tty->stopped
+	    && !tty->hw_stopped
+	    && !(info->IER & UART_TX_INT)) {
+		info->IER |= UART_TX_INT_EN;
+		serial_out(info, UART_CR_REG, info->IER);
+	}
+	return ret;
+}
+
+
+static void rs_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	unsigned long flags;
+
+	if (!tty || !info->xmit.buf)
+		return;
+
+	save_flags(flags); 
+	cli();
+	
+	if (CIRC_SPACE(info->xmit.head,
+		       info->xmit.tail,
+		       SERIAL_XMIT_SIZE) == 0) {
+		restore_flags(flags);
+		return;
+	}
+
+	info->xmit.buf[info->xmit.head] = ch;
+	info->xmit.head = (info->xmit.head + 1) & (SERIAL_XMIT_SIZE-1);
+	restore_flags(flags);
+}
+
+
+static void rs_flush_chars(struct tty_struct *tty)
+{
+	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	unsigned long flags;
+				
+	if (info->xmit.head == info->xmit.tail
+	    || tty->stopped
+	    || tty->hw_stopped
+	    || !info->xmit.buf)
+		return;
+
+	save_flags(flags); 
+	cli();
+	
+	info->IER |= UART_TX_INT_EN;
+	serial_out(info, UART_CR_REG, info->IER);
+	restore_flags(flags);
+}
+
+
+static int rs_write_room(struct tty_struct *tty)
+{
+	struct async_struct *info = (struct async_struct *)tty->driver_data;
+
+	return CIRC_SPACE(info->xmit.head, info->xmit.tail, SERIAL_XMIT_SIZE);
+}
+
+
+static int rs_chars_in_buffer(struct tty_struct *tty)
+{
+	struct async_struct *info = (struct async_struct *)tty->driver_data;
+				
+	return CIRC_CNT(info->xmit.head, info->xmit.tail, SERIAL_XMIT_SIZE);
+}
+
+
+static void rs_flush_buffer(struct tty_struct *tty)
+{
+	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	unsigned long flags;
+	
+	save_flags(flags); 
+	cli();
+
+	info->xmit.head = info->xmit.tail = 0;
+	restore_flags(flags);
+	wake_up_interruptible(&tty->write_wait);
+#ifdef SERIAL_HAVE_POLL_WAIT
+	wake_up_interruptible(&tty->poll_wait);
+#endif
+	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+	    tty->ldisc.write_wakeup)
+		(tty->ldisc.write_wakeup)(tty);
+}
+
+
+static int get_serial_info(struct async_struct * info,
+			   struct serial_struct * retinfo)
+{
+	struct serial_struct tmp;
+	struct serial_state *state = info->state;
+   
+	if (!retinfo)
+		return -EFAULT;
+
+	memset(&tmp, 0, sizeof(tmp));
+	tmp.type = state->type;
+	tmp.line = state->line;
+	tmp.port = state->port;
+	//if (HIGH_BITS_OFFSET)
+	//	tmp.port_high = state->port >> HIGH_BITS_OFFSET;
+	//else
+		tmp.port_high = 0;
+	tmp.irq = state->irq;
+	tmp.flags = state->flags;
+	tmp.xmit_fifo_size = state->xmit_fifo_size;
+	tmp.baud_base = state->baud_base;
+	tmp.close_delay = state->close_delay;
+	tmp.closing_wait = state->closing_wait;
+	tmp.custom_divisor = state->custom_divisor;
+	tmp.hub6 = state->hub6;
+	tmp.io_type = state->io_type;
+	if (copy_to_user(retinfo,&tmp,sizeof(*retinfo)))
+		return -EFAULT;
+	return 0;
+}
+
+
+#if 0
+static int set_serial_info(struct async_struct * info,
+			   struct serial_struct * new_info)
+{
+	struct serial_struct new_serial;
+ 	struct serial_state old_state, *state;
+	unsigned int		i,change_irq,change_port;
+	int 			retval = 0;
+	unsigned long		new_port;
+
+	if (copy_from_user(&new_serial,new_info,sizeof(new_serial)))
+		return -EFAULT;
+	state = info->state;
+	old_state = *state;
+
+	new_port = new_serial.port;
+	if (HIGH_BITS_OFFSET)
+		new_port += (unsigned long) new_serial.port_high << HIGH_BITS_OFFSET;
+
+	change_irq = new_serial.irq != state->irq;
+	change_port = (new_port != ((int) state->port)) ||
+		(new_serial.hub6 != state->hub6);
+  
+	if (!capable(CAP_SYS_ADMIN)) {
+		if (change_irq || change_port ||
+		    (new_serial.baud_base != state->baud_base) ||
+		    (new_serial.type != state->type) ||
+		    (new_serial.close_delay != state->close_delay) ||
+		    (new_serial.xmit_fifo_size != state->xmit_fifo_size) ||
+		    ((new_serial.flags & ~ASYNC_USR_MASK) !=
+		     (state->flags & ~ASYNC_USR_MASK)))
+			return -EPERM;
+		state->flags = ((state->flags & ~ASYNC_USR_MASK) |
+			       (new_serial.flags & ASYNC_USR_MASK));
+		info->flags = ((info->flags & ~ASYNC_USR_MASK) |
+			       (new_serial.flags & ASYNC_USR_MASK));
+		state->custom_divisor = new_serial.custom_divisor;
+		goto check_and_exit;
+	}
+
+	new_serial.irq = irq_cannonicalize(new_serial.irq);
+
+	if ((new_serial.irq >= NR_IRQS) || (new_serial.irq < 0) || 
+	    (new_serial.baud_base < 9600)|| (new_serial.type < PORT_UNKNOWN) ||
+	    (new_serial.type > PORT_MAX) || (new_serial.type == PORT_CIRRUS) ||
+	    (new_serial.type == PORT_STARTECH)) {
+		return -EINVAL;
+	}
+
+	if ((new_serial.type != state->type) ||
+	    (new_serial.xmit_fifo_size <= 0))
+		new_serial.xmit_fifo_size =
+			uart_config[new_serial.type].dfl_xmit_fifo_size;
+
+	/* Make sure address is not already in use */
+	if (new_serial.type) {
+		for (i = 0 ; i < NR_PORTS; i++)
+			if ((state != &rs_table[i]) &&
+			    (rs_table[i].port == new_port) &&
+			    rs_table[i].type)
+				return -EADDRINUSE;
+	}
+
+	if ((change_port || change_irq) && (state->count > 1))
+		return -EBUSY;
+
+	/*
+	 * OK, past this point, all the error checking has been done.
+	 * At this point, we start making changes.....
+	 */
+
+	state->baud_base = new_serial.baud_base;
+	state->flags = ((state->flags & ~ASYNC_FLAGS) |
+			(new_serial.flags & ASYNC_FLAGS));
+	info->flags = ((state->flags & ~ASYNC_INTERNAL_FLAGS) |
+		       (info->flags & ASYNC_INTERNAL_FLAGS));
+	state->custom_divisor = new_serial.custom_divisor;
+	state->close_delay = new_serial.close_delay * HZ/100;
+	state->closing_wait = new_serial.closing_wait * HZ/100;
+	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
+	info->xmit_fifo_size = state->xmit_fifo_size =
+		new_serial.xmit_fifo_size;
+
+	if ((state->type != PORT_UNKNOWN) && state->port) {
+		release_region(state->port,8);
+	}
+	state->type = new_serial.type;
+	if (change_port || change_irq) {
+		/*
+		 * We need to shutdown the serial port at the old
+		 * port/irq combination.
+		 */
+		shutdown(info);
+		state->irq = new_serial.irq;
+		info->port = state->port = new_port;
+		info->hub6 = state->hub6 = new_serial.hub6;
+		if (info->hub6)
+			info->io_type = state->io_type = SERIAL_IO_HUB6;
+		else if (info->io_type == SERIAL_IO_HUB6)
+			info->io_type = state->io_type = SERIAL_IO_PORT;
+	}
+	if ((state->type != PORT_UNKNOWN) && state->port) {
+			request_region(state->port,8,"serial(set)");
+	}
+
+	
+check_and_exit:
+	if (!state->port || !state->type)
+		return 0;
+	if (info->flags & ASYNC_INITIALIZED) {
+		if (((old_state.flags & ASYNC_SPD_MASK) !=
+		     (state->flags & ASYNC_SPD_MASK)) ||
+		    (old_state.custom_divisor != state->custom_divisor)) {
+			if ((state->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
+				info->tty->alt_speed = 57600;
+			if ((state->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
+				info->tty->alt_speed = 115200;
+			if ((state->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
+				info->tty->alt_speed = 230400;
+			if ((state->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
+				info->tty->alt_speed = 460800;
+			change_speed(info, 0);
+		}
+	} else {
+		retval = startup(info);
+	}
+	return retval;
+}
+#endif
+
+
+static int rs_ioctl(struct tty_struct *tty, struct file * file,
+		    unsigned int cmd, unsigned long arg)
+{
+	struct async_struct * info = (struct async_struct *)tty->driver_data;
+	struct async_icount cprev, cnow;	/* kernel counter temps */
+	struct serial_icounter_struct icount;
+	unsigned long flags;
+	
+	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
+	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
+	    (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT)) {
+		if (tty->flags & (1 << TTY_IO_ERROR))
+		    return -EIO;
+	}
+	
+	switch (cmd) {
+		//case TIOCMGET:
+		//	return get_modem_info(info, (unsigned int *) arg);
+		case TIOCMBIS:
+		case TIOCMBIC:
+		//case TIOCMSET:
+		//	return set_modem_info(info, cmd, (unsigned int *) arg);
+		case TIOCGSERIAL:
+			return get_serial_info(info,
+					       (struct serial_struct *) arg);
+		//case TIOCSSERIAL:
+		//	return set_serial_info(info,
+					       //(struct serial_struct *) arg);
+		//case TIOCSERCONFIG:
+		//	return do_autoconfig(info);
+
+		//case TIOCSERGETLSR: /* Get line status register */
+		//	return get_lsr_info(info, (unsigned int *) arg);
+
+		case TIOCSERGSTRUCT:
+			if (copy_to_user((struct async_struct *) arg,
+					 info, sizeof(struct async_struct)))
+				return -EFAULT;
+			return 0;
+				
+			
+		/*
+		 * Wait for any of the 4 modem inputs (DCD,RI,DSR,CTS) to change
+		 * - mask passed in arg for lines of interest
+ 		 *   (use |'ed TIOCM_RNG/DSR/CD/CTS for masking)
+		 * Caller should use TIOCGICOUNT to see which one it was
+		 */
+		case TIOCMIWAIT:
+#if 0
+			save_flags(flags); 
+			cli();
+			/* note the counters on entry */
+			cprev = info->state->icount;
+			restore_flags(flags);
+			/* Force modem status interrupts on */
+			info->IER |= UART_IER_MSI;
+			serial_out(info, UART_IER, info->IER);
+			while (1) {
+				interruptible_sleep_on(&info->delta_msr_wait);
+				/* see if a signal did it */
+				if (signal_pending(current))
+					return -ERESTARTSYS;
+				save_flags(flags); cli();
+				cnow = info->state->icount; /* atomic copy */
+				restore_flags(flags);
+				if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr && 
+				    cnow.dcd == cprev.dcd && cnow.cts == cprev.cts)
+					return -EIO; /* no change => error */
+				if ( ((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
+				     ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
+				     ((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
+				     ((arg & TIOCM_CTS) && (cnow.cts != cprev.cts)) ) {
+					return 0;
+				}
+				cprev = cnow;
+			}
+			/* NOTREACHED */
+#endif
+
+		/* 
+		 * Get counter of input serial line interrupts (DCD,RI,DSR,CTS)
+		 * Return: write counters to the user passed counter struct
+		 * NB: both 1->0 and 0->1 transitions are counted except for
+		 *     RI where only 0->1 is counted.
+		 */
+		case TIOCGICOUNT:
+			save_flags(flags); 
+			cli();
+			cnow = info->state->icount;
+			restore_flags(flags);
+			icount.cts = cnow.cts;
+			icount.dsr = cnow.dsr;
+			icount.rng = cnow.rng;
+			icount.dcd = cnow.dcd;
+			icount.rx = cnow.rx;
+			icount.tx = cnow.tx;
+			icount.frame = cnow.frame;
+			icount.overrun = cnow.overrun;
+			icount.parity = cnow.parity;
+			icount.brk = cnow.brk;
+			icount.buf_overrun = cnow.buf_overrun;
+			
+			if (copy_to_user((void *)arg, &icount, sizeof(icount)))
+				return -EFAULT;
+			return 0;
+		case TIOCSERGWILD:
+		case TIOCSERSWILD:
+			/* "setserial -W" is called in Debian boot */
+			printk ("TIOCSER?WILD ioctl obsolete, ignored.\n");
+			return 0;
+
+		default:
+			return -ENOIOCTLCMD;
+	}
+
+	return 0;
+}
+
+
+/*
+ * ------------------------------------------------------------
+ * rs_throttle()
+ * 
+ * This routine is called by the upper-layer tty layer to signal that
+ * incoming characters should be throttled.
+ * ------------------------------------------------------------
+ */
+static void rs_throttle(struct tty_struct * tty)
+{
+#if 0
+	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	unsigned long flags;
+#ifdef SERIAL_DEBUG_THROTTLE
+	char	buf[64];
+	
+	printk("throttle %s: %d....\n", tty_name(tty, buf),
+	       tty->ldisc.chars_in_buffer(tty));
+#endif
+
+	if (I_IXOFF(tty))
+		rs_send_xchar(tty, STOP_CHAR(tty));
+
+	if (tty->termios->c_cflag & CRTSCTS)
+		info->MCR &= ~UART_MCR_RTS;
+
+	save_flags(flags); cli();
+	serial_out(info, UART_MCR, info->MCR);
+	restore_flags(flags);
+#endif
+}
+
+
+static void rs_unthrottle(struct tty_struct * tty)
+{
+#if 0
+	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	unsigned long flags;
+#ifdef SERIAL_DEBUG_THROTTLE
+	char	buf[64];
+	
+	printk("unthrottle %s: %d....\n", tty_name(tty, buf),
+	       tty->ldisc.chars_in_buffer(tty));
+#endif
+
+	if (I_IXOFF(tty)) {
+		if (info->x_char)
+			info->x_char = 0;
+		else
+			rs_send_xchar(tty, START_CHAR(tty));
+	}
+	//if (tty->termios->c_cflag & CRTSCTS)
+	//	info->MCR |= UART_MCR_RTS;
+	save_flags(flags); 
+	cli();
+	//serial_out(info, UART_MCR, info->MCR);
+	restore_flags(flags);
+#endif
+}
+
+
+static void rs_set_termios(struct tty_struct *tty, struct termios *old_termios)
+{
+#if 0
+	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	unsigned long flags;
+	unsigned int cflag = tty->termios->c_cflag;
+	
+	if ((cflag == old_termios->c_cflag)
+	    && (RELEVANT_IFLAG(tty->termios->c_iflag) 
+		== RELEVANT_IFLAG(old_termios->c_iflag)))
+	  return;
+
+	/* Handle transition to B0 status */
+	if ((old_termios->c_cflag & CBAUD) &&
+	    !(cflag & CBAUD)) {
+		info->MCR &= ~(UART_MCR_DTR|UART_MCR_RTS);
+		save_flags(flags); cli();
+		serial_out(info, UART_MCR, info->MCR);
+		restore_flags(flags);
+	}
+	
+	/* Handle transition away from B0 status */
+	if (!(old_termios->c_cflag & CBAUD) &&
+	    (cflag & CBAUD)) {
+		info->MCR |= UART_MCR_DTR;
+		if (!(tty->termios->c_cflag & CRTSCTS) || 
+		    !test_bit(TTY_THROTTLED, &tty->flags)) {
+			info->MCR |= UART_MCR_RTS;
+		}
+		save_flags(flags); cli();
+		serial_out(info, UART_MCR, info->MCR);
+		restore_flags(flags);
+	}
+	
+	/* Handle turning off CRTSCTS */
+	if ((old_termios->c_cflag & CRTSCTS) &&
+	    !(tty->termios->c_cflag & CRTSCTS)) {
+		tty->hw_stopped = 0;
+		rs_start(tty);
+	}
+#endif
+}
+
+
+/*
+ * ------------------------------------------------------------
+ * rs_stop() and rs_start()
+ *
+ * This routines are called before setting or resetting tty->stopped.
+ * They enable or disable transmitter interrupts, as necessary.
+ * ------------------------------------------------------------
+ */
+static void rs_stop(struct tty_struct *tty)
+{
+	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	unsigned long flags;
+
+	save_flags(flags); 
+	cli();
+	
+	if (info->IER & UART_TX_INT_EN) {
+		info->IER &= ~UART_TX_INT_EN;
+		serial_out(info, UART_CR_REG, info->IER);
+	}
+	restore_flags(flags);
+}
+
+
+
+static void rs_start(struct tty_struct *tty)
+{
+	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	unsigned long flags;
+	
+	save_flags(flags); 
+	cli();
+	
+	if (info->xmit.head != info->xmit.tail
+	    && info->xmit.buf
+	    && !(info->IER & UART_TX_INT_EN)) {
+		info->IER |= UART_TX_INT_EN;
+		serial_out(info, UART_CR_REG, info->IER);
+	}
+	restore_flags(flags);
+}
+
+
+/*
+ * rs_hangup() --- called by tty_hangup() when a hangup is signaled.
+ */
+static void rs_hangup(struct tty_struct *tty)
+{
+	struct async_struct * info = (struct async_struct *)tty->driver_data;
+	struct serial_state *state = info->state;
+	
+	state = info->state;
+	
+	rs_flush_buffer(tty);
+	
+	if (info->flags & ASYNC_CLOSING)
+		return;
+
+	info->event = 0;
+	state->count = 0;
+//	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CALLOUT_ACTIVE);
+	info->flags &= ~(ASYNC_NORMAL_ACTIVE);
+	info->tty = 0;
+	wake_up_interruptible(&info->open_wait);
+}
+
+
+/*
+ * rs_break() --- routine which turns the break handling on or off
+ */
+static void rs_break(struct tty_struct *tty, int break_state)
+{
+	struct async_struct * info = (struct async_struct *)tty->driver_data;
+	unsigned long flags;
+	
+	if (!CONFIGURED_SERIAL_PORT(info))
+		return;
+	
+	save_flags(flags); 
+	cli();
+	if (break_state == -1)
+		info->LCR |= UART_SEND_BREAK;
+	else
+		info->LCR &= ~UART_SEND_BREAK;
+	
+	serial_out(info, UART_LCR_H_REG, info->LCR);
+	restore_flags(flags);
+}
+
+
+/*
+ * This function is used to send a high-priority XON/XOFF character to
+ * the device
+ */
+static void rs_send_xchar(struct tty_struct *tty, char ch)
+{
+	struct async_struct *info = (struct async_struct *)tty->driver_data;
+
+	info->x_char = ch;
+	if (ch) {
+		/* Make sure transmit interrupts are on */
+		info->IER |= UART_TX_INT_EN;
+		serial_out(info, UART_CR_REG, info->IER);
+	}
+}
+
+
+/*
+ * rs_wait_until_sent() --- wait until the transmitter is empty
+ */
+static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
+{
+#if 0
+	struct async_struct * info = (struct async_struct *)tty->driver_data;
+	unsigned long orig_jiffies, char_time;
+	int lsr;
+	
+	if (info->state->type == PORT_UNKNOWN)
+		return;
+
+	if (info->xmit_fifo_size == 0)
+		return; /* Just in case.... */
+
+	orig_jiffies = jiffies;
+	/*
+	 * Set the check interval to be 1/5 of the estimated time to
+	 * send a single character, and make it at least 1.  The check
+	 * interval should also be less than the timeout.
+	 * 
+	 * Note: we have to use pretty tight timings here to satisfy
+	 * the NIST-PCTS.
+	 */
+	char_time = (info->timeout - HZ/50) / info->xmit_fifo_size;
+	char_time = char_time / 5;
+	if (char_time == 0)
+		char_time = 1;
+	if (timeout && timeout < char_time)
+		char_time = timeout;
+	/*
+	 * If the transmitter hasn't cleared in twice the approximate
+	 * amount of time to send the entire FIFO, it probably won't
+	 * ever clear.  This assumes the UART isn't doing flow
+	 * control, which is currently the case.  Hence, if it ever
+	 * takes longer than info->timeout, this is probably due to a
+	 * UART bug of some kind.  So, we clamp the timeout parameter at
+	 * 2*info->timeout.
+	 */
+	if (!timeout || timeout > 2*info->timeout)
+		timeout = 2*info->timeout;
+#ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
+	printk("In rs_wait_until_sent(%d) check=%lu...", timeout, char_time);
+	printk("jiff=%lu...", jiffies);
+#endif
+	while (!((lsr = serial_inp(info, UART_LSR)) & UART_LSR_TEMT)) {
+#ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
+		printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
+#endif
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(char_time);
+		if (signal_pending(current))
+			break;
+		if (timeout && time_after(jiffies, orig_jiffies + timeout))
+			break;
+	}
+	set_current_state(TASK_RUNNING);
+#ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
+	printk("lsr = %d (jiff=%lu)...done\n", lsr, jiffies);
+#endif
+#endif
+}
+
+/*
+ * /proc fs routines....
+ */
+
+static inline int line_info(char *buf, struct serial_state *state)
+{
+#if 0
+	struct async_struct *info = state->info, scr_info;
+	char	stat_buf[30], control, status;
+	int	ret;
+	unsigned long flags;
+
+	ret = sprintf(buf, "%d: uart:%s port:%lX irq:%d",
+		      state->line, uart_config[state->type].name, 
+		      state->port, state->irq);
+
+	if (!state->port || (state->type == PORT_UNKNOWN)) {
+		ret += sprintf(buf+ret, "\n");
+		return ret;
+	}
+
+	/*
+	 * Figure out the current RS-232 lines
+	 */
+	if (!info) {
+		info = &scr_info;	/* This is just for serial_{in,out} */
+
+		info->magic = SERIAL_MAGIC;
+		info->port = state->port;
+		info->flags = state->flags;
+		info->quot = 0;
+		info->tty = 0;
+	}
+	save_flags(flags); cli();
+	status = serial_in(info, UART_MSR);
+	control = info != &scr_info ? info->MCR : serial_in(info, UART_MCR);
+	restore_flags(flags); 
+
+	stat_buf[0] = 0;
+	stat_buf[1] = 0;
+	if (control & UART_MCR_RTS)
+		strcat(stat_buf, "|RTS");
+	if (status & UART_MSR_CTS)
+		strcat(stat_buf, "|CTS");
+	if (control & UART_MCR_DTR)
+		strcat(stat_buf, "|DTR");
+	if (status & UART_MSR_DSR)
+		strcat(stat_buf, "|DSR");
+	if (status & UART_MSR_DCD)
+		strcat(stat_buf, "|CD");
+	if (status & UART_MSR_RI)
+		strcat(stat_buf, "|RI");
+
+	if (info->quot) {
+		ret += sprintf(buf+ret, " baud:%d",
+			       state->baud_base / info->quot);
+	}
+
+	ret += sprintf(buf+ret, " tx:%d rx:%d",
+		      state->icount.tx, state->icount.rx);
+
+	if (state->icount.frame)
+		ret += sprintf(buf+ret, " fe:%d", state->icount.frame);
+	
+	if (state->icount.parity)
+		ret += sprintf(buf+ret, " pe:%d", state->icount.parity);
+	
+	if (state->icount.brk)
+		ret += sprintf(buf+ret, " brk:%d", state->icount.brk);	
+
+	if (state->icount.overrun)
+		ret += sprintf(buf+ret, " oe:%d", state->icount.overrun);
+
+	/*
+	 * Last thing is the RS-232 status lines
+	 */
+	ret += sprintf(buf+ret, " %s\n", stat_buf+1);
+	return ret;
+#endif
+	return 0;
+}
+
+
+int rs_read_proc(char *page, char **start, off_t off, int count,
+		 int *eof, void *data)
+{
+	int i, len = 0, l;
+	off_t	begin = 0;
+
+	len += sprintf(page, "serinfo:1.0 driver:%s%s revision:%s\n",
+		       serial_version, LOCAL_VERSTRING, serial_revdate);
+	for (i = 0; i < NR_PORTS && len < 4000; i++) {
+		l = line_info(page + len, &rs_table[i]);
+		len += l;
+		if (len+begin > off+count)
+			goto done;
+		if (len+begin < off) {
+			begin += len;
+			len = 0;
+		}
+	}
+	*eof = 1;
+done:
+	if (off >= len+begin)
+		return 0;
+	*start = page + (off-begin);
+	return ((count < begin+len-off) ? count : begin+len-off);
+}
+
+
+/* 
+ * This routine must be called by kernel at boot time 
+ */
+int __init serial5120_init(void) 
+{
+	memset(&dev_tty_driver, 0, sizeof(struct tty_driver));
+
+	dev_tty_driver.magic = TTY_DRIVER_MAGIC;
+	dev_tty_driver.driver_name = "/dev/ttyS0";
+	dev_tty_driver.name = "ttyS0";
+	dev_tty_driver.major = TTY_MAJOR;
+	dev_tty_driver.minor_start = 64;
+	dev_tty_driver.num = 1;
+	dev_tty_driver.type = TTY_DRIVER_TYPE_SERIAL;
+	dev_tty_driver.subtype = SERIAL_TYPE_NORMAL;
+	dev_tty_driver.init_termios = tty_std_termios;
+	dev_tty_driver.init_termios.c_cflag =
+		B115200 | CS8 | CREAD | HUPCL | CLOCAL;
+	dev_tty_driver.flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
+//	dev_tty_driver.refcount = &serial_refcount;
+//	dev_tty_driver.table = serial_table;
+	dev_tty_driver.termios = serial_termios;
+	dev_tty_driver.termios_locked = serial_termios_locked;
+
+	dev_tty_driver.open = rs_open;
+	dev_tty_driver.close = rs_close;
+	dev_tty_driver.write = rs_write;
+	dev_tty_driver.put_char = rs_put_char;
+	dev_tty_driver.flush_chars = rs_flush_chars;
+	dev_tty_driver.write_room = rs_write_room;
+	dev_tty_driver.chars_in_buffer = rs_chars_in_buffer;
+	dev_tty_driver.flush_buffer = rs_flush_buffer;
+	dev_tty_driver.ioctl = rs_ioctl;
+	dev_tty_driver.throttle = rs_throttle;
+	dev_tty_driver.unthrottle = rs_unthrottle;
+	dev_tty_driver.set_termios = rs_set_termios;
+	dev_tty_driver.stop = rs_stop;
+	dev_tty_driver.start = rs_start;
+	dev_tty_driver.hangup = rs_hangup;
+	dev_tty_driver.break_ctl = rs_break;
+	dev_tty_driver.send_xchar = rs_send_xchar;
+	dev_tty_driver.wait_until_sent = rs_wait_until_sent;
+	dev_tty_driver.read_proc = rs_read_proc;
+
+	if (tty_register_driver(&dev_tty_driver))
+		panic("Couldn't register /dev/ttyS0 driver\n");
+
+	return 0;
+}
+
+__initcall(serial5120_init);
diff -ruN linux-2.6.10/arch/mips/am5120/setup.c linux-2.6.10-adm.1/arch/mips/am5120/setup.c
--- linux-2.6.10/arch/mips/am5120/setup.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/am5120/setup.c	2005-01-27 21:06:17.000000000 +0100
@@ -0,0 +1,119 @@
+/*****************************************************************************
+;
+;   (C) Unpublished Work of ADMtek Incorporated.  All Rights Reserved.
+;
+;       THIS WORK IS AN UNPUBLISHED WORK AND CONTAINS CONFIDENTIAL,
+;       PROPRIETARY AND TRADESECRET INFORMATION OF ADMTEK INCORPORATED.
+;       ACCESS TO THIS WORK IS RESTRICTED TO (I) ADMTEK EMPLOYEES WHO HAVE A
+;       NEED TO KNOW TO PERFORM TASKS WITHIN THE SCOPE OF THEIR ASSIGNMENTS
+;       AND (II) ENTITIES OTHER THAN ADMTEK WHO HAVE ENTERED INTO APPROPRIATE
+;       LICENSE AGREEMENTS.  NO PART OF THIS WORK MAY BE USED, PRACTICED,
+;       PERFORMED, COPIED, DISTRIBUTED, REVISED, MODIFIED, TRANSLATED,
+;       ABBRIDGED, CONDENSED, EXPANDED, COLLECTED, COMPILED, LINKED, RECAST,
+;       TRANSFORMED OR ADAPTED WITHOUT THE PRIOR WRITTEN CONSENT OF ADMTEK.
+;       ANY USE OR EXPLOITATION OF THIS WORK WITHOUT AUTHORIZATION COULD
+;       SUBJECT THE PERPERTRATOR TO CRIMINAL AND CIVIL LIABILITY.
+;
+;------------------------------------------------------------------------------
+;
+;    Project : ADM5120
+;    Creator : daniell@admtek.com.tw
+;    File    : arch/mips/am5120/setup.c
+;	 Date    : 2003.3.4
+;    Abstract: 
+;
+;Modification History:
+;
+;*****************************************************************************/
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/serial.h>
+#include <linux/types.h>
+#include <linux/string.h>	/* for memset */
+
+#include <asm/reboot.h>
+#include <asm/io.h>
+#include <asm/time.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/am5120/adm5120.h>
+
+
+//extern struct rtc_ops am5120_rtc_ops;
+//extern struct rtc_ops *rtc_ops;
+
+void  mips_timer_setup(struct irqaction *irq);
+void  mips_time_init(void);
+
+int am5120_pci_module;
+
+
+void am5120_restart(char *command)
+{
+	int i;
+
+	/* Disable All ports*/
+	ADM5120_SW_REG(Port_conf0_REG) |= SW_DISABLE_PORT_MASK;
+
+	/* Disable CPU port */
+	ADM5120_SW_REG(CPUp_conf_REG) |= SW_CPU_PORT_DISABLE;
+
+	// Wait until switch DMA idle. At least 1ms is required!!!!
+	for (i=0; i <1000000; i++);
+
+	ADM5120_SW_REG(SftRest_REG) = SOFTWARE_RESET;
+}
+
+
+void am5120_halt(void)
+{
+        printk(KERN_NOTICE "\n** You can safely turn off the power\n");
+        while (1);
+}
+
+
+void am5120_power_off(void)
+{
+        am5120_halt();
+}
+
+static int __init am5120_setup(void)
+{
+	printk("ADM5120 board setup\n");
+
+	board_time_init = mips_time_init;
+	board_timer_setup = mips_timer_setup;
+
+	_machine_restart = am5120_restart;
+	_machine_halt = am5120_halt;
+	_machine_power_off = am5120_power_off;
+
+//	rtc_ops = &am5120_rtc_ops;
+
+	set_io_port_base(KSEG1);
+
+	/* check pci in existence or not */
+	if (ADM5120_SW_REG(CODE_REG) & CPU_PQFP_MODE)
+	{
+		printk("System no PCI BIOS\n");
+		am5120_pci_module = 0;
+	}
+	else
+	{
+		printk("System has PCI BIOS\n");
+		am5120_pci_module = 1;
+	}
+	return 0;
+}
+
+early_initcall(am5120_setup);
+
+const char *get_system_type(void)
+{
+	return "ADM5120 Board";
+}
diff -ruN linux-2.6.10/arch/mips/am5120/time.c linux-2.6.10-adm.1/arch/mips/am5120/time.c
--- linux-2.6.10/arch/mips/am5120/time.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/am5120/time.c	2005-01-27 21:06:17.000000000 +0100
@@ -0,0 +1,98 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2005 Jeroen Vreeken (pe1rxq@amsat.org)
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ *
+ * Setting up the clock on the MIPS boards.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel_stat.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+
+#include <asm/mipsregs.h>
+#include <asm/ptrace.h>
+#include <asm/hardirq.h>
+#include <asm/div64.h>
+#include <asm/cpu.h>
+#include <asm/am5120/adm5120.h>
+
+#include <linux/interrupt.h>
+#include <linux/timex.h>
+#include <asm/time.h>
+#include <asm/mipsregs.h>
+
+
+unsigned int mips_counter_frequency;
+
+#define ALLINTS (IE_IRQ0 | IE_IRQ5 | STATUS_IE)
+
+#define MIPS_CPU_TIMER_IRQ 7
+
+
+void mips_timer_interrupt(struct pt_regs *regs)
+{
+	write_c0_compare(read_c0_count()+ mips_counter_frequency/HZ);
+	ll_timer_interrupt(MIPS_CPU_TIMER_IRQ, regs);
+}
+
+
+void __init mips_time_init(void)
+{
+	unsigned long clock;
+
+	clock = (ADM5120_SW_REG(CODE_REG) & CODE_CLK_MASK) >> CODE_CLK_SHIFT;
+
+	switch (clock)
+	{
+	case CPU_CLK_175MHZ:
+		mips_counter_frequency = CPU_SPEED_175M;
+		printk("CPU clock: 175MHz\n");
+		break;
+
+	case CPU_CLK_200MHZ:
+		mips_counter_frequency = CPU_SPEED_200M;
+		printk("CPU clock: 200MHz\n");
+		break;
+
+	case CPU_CLK_225MHZ:
+		mips_counter_frequency = CPU_SPEED_225M;
+		printk("CPU clock: 225MHz\n");
+		break;
+
+	case CPU_CLK_250MHZ:
+		mips_counter_frequency = CPU_SPEED_250M;
+		printk("CPU clock: 250MHz\n");
+		break;
+	}
+}
+
+
+void __init mips_timer_setup(struct irqaction *irq)
+{
+	/* to generate the first timer interrupt */
+	write_c0_compare(read_c0_count()+ mips_counter_frequency/HZ);
+	clear_c0_status(ST0_BEV);
+	set_c0_status(ALLINTS);
+}
diff -ruN linux-2.6.10/arch/mips/kernel/head.S linux-2.6.10-adm.1/arch/mips/kernel/head.S
--- linux-2.6.10/arch/mips/kernel/head.S	2004-12-24 22:35:01.000000000 +0100
+++ linux-2.6.10-adm.1/arch/mips/kernel/head.S	2005-01-27 21:06:16.000000000 +0100
@@ -127,12 +127,16 @@
 	 * Necessary for machines which link their kernels at KSEG0.
 	 */
 	.fill	0x400
+#ifdef CONFIG_MIPS_AM5120
+	/* AM5120 bootloader jumps to 0x6d8 */
+	.fill   0x2d8
+	j kernel_entry
+#endif
 
 EXPORT(stext)					# used for profiling
 EXPORT(_stext)
 
 	__INIT
-
 NESTED(kernel_entry, 16, sp)			# kernel entry point
 	setup_c0_status_pri
 
diff -ruN linux-2.6.10/include/asm-mips/am5120/adm5120.h linux-2.6.10-adm.1/include/asm-mips/am5120/adm5120.h
--- linux-2.6.10/include/asm-mips/am5120/adm5120.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/include/asm-mips/am5120/adm5120.h	2005-01-27 21:06:27.000000000 +0100
@@ -0,0 +1,1084 @@
+/*****************************************************************************
+;
+;   (C) Unpublished Work of ADMtek Incorporated.  All Rights Reserved.
+;
+;       THIS WORK IS AN UNPUBLISHED WORK AND CONTAINS CONFIDENTIAL,
+;       PROPRIETARY AND TRADESECRET INFORMATION OF ADMTEK INCORPORATED.
+;       ACCESS TO THIS WORK IS RESTRICTED TO (I) ADMTEK EMPLOYEES WHO HAVE A
+;       NEED TO KNOW TO PERFORM TASKS WITHIN THE SCOPE OF THEIR ASSIGNMENTS
+;       AND (II) ENTITIES OTHER THAN ADMTEK WHO HAVE ENTERED INTO APPROPRIATE
+;       LICENSE AGREEMENTS.  NO PART OF THIS WORK MAY BE USED, PRACTICED,
+;       PERFORMED, COPIED, DISTRIBUTED, REVISED, MODIFIED, TRANSLATED,
+;       ABBRIDGED, CONDENSED, EXPANDED, COLLECTED, COMPILED, LINKED, RECAST,
+;       TRANSFORMED OR ADAPTED WITHOUT THE PRIOR WRITTEN CONSENT OF ADMTEK.
+;       ANY USE OR EXPLOITATION OF THIS WORK WITHOUT AUTHORIZATION COULD
+;       SUBJECT THE PERPERTRATOR TO CRIMINAL AND CIVIL LIABILITY.
+;
+;------------------------------------------------------------------------------
+;
+;    Project : ADM5120
+;    Creator : 
+;    File    : include/asm/am5120/adm5120.h
+;	 Date    : 2003.3.10
+;    Abstract: 
+;
+;Modification History:
+; 
+;	Jeroen Vreeken (pe1rxq@amsat.org)
+;	Changed UART_BAUDDIV() to minimize for rounding errors.
+;	Reformatted (somebody likes 4 character tabs....)
+;
+;*****************************************************************************/
+
+
+#ifndef  __ADM5120_H__
+#define  __ADM5120_H__
+
+
+#include <asm/addrspace.h>
+
+
+/*=========================  Physical Memory Map  ============================*/
+#define SDRAM_BASE			0x00000000
+#define SMEM1_BASE			0x10000000
+
+#define EXTIO0_BASE			0x10C00000
+#define EXTIO1_BASE			0x10E00000
+#define MPMC_BASE			0x11000000
+#define USBHOST_BASE			0x11200000
+#define PCIMEM_BASE			0x11400000
+#define PCIIO_BASE			0x11500000
+#define PCICFG_BASE			0x115FFFF0
+#define MIPS_BASE			0x11A00000
+#define SWCTRL_BASE			0x12000000
+
+#define INTC_BASE			0x12200000
+#define SYSC_BASE			0x12400000
+
+#define UART0_BASE			0x12600000
+#define UART1_BASE			0x12800000
+
+#define SMEM0_BASE			0x1FC00000
+
+
+/*=======================  MIPS interrupt  ===================*/
+#define MIPSINT_SOFT0			0
+#define MIPSINT_SOFT1			1
+#define MIPSINT_IRQ			2
+#define MIPSINT_FIQ			3
+#define MIPSINT_REV0			4
+#define MIPSINT_REV1			5
+#define MIPSINT_REV2			6
+#define MIPSINT_TIMER			7
+
+#define STATUS_IE			0x00000001
+
+/*====================  MultiPort Memory Controller (MPMC) ==================*/
+/* registers offset */
+#define MPMC_CONTROL_REG		0x0000
+#define MPMC_STATUS_REG			0x0004
+#define MPMC_CONFIG_REG			0x0008
+
+#define MPMC_DM_CONTROL_REG		0x0020
+#define MPMC_DM_REFRESH_REG		0x0024
+
+#define MPMC_DM_TRP_REG			0x0030
+#define MPMC_DM_TRAS_REG		0x0034
+#define MPMC_DM_TSREX_REG		0x0038
+#define MPMC_DM_TAPR_REG		0x003C
+#define MPMC_DM_TDAL_REG		0x0040
+#define MPMC_DM_TWR_REG			0x0044
+#define MPMC_DM_TRC_REG			0x0048
+#define MPMC_DM_TRFC_REG		0x004C
+#define MPMC_DM_TXSR_REG		0x0050
+#define MPMC_DM_TRRD_REG		0x0054
+#define MPMC_DM_TMRD_REG		0x0058
+
+#define MPMC_SM_EXTWAIT_REG		0x0080
+
+#define MPMC_DM_CONFIG0_REG		0x0100
+#define MPMC_DM_RASCAS0_REG		0x0104
+
+#define MPMC_DM_CONFIG1_REG		0x0120
+#define MPMC_DM_RASCAS1_REG		0x0124
+
+#define MPMC_SM_CONFIG0_REG		0x0200
+#define MPMC_SM_WAITWEN0_REG		0x0204
+#define MPMC_SM_WAITOEN0_REG		0x0208
+#define MPMC_SM_WAITRD0_REG		0x020C
+#define MPMC_SM_WAITPAGE0_REG		0x0210
+#define MPMC_SM_WAITWR0_REG		0x0214
+#define MPMC_SM_WAITTURN0_REG		0x0218
+
+#define MPMC_SM_CONFIG1_REG		0x0220
+#define MPMC_SM_WAITWEN1_REG		0x0224
+#define MPMC_SM_WAITOEN1_REG		0x0228
+#define MPMC_SM_WAITRD1_REG		0x022C
+#define MPMC_SM_WAITPAGE1_REG		0x0230
+#define MPMC_SM_WAITWR1_REG		0x0234
+#define MPMC_SM_WAITTURN1_REG		0x0238
+
+#define MPMC_SM_CONFIG2_REG		0x0240
+#define MPMC_SM_WAITWEN2_REG		0x0244
+#define MPMC_SM_WAITOEN2_REG		0x0248
+#define MPMC_SM_WAITRD2_REG		0x024C
+#define MPMC_SM_WAITPAGE2_REG		0x0250
+#define MPMC_SM_WAITWR2_REG		0x0254
+#define MPMC_SM_WAITTURN2_REG		0x0258
+
+#define MPMC_SM_CONFIG3_REG		0x0260
+#define MPMC_SM_WAITWEN3_REG		0x0264
+#define MPMC_SM_WAITOEN3_REG		0x0268
+#define MPMC_SM_WAITRD3_REG		0x026C
+#define MPMC_SM_WAITPAGE3_REG		0x0270
+#define MPMC_SM_WAITWR3_REG		0x0274
+#define MPMC_SM_WAITTURN3_REG		0x0278
+
+/* Macro for access MPMC register */
+#define MPMC_REG(_offset) \
+	(*((volatile unsigned long *)(KSEG1ADDR(MPMC_BASE + (_offset)))))
+
+
+/* MPMC_CONTROL_REG (offset: 0x0000) */
+#define MPMC_DRAIN_W_BUF		0x00000008
+#define MPMC_LOW_POWER_MODE		0x00000004
+#define MPMC_ADDR_MIRROR		0x00000002
+#define MPMC_ENABLE			0x00000001
+#define MPMC_CONTROL_MASK		0x0000000f
+
+/* MPMC_STATUS_REG (offset: 0x0004) */
+#define MPMC_SREFACK			0x00000004
+#define MPMC_WBUF_DIRTY			0x00000002
+#define MPMC_BUSY			0x00000001
+#define MPMC_STATUS_MASK		0x00000007
+
+/* MPMC_CONFIG_REG (offset: 0x0008) */
+#define MPMC_CLK_RATIO_1_1		0x00000000
+#define MPMC_CLK_RATIO_1_2		0x00000100
+#define MPMC_LITTLE_ENDIAN		0x00000000
+#define MPMC_BIG_ENDIAN			0x00000001
+#define MPMC_CONFIG_MASK		0x00000101
+
+/* MPMC_DM_CONTROL_REG (offset: 0x0020) */
+#define DM_PVHHOUT_HI_VOLTAGE		0x00008000
+#define DM_RPOUT_HI_VOLTAGE		0x00004000
+#define DM_DEEP_SLEEP_MODE		0x00002000
+
+#define DM_SDRAM_NOP			0x00000180
+#define DM_SDRAM_PRECHARGE_ALL		0x00000100
+#define DM_SDRAM_MODE_SETTING		0x00000080
+#define DM_SDRAM_NORMAL_OP		0x00000000
+#define DM_SDRAM_OPMODE_MASK		0x00000180
+
+#define DM_SELF_REFRESH_MODE		0x00000004
+#define DM_CLKOUT_ALWAYS		0x00000002
+#define DM_CLKEN_ALWAYS			0x00000001
+
+#define MPMC_DM_CONTROL_MASK		0x0000e187
+
+
+/* MPMC_DM_REFRESH_REG (offset:0x0024) */
+#define MPMC_DM_REFRESH_MASK		0x00000300
+
+/* MPMC_DM_TRP_REG (offset: 0x0030) */
+#define MPMC_DM_TRP_MASK		0x0000000f
+
+/* MPMC_DM_TRAS_REG (offset: 0x0034) */
+#define MPMC_DM_TRAS_MASK		0x0000000f
+
+/* MPMC_DM_TSREX_REG (offset: 0x0038) */
+#define MPMC_DM_TSREX_MASK		0x0000000f
+
+/* MPMC_DM_TAPR_REG	(offset: 0x003C) */
+#define MPMC_DM_TAPR_MASK		0x0000000f
+
+/* MPMC_DM_TDAL_REG	(offset: 0x0040) */
+#define MPMC_DM_TDAL_MASK		0x0000000f
+
+/* MPMC_DM_TWR_REG (offset: 0x0044) */
+#define MPMC_DM_TWR_MASK		0x0000000f
+
+/* MPMC_DM_TRC_REG (offset: 0x0048) */
+#define MPMC_DM_TRC_MASK 		0x0000001f
+
+/* MPMC_DM_TRFC_REG (offset: 0x004C) */
+#define MPMC_DM_TRFC_MASK		0x0000001f
+
+/* MPMC_DM_TXSR_REG	(offset: 0x0050) */
+#define MPMC_DM_TXSR_MASK		0x0000001f
+
+/* MPMC_DM_TRRD_REG	(offset: 0x0054) */
+#define MPMC_DM_TRRD_MASK		0x0000000f
+
+/* MPMC_DM_TMRD_REG	(offset: 0x0058) */
+#define MPMC_DM_TMRD_MASK		0x0000000f
+
+/* MPMC_SM_EXTWAIT_REG (offset:	0x0080) */
+#define MPMC_SM_EXTWAIT_MASK		0x0000003f
+
+
+/* MPMC_DM_CONFIG0_REG (offset: 0x0100) */
+/* MPMC_DM_CONFIG1_REG (offset: 0x0120) */
+#define DM_CFG_ROW_WIDTH_13BIT		0x20000000
+#define DM_CFG_ROW_WIDTH_12BIT		0x10000000
+#define DM_CFG_ROW_WIDTH_11BIT		0x00000000
+#define DM_CFG_ROW_WIDTH_MASK		0x30000000
+#define DM_CFG_ROW_WIDTH_SHIFT		28
+
+#define DM_CFG_2BANK_DEV		0x00000000
+#define DM_CFG_4BANK_DEV		0x04000000
+#define DM_CFG_BANK_SHIFT		26
+
+#define DM_CFG_COL_WIDTH_11BIT		0x01400000
+#define DM_CFG_COL_WIDTH_10BIT		0x01000000
+#define DM_CFG_COL_WIDTH_9BIT		0x00c00000
+#define DM_CFG_COL_WIDTH_8BIT		0x00800000
+#define DM_CFG_COL_WIDTH_7BIT		0x00400000
+#define DM_CFG_COL_WIDTH_6BIT		0x00000000
+#define DM_CFG_COL_WIDTH_MASK		0x01c00000
+#define DM_CFG_COL_WIDTH_SHIFT		22
+
+#define DM_CFG_WRITE_PROTECT		0x00100000
+#define DM_CFG_BUFFER_EN		0x00080000
+
+#define DM_CFG_ADDR_MAPPING_MASK	0x00005F80
+
+#define DM_CFG_DEV_SYNC_FLASH		0x00000010
+#define DM_CFG_DEV_LOWPOWER_SDRAM	0x00000008
+#define DM_CFG_DEV_SDRAM		0x00000000
+#define DM_CFG_DEV_MASK			0x00000018
+
+
+/* MPMC_DM_RASCAS0_REG (offset: 0x0104) */
+/* MPMC_DM_RASCAS1_REG (offset: 0x0124) */
+
+#define DM_CAS_LATENCY_3		0x00000300
+#define DM_CAS_LATENCY_2		0x00000200
+#define DM_CAS_LATENCY_1		0x00000100
+
+#define DM_RAS_LATENCY_3		0x00000003
+#define DM_RAS_LATENCY_2		0x00000002
+#define DM_RAS_LATENCY_1		0x00000001
+
+
+/* MPMC_SM_CONFIG0_REG (offset: 0x0200) */
+/* MPMC_SM_CONFIG1_REG (offset: 0x0220) */
+/* MPMC_SM_CONFIG2_REG (offset: 0x0240) */
+/* MPMC_SM_CONFIG3_REG (offset: 0x0260) */
+
+#define SM_WRITE_PROTECT		0x00100000
+#define SM_WRITEBUF_ENABLE		0x00080000
+#define SM_EXTENDED_WAIT		0x00000100
+#define SM_PB				0x00000080
+#define SM_CS_HIGH			0x00000040
+#define SM_PAGE_MODE			0x00000008
+
+#define SM_MEM_WIDTH_32BIT		0x00000002
+#define SM_MEM_WIDTH_16BIT		0x00000001
+#define SM_MEM_WIDTH_8BIT		0x00000000
+	
+#define MPMC_SM_CONFIG_MASK		0x001801cb
+
+
+/* MPMC_SM_WAITWEN0_REG	(offset: 0x0204) */
+/* MPMC_SM_WAITWEN1_REG	(offset: 0x0224) */
+/* MPMC_SM_WAITWEN2_REG	(offset: 0x0244) */
+/* MPMC_SM_WAITWEN3_REG	(offset: 0x0264) */
+#define MPMC_SM_WAITWEN_MASK		0x0000000f
+
+
+/* MPMC_SM_WAITOEN0_REG (offset: 0x0208) */
+/* MPMC_SM_WAITOEN1_REG (offset: 0x0228) */
+/* MPMC_SM_WAITOEN2_REG (offset: 0x0248) */
+/* MPMC_SM_WAITOEN3_REG (offset: 0x0268) */
+#define MPMC_SM_WAITOEN_MASK		0x0000000f
+
+/* MPMC_SM_WAITRD0_REG (offset: 0x020C) */
+/* MPMC_SM_WAITRD1_REG (offset: 0x022C) */
+/* MPMC_SM_WAITRD2_REG (offset: 0x024C) */
+/* MPMC_SM_WAITRD3_REG (offset: 0x026C) */
+#define MPMC_SM_WAITRD_MASK		0x0000001f
+
+/* MPMC_SM_WAITPAGE0_REG (offset: 0x0210) */
+/* MPMC_SM_WAITPAGE1_REG (offset: 0x0230) */
+/* MPMC_SM_WAITPAGE2_REG (offset: 0x0250) */
+/* MPMC_SM_WAITPAGE3_REG (offset: 0x0270) */
+#define MPMC_SM_WAITPAGE_MASK		0x0000001f
+
+
+/* MPMC_SM_WAITWR0_REG (offset: 0x0214) */
+/* MPMC_SM_WAITWR1_REG (offset: 0x0234) */
+/* MPMC_SM_WAITWR2_REG (offset: 0x0254) */
+/* MPMC_SM_WAITWR3_REG (offset: 0x0274) */
+#define MPMC_SM_WAITWR_MASK		0x0000001f
+
+
+/* MPMC_SM_WAITTURN0_REG (offset: 0x0218) */
+/* MPMC_SM_WAITTURN1_REG (offset: 0x0238) */
+/* MPMC_SM_WAITTURN2_REG (offset: 0x0258) */
+/* MPMC_SM_WAITTURN3_REG (offset: 0x0278) */
+#define MPMC_SM_WAITTURN_MASK		0x0000000f
+
+
+/* SDRAM mode register */
+/* ref: SDRAM data sheet. Ex: Micron MT48LC4M16A2 data sheet. */
+#define SDRAM_BTLEN_1			0x0000
+#define SDRAM_BTLEN_2			0x0001
+#define SDRAM_BTLEN_4			0x0002
+#define SDRAM_BTLEN_8			0x0003
+#define SDRAM_BTLEN_FULLPAGE		0x0007
+#define SDRAM_BTLEN_MASK		0x0007
+
+#define SDRAM_BT_SEQUENCIAL		0x0000
+#define SDRAM_BT_INTERLEVED		0x0008
+
+#define SDRAM_CAS_LATENCY_2		0x0020
+#define SDRAM_CAS_LATENCY_3		0x0030
+#define SDRAM_CAS_LATENCY_MASK		0x0030
+
+#define SDRAM_OPMODE_STANDARD		0x0000
+#define SDRAM_OPMODE_MASK		0x0180
+
+#define SDRAM_WBTMODE_ENABLE		0x0000
+#define SDRAM_WBTMODE_DISABLE		0x0200
+
+#define SDRAM_MODEREG_MASK		0x03FF
+
+
+
+/*==========================  Interrupt Controller  ==========================*/
+/* registers offset */
+#define IRQ_STATUS_REG			0x00	/* Read */
+#define IRQ_RAW_STATUS_REG		0x04	/* Read */
+#define IRQ_ENABLE_REG			0x08	/* Read/Write */
+#define IRQ_DISABLE_REG			0x0C	/* Write */
+#define IRQ_SOFT_REG			0x10	/* Write */
+
+#define IRQ_MODE_REG			0x14	/* Read/Write */
+#define FIQ_STATUS_REG			0x18	/* Read */
+
+/* test registers */
+#define IRQ_TESTSRC_REG			0x1c	/* Read/Write */
+#define IRQ_SRCSEL_REG			0x20	/* Read/Write */
+#define IRQ_LEVEL_REG			0x24	/* Read/Write */
+
+/*  Macro for accessing Interrupt controller register  */
+#define ADM5120_INTC_REG(_reg) \
+	(*((volatile unsigned long *)(KSEG1ADDR(INTC_BASE + (_reg)))))
+
+/* interrupt levels */
+#define INT_LVL_TIMER			0	/* Timer */
+#define INT_LVL_UART0			1	/* Uart 0 */
+#define INT_LVL_UART1			2	/* Uart 1 */
+#define INT_LVL_USBHOST			3	/* USB Host */
+#define INT_LVL_EXTIO_0			4	/* External I/O 0 */
+#define INT_LVL_EXTIO_1			5	/* External I/O 1 */
+#define INT_LVL_PCI_0			6	/* PCI 0 */
+#define INT_LVL_PCI_1			7	/* PCI 1 */
+#define INT_LVL_PCI_2			8	/* PCI 2 */
+#define INT_LVL_SWITCH			9	/* Switch */
+#define INT_LVL_MAX			INT_LVL_SWITCH	
+
+/* interrupts */
+#define IRQ_TIMER			(0x1 << INT_LVL_TIMER)
+#define IRQ_UART0			(0x1 << INT_LVL_UART0)
+#define IRQ_UART1			(0x1 << INT_LVL_UART1)
+#define IRQ_USBHOST			(0x1 << INT_LVL_USBHOST)
+#define IRQ_EXTIO_0			(0x1 << INT_LVL_EXTIO_0)
+#define IRQ_EXTIO_1			(0x1 << INT_LVL_EXTIO_1)
+#define IRQ_PCI_INT0			(0x1 << INT_LVL_PCI_0)
+#define IRQ_PCI_INT1			(0x1 << INT_LVL_PCI_1)
+#define IRQ_PCI_INT2			(0x1 << INT_LVL_PCI_2)
+#define IRQ_SWITCH			(0x1 << INT_LVL_SWITCH)
+
+#define IRQ_MASK			0x3ff
+
+
+/* IRQ LEVEL reg */
+#define IRQ_EXTIO0_ACT_LOW		IRQ_EXTIO_0
+#define IRQ_EXTIO1_ACT_LOW		IRQ_EXTIO_1
+#define IRQ_PCIINT0_ACT_LOW		IRQ_PCI_INT0
+#define IRQ_PCIINT1_ACT_LOW		IRQ_PCI_INT1
+#define IRQ_PCIINT2_ACT_LOW		IRQ_PCI_INT2
+
+#define IRQ_LEVEL_MASK			0x01F0
+
+/*=========================  Switch Control Register  ========================*/
+/* Control Register */
+#define CODE_REG								0x0000
+#define SftRest_REG			0x0004
+#define Boot_done_REG			0x0008
+#define SWReset_REG			0x000C
+#define Global_St_REG			0x0010
+#define PHY_st_REG			0x0014
+#define Port_st_REG			0x0018
+#define Mem_control_REG			0x001C	
+#define SW_conf_REG			0x0020
+#define CPUp_conf_REG			0x0024
+#define Port_conf0_REG			0x0028
+#define Port_conf1_REG			0x002C
+#define Port_conf2_REG			0x0030
+
+#define VLAN_G1_REG			0x0040
+#define VLAN_G2_REG			0x0044
+#define Send_trig_REG			0x0048
+#define Srch_cmd_REG			0x004C
+#define ADDR_st0_REG			0x0050
+#define ADDR_st1_REG			0x0054
+#define MAC_wt0_REG			0x0058
+#define MAC_wt1_REG			0x005C
+#define BW_cntl0_REG			0x0060
+#define BW_cntl1_REG			0x0064
+#define PHY_cntl0_REG			0x0068
+#define PHY_cntl1_REG			0x006C
+#define FC_th_REG			0x0070
+#define Adj_port_th_REG			0x0074
+#define Port_th_REG			0x0078
+#define PHY_cntl2_REG			0x007C
+#define PHY_cntl3_REG			0x0080
+#define Pri_cntl_REG			0x0084
+#define VLAN_pri_REG			0x0088
+#define TOS_en_REG			0x008C
+#define TOS_map0_REG			0x0090
+#define TOS_map1_REG			0x0094
+#define Custom_pri1_REG			0x0098
+#define Custom_pri2_REG			0x009C
+
+#define Empty_cnt_REG			0x00A4
+#define Port_cnt_sel_REG		0x00A8
+#define Port_cnt_REG			0x00AC
+#define SW_Int_st_REG			0x00B0
+#define SW_Int_mask_REG			0x00B4
+
+// GPIO config
+#define GPIO_conf0_REG			0x00B8
+#define GPIO_conf2_REG			0x00BC
+
+// Watch dog
+#define Watchdog0_REG			0x00C0
+#define Watchdog1_REG			0x00C4
+
+#define Swap_in_REG			0x00C8
+#define Swap_out_REG			0x00CC
+
+// Tx/Rx Descriptors
+#define Send_HBaddr_REG			0x00D0
+#define Send_LBaddr_REG			0x00D4
+#define Recv_HBaddr_REG			0x00D8
+#define Recv_LBaddr_REG			0x00DC
+#define Send_HWaddr_REG			0x00E0
+#define Send_LWaddr_REG			0x00E4
+#define Recv_HWaddr_REG			0x00E8
+#define Recv_LWaddr_REG			0x00EC
+
+// Timer Control 
+#define Timer_int_REG			0x00F0
+#define Timer_REG			0x00F4
+
+// LED control
+#define Port0_LED_REG			0x0100
+#define Port1_LED_REG			0x0104
+#define Port2_LED_REG			0x0108
+#define Port3_LED_REG			0x010c
+#define Port4_LED_REG			0x0110
+
+
+/* Macros for accessing Switch control register */
+#define ADM5120_SW_REG(_reg) \
+	(*((volatile unsigned long *)(KSEG1ADDR(SWCTRL_BASE + (_reg)))))
+
+
+
+/* CODE_REG */
+#define CODE_ID_MASK			0x00FFFF
+#define CODE_ADM5120_ID			0x5120
+
+#define CODE_REV_MASK			0x0F0000
+#define CODE_REV_SHIFT			16
+#define CODE_REV_ADM5120_0		0x8
+
+#define CODE_CLK_MASK			0x300000
+#define CODE_CLK_SHIFT			20
+
+#define CPU_CLK_175MHZ			0x0
+#define CPU_CLK_200MHZ			0x1
+#define CPU_CLK_225MHZ			0x2
+#define CPU_CLK_250MHZ			0x3
+
+#define CPU_SPEED_175M			(175000000/2)
+#define CPU_SPEED_200M			(200000000/2)
+#define CPU_SPEED_225M			(225000000/2)
+#define CPU_SPEED_250M			(250000000/2)
+
+#define CPU_NAND_BOOT			0x01000000
+#define CPU_DCACHE_2K_WAY		(0x1 << 25)
+#define CPU_DCACHE_2WAY			(0x1 << 26)
+#define CPU_ICACHE_2K_WAY		(0x1 << 27)
+#define CPU_ICACHE_2WAY			(0x1 << 28)
+
+#define CPU_GMII_SUPPORT		0x20000000
+
+#define CPU_PQFP_MODE			(0x1 << 29)
+
+#define CPU_CACHE_LINE_SIZE		16
+
+/* SftRest_REG	*/
+#define SOFTWARE_RESET			0x1
+
+/* Boot_done_REG */
+#define BOOT_DONE			0x1
+
+/* SWReset_REG */
+#define SWITCH_RESET			0x1
+
+/* Global_St_REG */
+#define DATA_BUF_BIST_FAILED		(0x1 << 0)
+#define LINK_TAB_BIST_FAILED		(0x1 << 1)
+#define MC_TAB_BIST_FAILED		(0x1 << 2)
+#define ADDR_TAB_BIST_FAILED		(0x1 << 3)
+#define DCACHE_D_FAILED			(0x3 << 4)
+#define DCACHE_T_FAILED			(0x1 << 6)
+#define ICACHE_D_FAILED			(0x3 << 7)
+#define ICACHE_T_FAILED			(0x1 << 9)
+#define BIST_FAILED_MASK		0x03FF
+
+#define ALLMEM_TEST_DONE		(0x1 << 10)
+
+#define SKIP_BLK_CNT_MASK		0x1FF000
+#define SKIP_BLK_CNT_SHIFT		12
+
+
+/* PHY_st_REG */
+#define PORT_LINK_MASK			0x0000001F
+#define PORT_MII_LINKFAIL		0x00000020
+#define PORT_SPEED_MASK			0x00001F00
+
+#define PORT_GMII_SPD_MASK		0x00006000
+#define PORT_GMII_SPD_10M		0x00000000
+#define PORT_GMII_SPD_100M		0x00002000
+#define PORT_GMII_SPD_1000M		0x00004000
+
+#define PORT_DUPLEX_MASK		0x003F0000
+#define PORT_FLOWCTRL_MASK		0x1F000000
+
+#define PORT_GMII_FLOWCTRL_MASK		0x60000000
+#define PORT_GMII_FC_ON			0x20000000
+#define PORT_GMII_RXFC_ON		0x20000000
+#define PORT_GMII_TXFC_ON		0x40000000
+
+/* Port_st_REG */
+#define PORT_SECURE_ST_MASK		0x001F
+#define MII_PORT_TXC_ERR		0x0080
+
+/* Mem_control_REG */
+#define SDRAM_SIZE_4MBYTES		0x0001
+#define SDRAM_SIZE_8MBYTES		0x0002
+#define SDRAM_SIZE_16MBYTES		0x0003
+#define SDRAM_SIZE_64MBYTES		0x0004
+#define SDRAM_SIZE_128MBYTES		0x0005
+#define SDRAM_SIZE_MASK			0x0007
+
+#define MEMCNTL_SDRAM1_EN		(0x1 << 5)
+
+#define ROM_SIZE_DISABLE		0x0000
+#define ROM_SIZE_512KBYTES		0x0001
+#define ROM_SIZE_1MBYTES		0x0002
+#define	ROM_SIZE_2MBYTES		0x0003
+#define ROM_SIZE_4MBYTES		0x0004
+#define ROM_SIZE_8MBYTES		0x0005
+#define ROM_SIZE_MASK			0x0007
+
+#define ROM0_SIZE_SHIFT			8
+#define ROM1_SIZE_SHIFT			16
+
+
+/* SW_conf_REG */
+#define SW_AGE_TIMER_MASK		0x000000F0
+#define SW_AGE_TIMER_DISABLE		0x00000000
+#define SW_AGE_TIMER_FAST		0x00000080
+#define SW_AGE_TIMER_300SEC		0x00000010
+#define SW_AGE_TIMER_600SEC		0x00000020
+#define SW_AGE_TIMER_1200SEC		0x00000030
+#define SW_AGE_TIMER_2400SEC		0x00000040
+#define SW_AGE_TIMER_4800SEC		0x00000050
+#define SW_AGE_TIMER_9600SEC		0x00000060
+#define SW_AGE_TIMER_19200SEC		0x00000070
+//#define SW_AGE_TIMER_38400SEC		0x00000070
+
+#define SW_BC_PREV_MASK			0x00000300
+#define SW_BC_PREV_DISABLE		0x00000000
+#define SW_BC_PREV_64BC			0x00000100
+#define SW_BC_PREV_48BC			0x00000200
+#define SW_BC_PREV_32BC			0x00000300
+
+#define SW_MAX_LEN_MASK			0x00000C00
+#define SW_MAX_LEN_1536			0x00000000
+#define SW_MAX_LEN_1522			0x00000800
+#define SW_MAX_LEN_1518			0x00000400
+
+#define SW_DIS_COLABT			0x00001000
+
+#define SW_HASH_ALG_MASK		0x00006000
+#define SW_HASH_ALG_DIRECT		0x00000000
+#define SW_HASH_ALG_XOR48		0x00002000
+#define SW_HASH_ALG_XOR32		0x00004000
+
+#define SW_DISABLE_BACKOFF_TIMER	0x00008000
+
+#define SW_BP_NUM_MASK			0x000F0000
+#define SW_BP_NUM_SHIFT			16
+#define SW_BP_MODE_MASK			0x00300000
+#define SW_BP_MODE_DISABLE		0x00000000
+#define SW_BP_MODE_JAM			0x00100000
+#define SW_BP_MODE_JAMALL		0x00200000
+#define SW_BP_MODE_CARRIER		0x00300000
+#define SW_RESRV_MC_FILTER		0x00400000
+#define SW_BISR_DISABLE			0x00800000
+
+#define SW_DIS_MII_WAS_TX		0x01000000
+#define SW_BISS_EN			0x02000000
+#define SW_BISS_TH_MASK			0x0C000000
+#define SW_BISS_TH_SHIFT		26
+#define SW_REQ_LATENCY_MASK		0xF0000000
+#define SW_REQ_LATENCY_SHIFT		28
+
+
+/* CPUp_conf_REG */
+#define SW_CPU_PORT_DISABLE		0x00000001
+#define SW_PADING_CRC			0x00000002
+#define SW_BRIDGE_MODE			0x00000004
+
+#define SW_DIS_UN_SHIFT			9
+#define SW_DIS_UN_MASK			(0x3F << SW_DIS_UN_SHIFT)
+#define SW_DIS_MC_SHIFT			16
+#define SW_DIS_MC_MASK			(0x3F << SW_DIS_MC_SHIFT)
+#define SW_DIS_BC_SHIFT			24
+#define SW_DIS_BC_MASK			(0x3F << SW_DIS_BC_SHIFT)
+
+
+/* Port_conf0_REG */
+#define SW_DISABLE_PORT_MASK		0x0000003F
+#define SW_EN_MC_MASK			0x00003F00
+#define SW_EN_MC_SHIFT			8
+#define SW_EN_BP_MASK			0x003F0000
+#define SW_EN_BP_SHIFT			16
+#define SW_EN_FC_MASK			0x3F000000
+#define SW_EN_FC_SHIFT			24
+
+
+/* Port_conf1_REG */
+#define SW_DIS_SA_LEARN_MASK		0x0000003F
+#define SW_PORT_BLOCKING_MASK		0x00000FC0
+#define SW_PORT_BLOCKING_SHIFT		6
+#define SW_PORT_BLOCKING_ON		0x1
+
+#define SW_PORT_BLOCKING_MODE_MASK	0x0003F000
+#define SW_PORT_BLOCKING_MODE_SHIFT	12
+#define SW_PORT_BLOCKING_CTRLONLY	0x1
+
+#define SW_EN_PORT_AGE_MASK		0x03F00000
+#define SW_EN_PORT_AGE_SHIFT		20
+#define SW_EN_SA_SECURED_MASK		0xFC000000
+#define SW_EN_SA_SECURED_SHIFT		26
+
+
+/* Port_conf2_REG */
+#define SW_GMII_AN_EN			0x00000001
+#define SW_GMII_FORCE_SPD_MASK		0x00000006
+#define SW_GMII_FORCE_SPD_10M		0
+#define SW_GMII_FORCE_SPD_100M		0x2
+#define SW_GMII_FORCE_SPD_1000M		0x4
+
+#define SW_GMII_FORCE_FULL_DUPLEX	0x00000008
+
+#define SW_GMII_FORCE_RXFC		0x00000010
+#define SW_GMII_FORCE_TXFC		0x00000020
+
+#define SW_GMII_EN			0x00000040
+#define SW_GMII_REVERSE			0x00000080
+
+#define SW_GMII_TXC_CHECK_EN		0x00000100
+
+#define SW_LED_FLASH_TIME_MASK		0x00030000
+#define SW_LED_FLASH_TIME_30MS		0x00000000
+#define SW_LED_FLASH_TIME_60MS		0x00010000
+#define SW_LED_FLASH_TIME_240MS		0x00020000
+#define SW_LED_FLASH_TIME_480MS		0x00030000
+
+
+/* Send_trig_REG */
+#define SEND_TRIG_LOW			0x0001
+#define SEND_TRIG_HIGH			0x0002
+
+
+/* Srch_cmd_REG */
+#define SW_MAC_SEARCH_START		0x000001
+#define SW_MAX_SEARCH_AGAIN		0x000002
+
+
+/* MAC_wt0_REG */
+#define SW_MAC_WRITE			0x00000001
+#define SW_MAC_WRITE_DONE		0x00000002
+#define SW_MAC_FILTER_EN		0x00000004
+#define SW_MAC_VLANID_SHIFT		3
+#define SW_MAC_VLANID_MASK		0x00000038
+#define SW_MAC_VLANID_EN		0x00000040
+#define SW_MAC_PORTMAP_MASK		0x00001F80
+#define SW_MAC_PORTMAP_SHIFT		7
+#define SW_MAC_AGE_MASK			(0x7 << 13)
+#define SW_MAC_AGE_STATIC		(0x7 << 13)
+#define SW_MAC_AGE_VALID		(0x1 << 13)
+#define SW_MAC_AGE_EMPTY		0
+
+/* BW_cntl0_REG */
+#define SW_PORT_TX_NOLIMIT		0
+#define SW_PORT_TX_64K			1
+#define SW_PORT_TX_128K			2
+#define SW_PORT_TX_256K			3
+#define SW_PORT_TX_512K			4
+#define SW_PORT_TX_1M			5
+#define SW_PORT_TX_4M			6
+#define SW_PORT_TX_10MK			7
+
+/* BW_cntl1_REG */
+#define SW_TRAFFIC_SHAPE_IPG		(0x1 << 31)
+
+/* PHY_cntl0_REG */
+#define SW_PHY_ADDR_MASK		0x0000001F
+#define PHY_ADDR_MAX			0x1f
+#define SW_PHY_REG_ADDR_MASK		0x00001F00
+#define SW_PHY_REG_ADDR_SHIFT		8
+#define PHY_REG_ADDR_MAX		0x1f
+#define SW_PHY_WRITE			0x00002000
+#define SW_PHY_READ			0x00004000
+#define SW_PHY_WDATA_MASK		0xFFFF0000
+#define SW_PHY_WDATA_SHIFT		16
+
+
+/* PHY_cntl1_REG */
+#define SW_PHY_WRITE_DONE		0x00000001
+#define SW_PHY_READ_DONE		0x00000002
+#define SW_PHY_RDATA_MASK		0xFFFF0000
+#define SW_PHY_RDATA_SHIFT		16
+
+/* FC_th_REG */
+/* Adj_port_th_REG */
+/* Port_th_REG */
+
+/* PHY_cntl2_REG */
+#define SW_PHY_AN_MASK			0x0000001F
+#define SW_PHY_SPD_MASK			0x000003E0
+#define SW_PHY_SPD_SHIFT		5
+#define SW_PHY_DPX_MASK			0x00007C00
+#define SW_PHY_DPX_SHIFT		10
+#define SW_FORCE_FC_MASK		0x000F8000
+#define SW_FORCE_FC_SHIFT		15
+#define SW_PHY_NORMAL_MASK		0x01F00000
+#define SW_PHY_NORMAL_SHIFT		20
+#define SW_PHY_AUTOMDIX_MASK		0x3E000000
+#define SW_PHY_AUTOMDIX_SHIFT		25
+#define SW_PHY_REC_MCCAVERAGE		0x40000000
+
+
+/* PHY_cntl3_REG */
+/* Pri_cntl_REG */
+/* VLAN_pri_REG */
+/* TOS_en_REG */
+/* TOS_map0_REG */
+/* TOS_map1_REG */
+/* Custom_pri1_REG */
+/* Custom_pri2_REG */
+/* Empty_cnt_REG */
+/* Port_cnt_sel_REG */
+/* Port_cnt_REG */
+
+
+/* SW_Int_st_REG & SW_Int_mask_REG */
+#define SEND_H_DONE_INT			0x0000001
+#define SEND_L_DONE_INT			0x0000002
+#define RX_H_DONE_INT			0x0000004
+#define RX_L_DONE_INT			0x0000008
+#define RX_H_DESC_FULL_INT		0x0000010
+#define RX_L_DESC_FULL_INT		0x0000020
+#define PORT0_QUE_FULL_INT		0x0000040
+#define PORT1_QUE_FULL_INT		0x0000080
+#define PORT2_QUE_FULL_INT		0x0000100
+#define PORT3_QUE_FULL_INT		0x0000200
+#define PORT4_QUE_FULL_INT		0x0000400
+#define PORT5_QUE_FULL_INT		0x0000800
+
+#define CPU_QUE_FULL_INT		0x0002000
+#define GLOBAL_QUE_FULL_INT		0x0004000
+#define MUST_DROP_INT			0x0008000
+#define BC_STORM_INT			0x0010000
+
+#define PORT_STATUS_CHANGE_INT		0x0040000
+#define INTRUDER_INT			0x0080000
+#define	WATCHDOG0_EXPR_INT		0x0100000
+#define WATCHDOG1_EXPR_INT		0x0200000
+#define RX_DESC_ERR_INT			0x0400000
+#define SEND_DESC_ERR_INT		0x0800000
+#define CPU_HOLD_INT			0x1000000
+#define SWITCH_INT_MASK			0x1FDEFFF
+
+
+/* GPIO_conf0_REG */
+#define GPIO0_INPUT_MODE		0x00000001
+#define GPIO1_INPUT_MODE		0x00000002
+#define GPIO2_INPUT_MODE		0x00000004
+#define GPIO3_INPUT_MODE		0x00000008
+#define GPIO4_INPUT_MODE		0x00000010
+#define GPIO5_INPUT_MODE		0x00000020
+#define GPIO6_INPUT_MODE		0x00000040
+#define GPIO7_INPUT_MODE		0x00000080
+
+#define GPIO0_OUTPUT_MODE		0
+#define GPIO1_OUTPUT_MODE		0
+#define GPIO2_OUTPUT_MODE		0
+#define GPIO3_OUTPUT_MODE		0
+#define GPIO4_OUTPUT_MODE		0
+#define GPIO5_OUTPUT_MODE		0
+#define GPIO6_OUTPUT_MODE		0
+#define GPIO7_OUTPUT_MODE		0
+
+#define GPIO0_INPUT_MASK		0x00000100
+#define GPIO1_INPUT_MASK		0x00000200
+#define GPIO2_INPUT_MASK		0x00000400
+#define GPIO3_INPUT_MASK		0x00000800
+#define GPIO4_INPUT_MASK		0x00001000
+#define GPIO5_INPUT_MASK		0x00002000
+#define GPIO6_INPUT_MASK		0x00004000
+#define GPIO7_INPUT_MASK		0x00008000
+
+#define GPIO0_OUTPUT_EN			0x00010000
+#define GPIO1_OUTPUT_EN			0x00020000
+#define GPIO2_OUTPUT_EN			0x00040000
+#define GPIO3_OUTPUT_EN			0x00080000
+#define GPIO4_OUTPUT_EN			0x00100000
+#define GPIO5_OUTPUT_EN			0x00200000
+#define GPIO6_OUTPUT_EN			0x00400000
+#define GPIO7_OUTPUT_EN			0x00800000
+
+#define GPIO_CONF0_OUTEN_MASK		0x00ff0000
+
+#define GPIO0_OUTPUT_HI			0x01000000
+#define GPIO1_OUTPUT_HI			0x02000000
+#define GPIO2_OUTPUT_HI			0x04000000
+#define GPIO3_OUTPUT_HI			0x08000000
+#define GPIO4_OUTPUT_HI			0x10000000
+#define GPIO5_OUTPUT_HI			0x20000000
+#define GPIO6_OUTPUT_HI			0x40000000
+#define GPIO7_OUTPUT_HI			0x80000000
+
+#define GPIO0_OUTPUT_LOW		0
+#define GPIO1_OUTPUT_LOW		0
+#define GPIO2_OUTPUT_LOW		0
+#define GPIO3_OUTPUT_LOW		0
+#define GPIO4_OUTPUT_LOW		0
+#define GPIO5_OUTPUT_LOW		0
+#define GPIO6_OUTPUT_LOW		0
+#define GPIO7_OUTPUT_LOW		0
+
+
+/* GPIO_conf2_REG */
+#define EXTIO_WAIT_EN			(0x1 << 6)
+#define EXTIO_CS1_INT1_EN		(0x1 << 5)
+#define EXTIO_CS0_INT0_EN		(0x1 << 4)
+
+/* Watchdog0_REG, Watchdog1_REG */
+#define WATCHDOG0_RESET_EN		0x80000000
+#define WATCHDOG1_DROP_EN		0x80000000
+
+#define WATCHDOG_TIMER_SET_MASK		0x7FFF0000
+#define WATCHDOG_TIMER_SET_SHIFT	16
+#define WATCHDOG_TIMER_MASK		0x00007FFF
+
+
+/* Timer_int_REG */
+#define SW_TIMER_INT_DISABLE		0x10000
+#define SW_TIMER_INT			0x1
+
+/* Timer_REG */
+#define SW_TIMER_EN			0x10000
+#define SW_TIMER_MASK			0xffff
+#define SW_TIMER_10MS_TICKS		0x3D09
+#define SW_TIMER_1MS_TICKS		0x61A
+#define SW_TIMER_100US_TICKS		0x9D
+
+
+/* Port0_LED_REG, Port1_LED_REG, Port2_LED_REG, Port3_LED_REG, Port4_LED_REG*/
+#define GPIOL_INPUT_MODE		0x00
+#define GPIOL_OUTPUT_FLASH		0x01
+#define GPIOL_OUTPUT_LOW		0x02
+#define GPIOL_OUTPUT_HIGH		0x03
+#define GPIOL_LINK_LED			0x04
+#define GPIOL_SPEED_LED			0x05
+#define GPIOL_DUPLEX_LED		0x06
+#define GPIOL_ACT_LED			0x07
+#define GPIOL_COL_LED			0x08
+#define GPIOL_LINK_ACT_LED		0x09
+#define GPIOL_DUPLEX_COL_LED		0x0A
+#define GPIOL_10MLINK_ACT_LED		0x0B
+#define GPIOL_100MLINK_ACT_LED		0x0C
+#define GPIOL_CTRL_MASK			0x0F
+
+#define GPIOL_INPUT_MASK		0x7000
+#define GPIOL_INPUT_0_MASK		0x1000
+#define GPIOL_INPUT_1_MASK		0x2000
+#define GPIOL_INPUT_2_MASK		0x4000
+
+#define PORT_LED0_SHIFT			0
+#define PORT_LED1_SHIFT			4
+#define PORT_LED2_SHIFT			8
+
+
+/*===========================  UART Control Register  ========================*/
+#define UART_DR_REG			0x00
+#define UART_RSR_REG			0x04
+#define UART_ECR_REG			0x04
+#define UART_LCR_H_REG			0x08
+#define UART_LCR_M_REG			0x0c
+#define UART_LCR_L_REG			0x10
+#define UART_CR_REG			0x14
+#define UART_FR_REG			0x18
+#define UART_IIR_REG			0x1c
+#define UART_ICR_REG			0x1C
+#define UART_ILPR_REG			0x20
+
+/*  rsr/ecr reg  */
+#define UART_OVERRUN_ERR		0x08
+#define UART_BREAK_ERR			0x04
+#define UART_PARITY_ERR			0x02
+#define UART_FRAMING_ERR		0x01
+#define UART_RX_STATUS_MASK		0x0f
+#define UART_RX_ERROR	( UART_BREAK_ERR | UART_PARITY_ERR | UART_FRAMING_ERR)
+
+/*  lcr_h reg  */
+#define UART_SEND_BREAK			0x01
+#define UART_PARITY_EN			0x02
+#define UART_EVEN_PARITY		0x04
+#define UART_TWO_STOP_BITS		0x08
+#define UART_ENABLE_FIFO		0x10
+
+#define UART_WLEN_5BITS			0x00
+#define UART_WLEN_6BITS			0x20
+#define UART_WLEN_7BITS			0x40
+#define UART_WLEN_8BITS			0x60
+#define UART_WLEN_MASK			0x60
+
+/*  cr reg  */
+#define UART_PORT_EN			0x01
+#define UART_SIREN			0x02
+#define UART_SIRLP			0x04
+#define UART_MODEM_STATUS_INT_EN	0x08
+#define UART_RX_INT_EN			0x10
+#define UART_TX_INT_EN			0x20
+#define UART_RX_TIMEOUT_INT_EN		0x40
+#define UART_LOOPBACK_EN		0x80
+
+/*  fr reg  */
+#define UART_CTS			0x01
+#define UART_DSR			0x02
+#define UART_DCD			0x04
+#define UART_BUSY			0x08
+#define UART_RX_FIFO_EMPTY		0x10
+#define UART_TX_FIFO_FULL		0x20
+#define UART_RX_FIFO_FULL		0x40
+#define UART_TX_FIFO_EMPTY		0x80
+
+/*  iir/icr reg  */
+#define UART_MODEM_STATUS_INT		0x01
+#define UART_RX_INT			0x02
+#define UART_TX_INT			0x04
+#define UART_RX_TIMEOUT_INT		0x08
+
+#define UART_INT_MASK			0x0f
+
+#define ADM5120_UARTCLK_FREQ		62500000
+
+/* This is slightly different from the ADM5120 manual, this method has better
+   rounding for higher baudrates
+	- Jeroen
+ */
+#define UART_BAUDDIV(_rate) \
+	((unsigned long)(((ADM5120_UARTCLK_FREQ)/(8*(_rate))+1)/2 - 1))
+
+/*  uart_baudrate  */
+#define UART_230400bps_DIVISOR		UART_BAUDDIV(230400)
+#define UART_115200bps_DIVISOR		UART_BAUDDIV(115200)
+#define UART_76800bps_DIVISOR		UART_BAUDDIV(76800)
+#define UART_57600bps_DIVISOR		UART_BAUDDIV(57600)
+#define UART_38400bps_DIVISOR		UART_BAUDDIV(38400)
+#define UART_19200bps_DIVISOR		UART_BAUDDIV(19200)
+#define UART_14400bps_DIVISOR		UART_BAUDDIV(14400)
+#define UART_9600bps_DIVISOR		UART_BAUDDIV(9600)
+#define UART_2400bps_DIVISOR		UART_BAUDDIV(2400)
+#define UART_1200bps_DIVISOR		UART_BAUDDIV(1200)
+
+
+/* Cache Controller */
+//#define ADM5120_CACHE_CTRL_BASE	0x70000000
+#define ADM5120_CACHE_LINE_SIZE		16
+//#define ADM5120_CACHE_CTRL_REGSIZE	4
+
+
+/********** GPIO macro *************/
+#define GPIO_MEASURE	0x000f00f0 //enable output status of pin 0, 1, 2, 3 
+
+#define GPIO_MEASURE_INIT() \
+do { \
+	ADM5120_SW_REG(GPIO_conf0_REG) = GPIO_MEASURE; \
+} while (0)
+
+
+#define GPIO_SET_HI(num) \
+do { \
+	ADM5120_SW_REG(GPIO_conf0_REG) |= 1 << (24 + num); \
+} while (0)
+
+
+#define GPIO_SET_LOW(num) \
+do { \
+	ADM5120_SW_REG(GPIO_conf0_REG) &= ~(1 << (24 + num)); \
+} while (0)
+
+
+#define GPIO_TOGGLE(num) \
+do { \
+	ADM5120_SW_REG(GPIO_conf0_REG) ^= (1 << (24 + num)); \
+} while (0)
+
+
+#define BOOT_LINE_SIZE	256
+#define BSP_STR_LEN		64
+
+/*
+ * System configuration
+ */
+typedef struct BOARD_CFG_S
+{
+	unsigned long blmagic;
+	unsigned char bootline[BOOT_LINE_SIZE+1];
+	
+	unsigned long macmagic;
+    unsigned char mac[4][8];
+
+	unsigned long idmagic;    
+    unsigned char serial[BSP_STR_LEN+1];
+
+    unsigned long vermagic;
+    unsigned char ver[BSP_STR_LEN+1];
+	
+} BOARD_CFG_T, *PBOARD_CFG_T;
+
+
+#define BL_MAGIC			0x6c62676d
+#define MAC_MAGIC			0x636d676d
+#define VER_MAGIC			0x7276676d
+#define ID_MAGIC			0x6469676d
+
+
+
+
+
+#endif /* __ADM5120_H__ */
diff -ruN linux-2.6.10/include/asm-mips/am5120/mx.h linux-2.6.10-adm.1/include/asm-mips/am5120/mx.h
--- linux-2.6.10/include/asm-mips/am5120/mx.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/include/asm-mips/am5120/mx.h	2005-01-27 21:06:27.000000000 +0100
@@ -0,0 +1,69 @@
+/*****************************************************************************
+;
+;   (C) Unpublished Work of ADMtek Technology,  Corp.  All Rights Reserved.
+;
+;       THIS WORK IS AN UNPUBLISHED WORK AND CONTAINS CONFIDENTIAL,
+;       PROPRIETARY AND TRADESECRET INFORMATION OF ADMTEK TECHNOLOGY CORP.
+;       ACCESS TO THIS WORK IS RESTRICTED TO (I) ADMTEK EMPLOYEES WHO HAVE A
+;       NEED TO KNOW TO PERFORM TASKS WITHIN THE SCOPE OF THEIR ASSIGNMENTS
+;       AND (II) ENTITIES OTHER THAN ADMTEK WHO HAVE ENTERED INTO APPROPRIATE
+;       LICENSE AGREEMENTS.  NO PART OF THIS WORK MAY BE USED, PRACTICED,
+;       PERFORMED, COPIED, DISTRIBUTED, REVISED, MODIFIED, TRANSLATED,
+;       ABBRIDGED, CONDENSED, EXPANDED, COLLECTED, COMPILED, LINKED, RECAST,
+;       TRANSFORMED OR ADAPTED WITHOUT THE PRIOR WRITTEN CONSENT OF ADMTEK.
+;       ANY USE OR EXPLOITATION OF THIS WORK WITHOUT AUTHORIZATION COULD
+;       SUBJECT THE PERPERTRATOR TO CRIMINAL AND CIVIL LIABILITY.
+;------------------------------------------------------------------------------
+;
+;    Project : Common plateform
+;    Creator : Simon
+;    File    : nv_drv.h
+;
+;Modification History:
+;   Location    Resonder   Modification Description
+; ------------ ---------- ----------------------------------------------
+;
+;*****************************************************************************/
+#if __cplusplus
+extern "C" {
+#endif
+
+#ifndef _FLASH_H_
+#define _FLASH_H_
+
+enum    FLASH_E
+{
+    FLASH_NOT_FIT_IN = -2,
+    FLASH_ERROR = -1,
+    FLASH_OK = 0,
+    FLASH_PARTIAL_DONE
+};
+
+typedef struct FLASH_DESC_S
+{
+    struct FLASH_DESC_S *next;
+    int flash_size;
+    int addr_inc;
+    int byte_width;
+    char *start;
+    unsigned long *blocks;
+    int num;
+    int (*erase)(struct FLASH_DESC_S *cp, char *flash, int cells);
+    int (*read) (struct FLASH_DESC_S *cp, char *flash, char *dst, int cells);
+    int (*write)(struct FLASH_DESC_S *cp, char *flash, char *src, int cells);
+}
+FLASH_DESC;
+
+
+int flash_init();
+int flash_add(FLASH_DESC *cp);
+int flash_erase(char *flash, int size);
+int flash_read (char *flash, char *dst, int size);
+int flash_write(char *flash, char *src, int size);
+
+
+#endif  /* _FLASH_H_   */
+
+#if __cplusplus
+}
+#endif
diff -ruN linux-2.6.10/include/asm-mips/am5120/mx29lv320b.h linux-2.6.10-adm.1/include/asm-mips/am5120/mx29lv320b.h
--- linux-2.6.10/include/asm-mips/am5120/mx29lv320b.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/include/asm-mips/am5120/mx29lv320b.h	2005-01-27 21:06:27.000000000 +0100
@@ -0,0 +1,61 @@
+/*****************************************************************************
+;
+;   (C) Unpublished Work of ADMtek Incorporated.  All Rights Reserved.
+;
+;       THIS WORK IS AN UNPUBLISHED WORK AND CONTAINS CONFIDENTIAL,
+;       PROPRIETARY AND TRADESECRET INFORMATION OF ADMTEK INCORPORATED.
+;       ACCESS TO THIS WORK IS RESTRICTED TO (I) ADMTEK EMPLOYEES WHO HAVE A
+;       NEED TO KNOW TO PERFORM TASKS WITHIN THE SCOPE OF THEIR ASSIGNMENTS
+;       AND (II) ENTITIES OTHER THAN ADMTEK WHO HAVE ENTERED INTO APPROPRIATE
+;       LICENSE AGREEMENTS.  NO PART OF THIS WORK MAY BE USED, PRACTICED,
+;       PERFORMED, COPIED, DISTRIBUTED, REVISED, MODIFIED, TRANSLATED,
+;       ABBRIDGED, CONDENSED, EXPANDED, COLLECTED, COMPILED, LINKED, RECAST,
+;       TRANSFORMED OR ADAPTED WITHOUT THE PRIOR WRITTEN CONSENT OF ADMTEK.
+;       ANY USE OR EXPLOITATION OF THIS WORK WITHOUT AUTHORIZATION COULD
+;       SUBJECT THE PERPERTRATOR TO CRIMINAL AND CIVIL LIABILITY.
+;
+;------------------------------------------------------------------------------
+;
+;    Project : ADM5120
+;    Creator : 
+;    File    : include/asm/am5120/mx29lv320b.h
+;    Date    : 2003.07.30
+;    Abstract: 
+;
+;Modification History:
+; 
+;
+;*****************************************************************************/
+
+
+#ifndef  __MX29LV320B_H__
+#define  __MX29LV320B_H__
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+
+#define FLASH_PHYS_ADDR 0x1FC00000
+#define FLASH_SIZE 		0x200000  
+
+#define FLASH_PARTITION1_ADDR 0x00000000
+#define FLASH_PARTITION1_SIZE 0x00200000
+
+struct map_info mx29lv320b_map = {
+		.name =		"MX29LV320B flash device",
+		.size =		FLASH_SIZE,
+		.buswidth =	2,
+};
+
+struct mtd_partition mx29lv320b_parts[] = {
+	{
+		.name =		"Flash Disk 1",
+		.offset =	FLASH_PARTITION1_ADDR,
+		.size =		FLASH_PARTITION1_SIZE
+	}
+};
+
+#define PARTITION_COUNT (sizeof(mx29lv320b_parts)/sizeof(struct mtd_partition))
+
+#endif /* __MX29LV320B_H__ */
+
diff -ruN linux-2.6.10/include/asm-mips/am5120/prom.h linux-2.6.10-adm.1/include/asm-mips/am5120/prom.h
--- linux-2.6.10/include/asm-mips/am5120/prom.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-adm.1/include/asm-mips/am5120/prom.h	2005-01-27 21:06:27.000000000 +0100
@@ -0,0 +1,49 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ *
+ * MIPS boards bootprom interface for the Linux kernel.
+ *
+ */
+
+#ifndef _MIPS_PROM_H
+#define _MIPS_PROM_H
+
+extern char *prom_getcmdline(void);
+extern char *prom_getenv(char *name);
+extern void setup_prom_printf(int tty_no);
+extern void prom_printf(char *fmt, ...);
+extern void prom_init_cmdline(void);
+extern void prom_meminit(void);
+extern void prom_fixup_mem_map(unsigned long start_mem, unsigned long end_mem);
+extern void prom_free_prom_memory (void);
+extern void mips_display_message(const char *str);
+extern void mips_display_word(unsigned int num);
+extern int get_ethernet_addr(char *ethernet_addr);
+
+/* Memory descriptor management. */
+#define PROM_MAX_PMEMBLOCKS    32
+struct prom_pmemblock {
+        unsigned long base; /* Within KSEG0. */
+        unsigned int size;  /* In bytes. */
+        unsigned int type;  /* free or prom memory */
+};
+
+#endif /* !(_MIPS_PROM_H) */
diff -ruN linux-2.6.10/include/asm-mips/bootinfo.h linux-2.6.10-adm.1/include/asm-mips/bootinfo.h
--- linux-2.6.10/include/asm-mips/bootinfo.h	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.10-adm.1/include/asm-mips/bootinfo.h	2005-01-27 21:06:26.000000000 +0100
@@ -212,6 +212,12 @@
 #define MACH_GROUP_TITAN       22	/* PMC-Sierra Titan		*/
 #define  MACH_TITAN_YOSEMITE	1	/* PMC-Sierra Yosemite		*/
 
+/*
+ * Valid machtype for group ADMtek
+ */
+#define MACH_GROUP_ADM_GW      23
+#define MACH_ADM_GW_5120	0
+
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 const char *get_system_type(void);
diff -ruN linux-2.6.10/include/linux/init.h linux-2.6.10-adm.1/include/linux/init.h
--- linux-2.6.10/include/linux/init.h	2004-12-24 22:33:50.000000000 +0100
+++ linux-2.6.10-adm.1/include/linux/init.h	2005-01-27 21:06:29.000000000 +0100
@@ -86,6 +86,8 @@
 	static initcall_t __initcall_##fn __attribute_used__ \
 	__attribute__((__section__(".initcall" level ".init"))) = fn
 
+#define early_initcall(fn)		__define_initcall(".early1",fn)
+
 #define core_initcall(fn)		__define_initcall("1",fn)
 #define postcore_initcall(fn)		__define_initcall("2",fn)
 #define arch_initcall(fn)		__define_initcall("3",fn)

--------------050005050601070706030904--
