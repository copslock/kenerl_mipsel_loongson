Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2003 13:15:19 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:45597
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225211AbTDYMPS>; Fri, 25 Apr 2003 13:15:18 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 25 Apr 2003 12:15:15 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h3PCF4Nr029069;
	Fri, 25 Apr 2003 21:15:06 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 25 Apr 2003 21:21:23 +0900 (JST)
Message-Id: <20030425.212123.92588585.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: ioctl32 enhancement
Cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I added some entries in arch/mips64/ioctl32.c.

The handler for TIOCGSERIAL is required by BusyBox.  Some serial
drivers using generic serial_struct need it (sgiserial does not).  I
think this patch does not harm sgiserial.

The loop ioctls (LOOP_GET_STATUS, LOOP_SET_STATUS) are required for
some tools. (including Debian installer)

The mtd ioctls are useful on embedded systems.

Here is a patch for 2.4 tree.


diff -u linux-mips/arch/mips64/kernel/ioctl32.c linux/arch/mips64/kernel/ioctl32.c 
--- linux-mips/arch/mips64/kernel/ioctl32.c	Fri Feb 14 09:41:26 2003
+++ linux/arch/mips64/kernel/ioctl32.c	Thu Apr 24 17:26:56 2003
@@ -36,6 +36,7 @@
 #include <linux/auto_fs4.h>
 #include <linux/ext2_fs.h>
 #include <linux/raid/md_u.h>
+#include <linux/serial.h>
 
 #include <scsi/scsi.h>
 #undef __KERNEL__		/* This file was born to be ugly ...  */
@@ -47,6 +48,9 @@
 #include <asm/uaccess.h>
 
 #include <linux/rtc.h>
+#ifdef CONFIG_MTD_CHAR
+#include <linux/mtd/mtd.h>
+#endif
 
 #ifdef CONFIG_SIBYTE_TBPROF
 #include <asm/sibyte/trace_prof.h>
@@ -740,6 +744,127 @@
 	return rw_long(fd, AUTOFS_IOC_SETTIMEOUT, arg);
 }
 
+/* serial_struct_ioctl was taken from x86_64/ia32/ia32_ioctl.c and
+ * slightly modified for mips */
+/* iomem_base is unsigned char * in linux/serial.h (reserved in sgiserial.h) */
+struct serial_struct32 {
+	int	type;
+	int	line;
+	unsigned int	port;
+	int	irq;
+	int	flags;
+	int	xmit_fifo_size;
+	int	custom_divisor;
+	int	baud_base;
+	unsigned short	close_delay;
+	char	io_type;
+	char	reserved_char[1];
+	int	hub6;
+	unsigned short	closing_wait; /* time to wait before closing */
+	unsigned short	closing_wait2; /* no longer used... */
+	__u32 iomem_base;
+	unsigned short	iomem_reg_shift;
+	unsigned int	port_high;
+	int	reserved[1];
+};
+
+static int serial_struct_ioctl(unsigned fd, unsigned cmd,  void *ptr) 
+{
+	typedef struct serial_struct SS;
+	struct serial_struct32 *ss32 = ptr; 
+	int err = 0;
+	struct serial_struct ss; 
+	mm_segment_t oldseg = get_fs(); 
+	set_fs(KERNEL_DS);
+	if (cmd == TIOCSSERIAL) { 
+		err = -EFAULT;
+		if (copy_from_user(&ss, ss32, sizeof(struct serial_struct32)))
+			goto out;
+		memmove(&ss.iomem_reg_shift, ((char*)&ss.iomem_base)+4, 
+			sizeof(SS)-offsetof(SS,iomem_reg_shift)); 
+		ss.iomem_base = (void *)(long)ss.iomem_base; /* sign extend */
+	}
+	if (!err)
+		err = sys_ioctl(fd,cmd,(unsigned long)(&ss)); 
+	if (cmd == TIOCGSERIAL && err >= 0) { 
+		__u32 base;
+		if (__copy_to_user(ss32,&ss,offsetof(SS,iomem_base)) ||
+		    __copy_to_user(&ss32->iomem_reg_shift,
+				   &ss.iomem_reg_shift,
+				   sizeof(SS) - offsetof(SS, iomem_reg_shift)))
+			err = -EFAULT;
+		base = (unsigned long)ss.iomem_base;
+		err |= __put_user(base, &ss32->iomem_base); 		
+	} 
+ out:
+	set_fs(oldseg);
+	return err;	
+}
+
+/* loop_status was taken from sparc64/kernel/ioctl32.c */
+struct loop_info32 {
+	int			lo_number;      /* ioctl r/o */
+	__kernel_dev_t32	lo_device;      /* ioctl r/o */
+	unsigned int		lo_inode;       /* ioctl r/o */
+	__kernel_dev_t32	lo_rdevice;     /* ioctl r/o */
+	int			lo_offset;
+	int			lo_encrypt_type;
+	int			lo_encrypt_key_size;    /* ioctl w/o */
+	int			lo_flags;       /* ioctl r/o */
+	char			lo_name[LO_NAME_SIZE];
+	unsigned char		lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned int		lo_init[2];
+	char			reserved[4];
+};
+
+static int loop_status(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs = get_fs();
+	struct loop_info l;
+	int err = -EINVAL;
+
+	switch(cmd) {
+	case LOOP_SET_STATUS:
+		err = get_user(l.lo_number, &((struct loop_info32 *)arg)->lo_number);
+		err |= __get_user(l.lo_device, &((struct loop_info32 *)arg)->lo_device);
+		err |= __get_user(l.lo_inode, &((struct loop_info32 *)arg)->lo_inode);
+		err |= __get_user(l.lo_rdevice, &((struct loop_info32 *)arg)->lo_rdevice);
+		err |= __copy_from_user((char *)&l.lo_offset, (char *)&((struct loop_info32 *)arg)->lo_offset,
+					   8 + (unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
+		if (err) {
+			err = -EFAULT;
+		} else {
+			set_fs (KERNEL_DS);
+			err = sys_ioctl (fd, cmd, (unsigned long)&l);
+			set_fs (old_fs);
+		}
+		break;
+	case LOOP_GET_STATUS:
+		set_fs (KERNEL_DS);
+		err = sys_ioctl (fd, cmd, (unsigned long)&l);
+		set_fs (old_fs);
+		if (!err) {
+			err = put_user(l.lo_number, &((struct loop_info32 *)arg)->lo_number);
+			err |= __put_user(l.lo_device, &((struct loop_info32 *)arg)->lo_device);
+			err |= __put_user(l.lo_inode, &((struct loop_info32 *)arg)->lo_inode);
+			err |= __put_user(l.lo_rdevice, &((struct loop_info32 *)arg)->lo_rdevice);
+			err |= __copy_to_user((char *)&((struct loop_info32 *)arg)->lo_offset,
+					   (char *)&l.lo_offset, (unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
+			if (err)
+				err = -EFAULT;
+		}
+		break;
+	default: {
+		static int count;
+		if (++count <= 20)
+			printk("%s: Unknown loop ioctl cmd, fd(%d) "
+			       "cmd(%08x) arg(%08lx)\n",
+			       __FUNCTION__, fd, cmd, arg);
+	}
+	}
+	return err;
+}
+
 struct ioctl32_handler {
 	unsigned int cmd;
 	int (*function)(unsigned int, unsigned int, unsigned long);
@@ -789,8 +914,8 @@
 	IOCTL32_DEFAULT(TIOCSCTTY),
 	IOCTL32_DEFAULT(TIOCGPTN),
 	IOCTL32_DEFAULT(TIOCSPTLCK),
-	IOCTL32_DEFAULT(TIOCGSERIAL),
-	IOCTL32_DEFAULT(TIOCSSERIAL),
+	IOCTL32_HANDLER(TIOCGSERIAL, serial_struct_ioctl),
+	IOCTL32_HANDLER(TIOCSSERIAL, serial_struct_ioctl),
 	IOCTL32_DEFAULT(TIOCSERGETLSR),
 
 	IOCTL32_DEFAULT(FIOCLEX),
@@ -973,6 +1098,8 @@
 	/* Big L */
 	IOCTL32_DEFAULT(LOOP_SET_FD),
 	IOCTL32_DEFAULT(LOOP_CLR_FD),
+	IOCTL32_HANDLER(LOOP_SET_STATUS, loop_status),
+	IOCTL32_HANDLER(LOOP_GET_STATUS, loop_status),
 
 	/* And these ioctls need translation */
 	IOCTL32_HANDLER(SIOCGIFNAME, dev_ifname32),
@@ -1137,7 +1264,18 @@
 	IOCTL32_DEFAULT(RTC_RD_TIME),
 	IOCTL32_DEFAULT(RTC_SET_TIME),
 	IOCTL32_DEFAULT(RTC_WKALM_SET),
-	IOCTL32_DEFAULT(RTC_WKALM_RD)
+	IOCTL32_DEFAULT(RTC_WKALM_RD),
+#ifdef CONFIG_MTD_CHAR
+	/* Big M */
+	IOCTL32_DEFAULT(MEMGETINFO),
+	IOCTL32_DEFAULT(MEMERASE),
+	// IOCTL32_DEFAULT(MEMWRITEOOB32, mtd_rw_oob),
+	// IOCTL32_DEFAULT(MEMREADOOB32, mtd_rw_oob),
+	IOCTL32_DEFAULT(MEMLOCK),
+	IOCTL32_DEFAULT(MEMUNLOCK),
+	IOCTL32_DEFAULT(MEMGETREGIONCOUNT),
+	IOCTL32_DEFAULT(MEMGETREGIONINFO),
+#endif
 };
 
 #define NR_IOCTL32_HANDLERS	(sizeof(ioctl32_handler_table) /	\
---
Atsushi Nemoto
