Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3OACbwJ013726
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 03:12:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3OACbhx013725
	for linux-mips-outgoing; Wed, 24 Apr 2002 03:12:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from msr.hinet.net (msr80.hinet.net [168.95.4.180])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3OACTwJ013719
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 03:12:30 -0700
Received: from sam (61-220-89-134.HINET-IP.hinet.net [61.220.89.134])
	by msr.hinet.net (8.9.3/8.9.3) with SMTP id SAA26648;
	Wed, 24 Apr 2002 18:12:52 +0800 (CST)
From: "Ku" <iskoo@ms45.hinet.net>
To: "Linux-Mips" <linux-mips@oss.sgi.com>
Subject: Confused about Linux MIPS Boot Flow,
Date: Wed, 24 Apr 2002 18:13:01 +0800
Message-ID: <IKEGLMCKDAJOFMHOFMBBKECBCBAA.iskoo@ms45.hinet.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by oss.sgi.com id g3OACUwJ013722
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi everybody,

I got the source code about Linux PhilpNino and traced,

BUT, If I use PMON for bootstrape code
The situation I assume,
0. I prepare two compressed images about kernel image and ramdisk image in flash    
1. With boot loader PMON 2.6 source code
   STEP 1: I modify go() function to decompress kernel image from to 0x80000000
   STEP 2: with PMON monitor code, then execute "go -e 0x80000000"
2. then the flow into the kernel_entry point respect to the source code
   "arch\mips\jernel\head.s"
   the kernel_entry segmentation is continued by init_arch to call prom_init ...
   and start_kernel...

-->IS THIS FLOW CORRECT?

=================================
For example to load RAMDISK on Linux PowerPC,
I ever make the "ramdisk.gz"  from flash to a free memory firstly,
after then, using PPCBOOT to transfer the "initrd_start" and "initrd_end" to kernel
So, the kernel image can work well to loading ramdisk and mount root, and go on...

BUT, For Linux PhilpNino on MIPS CPU,
I just find the ramdisk setting. in "arch/mips/philps/nino/in ld.script"
====
OUTPUT_FORMAT("ecoff-littlemips")
OUTPUT_ARCH(mips)
SECTIONS
{
  .initrd :
  {
        *(.data)
  }
}
====
and the Makefile
====
ramdisk.o: ramdisk.gz ld.script
        $(LD) -T ld.script -b binary -o $@ ramdisk
====
then, obj-$(CONFIG_BLK_DEV_INITRD)      += ramdisk.o

I just do not know, How the "obj-y" can tell the kernel the entry adress to load ramdisk...
Can I memcpy ramdisk,gz from flash to memory and pass the initrd_start and initrd_end to KERNEL (using the method as PowerPC's one)?

Because I do not have the demo board for test, I just can trace the possible flow...
thanks all,

--Ku
 
      
   
