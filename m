Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2006 14:12:31 +0100 (BST)
Received: from farad.aurel32.net ([82.232.2.251]:54661 "EHLO farad.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20039666AbWJXNM1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Oct 2006 14:12:27 +0100
Received: from bode.aurel32.net ([2001:618:400:fc13:211:9ff:feed:c498])
	by farad.aurel32.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GcM4r-0003KP-Vz; Tue, 24 Oct 2006 15:12:22 +0200
Received: from aurel32 by bode.aurel32.net with local (Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1GcM1A-0001EK-HF; Tue, 24 Oct 2006 15:08:32 +0200
Date:	Tue, 24 Oct 2006 15:08:32 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: qemu initrd and ide support
Message-ID: <20061024130832.GA3768@bode.aurel32.net>
References: <20061012211228.GA17383@nevyn.them.org> <452F9744.9010109@aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <452F9744.9010109@aurel32.net>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 13, 2006 at 03:40:20PM +0200, Aurelien Jarno wrote:
> Hi!
> 
> Daniel Jacobowitz a écrit :
> >These patches for qemu let IDE and initrd work in the defconfig.
> >It seems to function - I was able to get as far as partitioning
> >the drive in the debian installer and the next time I started qemu
> >the new partitions were found.  But the installer hangs up trying
> >to format swap.
> >
> >Of course, what would be really nice would be a PCI controller.
> >I'm not brave enough to try.
> >
> >I'm not going to submit the qemu change until I have some better
> >evidence that it all works right (or someone else does).
> >
> 
> First of all, thanks a lot for your work, that makes QEMU mips more usable.
> 
> The IDE part works very well, though there seems to be some problems 
> with userland tools (mke2fs), an instruction is probably not/bad 
> emulated. I now have a system with the root on the IDE drive and with swap.
> 

After a week of test, I can say that the IDE part is working correctly 
(at least for me, and I suppose for you), I am using it on an emulated
system with ext3 as the root partition, and with swap. There are some
problems related to the userland tools (mke2fs) though.

Therefore I propose to submit the IDE part to QEMU. I have extracted it
from your patch, which also contains initrd support.

Care to send it?

Thanks,
Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="mips-qemu-ide.patch"

Index: Makefile.target
===================================================================
RCS file: /sources/qemu/qemu/Makefile.target,v
retrieving revision 1.130
diff -u -d -p -r1.130 Makefile.target
--- Makefile.target	22 Oct 2006 00:18:54 -0000	1.130
+++ Makefile.target	24 Oct 2006 04:58:51 -0000
@@ -357,8 +357,8 @@ VL_OBJS+= grackle_pci.o prep_pci.o unin_
 DEFINES += -DHAS_AUDIO
 endif
 ifeq ($(TARGET_ARCH), mips)
-VL_OBJS+= mips_r4k.o dma.o vga.o serial.o i8254.o i8259.o
-#VL_OBJS+= #ide.o pckbd.o fdc.o m48t59.o
+VL_OBJS+= mips_r4k.o dma.o vga.o serial.o i8254.o i8259.o ide.o
+#VL_OBJS+= #pckbd.o fdc.o m48t59.o
 endif
 ifeq ($(TARGET_BASE_ARCH), sparc)
 ifeq ($(TARGET_ARCH), sparc64)
Index: hw/mips_r4k.c
===================================================================
RCS file: /sources/qemu/qemu/hw/mips_r4k.c,v
retrieving revision 1.20
diff -u -d -p -r1.20 mips_r4k.c
--- hw/mips_r4k.c	18 Sep 2006 01:15:29 -0000	1.20
+++ hw/mips_r4k.c	24 Oct 2006 04:58:51 -0000
@@ -7,6 +7,10 @@
 
 #define VIRT_TO_PHYS_ADDEND (-0x80000000LL)
 
+static const int ide_iobase[2] = { 0x1f0, 0x170 };
+static const int ide_iobase2[2] = { 0x3f6, 0x376 };
+static const int ide_irq[2] = { 14, 15 };
+
 extern FILE *logfile;
 
 static PITState *pit;
@@ -118,6 +122,7 @@ void mips_r4k_init (int ram_size, int vg
     int ret;
     CPUState *env;
     long kernel_size;
+    int i;
 
     env = cpu_init();
     register_savevm("cpu", 0, 3, cpu_save, cpu_load, env);
@@ -198,6 +203,10 @@ void mips_r4k_init (int ram_size, int vg
             exit (1);
         }
     }
+
+    for(i = 0; i < 2; i++)
+        isa_ide_init(ide_iobase[i], ide_iobase2[i], ide_irq[i],
+                     bs_table[2 * i], bs_table[2 * i + 1]);
 }
 
 QEMUMachine mips_machine = {

--4Ckj6UjgE2iN1+kY--
