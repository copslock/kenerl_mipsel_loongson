Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Mar 2004 15:26:42 +0000 (GMT)
Received: from webmail-outgoing.us4.outblaze.com ([IPv6:::ffff:205.158.62.67]:1754
	"EHLO webmail-outgoing.us4.outblaze.com") by linux-mips.org
	with ESMTP id <S8225219AbUCOP0h>; Mon, 15 Mar 2004 15:26:37 +0000
Received: from wfilter.us4.outblaze.com (wfilter.us4.outblaze.com [205.158.62.180])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id 7E2311801B3A
	for <linux-mips@linux-mips.org>; Mon, 15 Mar 2004 15:26:27 +0000 (GMT)
X-OB-Received: from unknown (205.158.62.131)
  by wfilter.us4.outblaze.com; 15 Mar 2004 15:26:01 -0000
Received: by ws5-1.us4.outblaze.com (Postfix, from userid 1001)
	id 5FB6E3982E7; Mon, 15 Mar 2004 15:26:27 +0000 (GMT)
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Received: from [203.197.141.34] by ws5-1.us4.outblaze.com with http for
    xavier_prabhu@linuxmail.org; Mon, 15 Mar 2004 23:26:27 +0800
From: "xavier prabhu" <xavier_prabhu@linuxmail.org>
To: "Dan Malek" <dan@embeddededge.com>
Cc: linux-mips@linux-mips.org
Date: Mon, 15 Mar 2004 23:26:27 +0800
Subject: Re: Linux Boot Issue in Au1550
X-Originating-Ip: 203.197.141.34
X-Originating-Server: ws5-1.us4.outblaze.com
Message-Id: <20040315152627.5FB6E3982E7@ws5-1.us4.outblaze.com>
Return-Path: <xavier_prabhu@linuxmail.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xavier_prabhu@linuxmail.org
Precedence: bulk
X-list: linux-mips

Hi Dan,

Thanks for your suggestion. But still I'm using the old source code with the patch to pb1550 while I'm trying your suggestion.

The kernel code which I was using to generate the image for Au1500 is working well.
After applying the patch for pb1550 the image develops the problem.

Now, when I mrproper and build again, I get the following link failure(which I didn't get while build for Au1500)

make CFLAGS="-D__KERNEL__ -I/home/amd/project/amd/test/newtry/linux.old/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -f
omit-frame-pointer -I /home/amd/project/amd/test/newtry/linux.old/include/asm/gc
c -G 0 -mno-abicalls -fno-pic -pipe  -mcpu=r4600 -mips2 -Wa,--trap " -C  arch/mi
ps/lib
make[1]: Entering directory `/home/amd/project/amd/test/newtry/linux.old/arch/mi
ps/lib'
make all_targets
make[2]: Entering directory `/home/amd/project/amd/test/newtry/linux.old/arch/mi
ps/lib'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/home/amd/project/amd/test/newtry/linux.old/arch/mip
s/lib'
make[1]: Leaving directory `/home/amd/project/amd/test/newtry/linux.old/arch/mip
s/lib'
mips_fp_le-ld -G 0 -static  -T arch/mips/ld.script arch/mips/kernel/head.o arch/
mips/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o fs/f
s.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o arch/mips/pci/pci-core.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/n
et/net.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddriver
s.o drivers/pci/driver.o drivers/mtd/mtdlink.o drivers/video/video.o drivers/med
ia/media.o \
        net/network.o \
        arch/mips/lib/lib.a /home/amd/project/amd/test/newtry/linux.old/lib/lib.
a arch/mips/au1000/pb1550/pb1550.o arch/mips/au1000/common/au1000.o \
        --end-group \
        -o vmlinux
mips_fp_le-ld: init/main.o: uses different e_flags (0x0) fields than previous mo
dules (0x100)
Bad value: failed to merge target specific data of file init/main.o
mips_fp_le-ld: init/do_mounts.o: uses different e_flags (0x0) fields than previo
us modules (0x100)
Bad value: failed to merge target specific data of file init/do_mounts.o
make: *** [vmlinux] Error 1


I doubt this could be the reason why the image not runs on this processor.
Please tell me if it could lead to TLB exception.

I'm also building with the linux-mips.org source code. 

Thanks and Regards,
Xavier.


----- Original Message -----
From: Dan Malek <dan@embeddededge.com>
Date: 	Fri, 12 Mar 2004 10:17:35 -0500
To: xavier prabhu <xavier_prabhu@linuxmail.org>
Subject: Re: Linux Boot Issue in Au1550

> xavier prabhu wrote:
> 
> > I'm sorry that the kernel is 2.4.22(linux-14oct2003.tar).
> 
> You will have to get the sources from linux-mips.org cvs,
> using the linux_2_4 tag.  From ftp.linux-mips.org:/pub/linux/mips/people/ppopov/2.4
> get and apply the usb-nonpci-2.4.24.patch and zboot-2.4.25.patch
> 
> Use the pb1550 configuration file already in the sources.
> You can 'make zImage', then use objcopy to create an srec file you
> can tftp load into memory, or make zImage.srec that will create the
> file you can place into flash.
> 
> 
> 	-- Dan
> 
> 

-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
