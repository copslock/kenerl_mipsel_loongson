Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7MA0Tc25380
	for linux-mips-outgoing; Wed, 22 Aug 2001 03:00:29 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7MA0P925377
	for <linux-mips@oss.sgi.com>; Wed, 22 Aug 2001 03:00:25 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA21080;
	Wed, 22 Aug 2001 03:00:17 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA23197;
	Wed, 22 Aug 2001 03:00:14 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f7M9wra04582;
	Wed, 22 Aug 2001 11:58:55 +0200 (MEST)
Message-ID: <3B83825D.47619A46@mips.com>
Date: Wed, 22 Aug 2001 11:58:53 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: swang@mmc.atmel.com
CC: linux-mips@oss.sgi.com
Subject: Re: Question on porting Linux...
References: <000701c12529$e1640580$8021690a@huawei.com> <20010815103314.A11966@bacchus.dhis.org> <000b01c1295e$0f2174c0$8021690a@huawei.com> <20010820230755.A11242@dea.linux-mips.net> <001501c129dd$8acebb80$8021690a@huawei.com> <20010821083508.A13302@dea.linux-mips.net> <001201c12a29$57f3b660$8021690a@huawei.com> <20010821131721.F13302@dea.linux-mips.net> <3B827B7C.16A1C763@mmc.atmel.com> <3B82C410.5E82AD6D@mips.com> <3B82D443.4C9DBDBE@mmc.atmel.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

You can find a kernel images for the SEAD board here:
ftp://ftp.mips.com/pub/linux/mips/kernel/2.4/images/vmlinux-2.4.3.sead.el-01.01.srec.gz
The sources are here:
ftp://ftp.mips.com/pub/linux/mips/kernel/2.4/src/linux-2.4.3.mips-src-01.01.tar.gz

To build your own ramdisk see Documentation/initrd.txt (in the sources) for how-to do it.
Put your ramdisk images in arch/mips/ramdisk/ramdisk.gz and compile the kernel (you can
use the .config.sead file for configure your kernel for the SEAD board, just copy it to
.config and then do 'make config').
Note that you need a other MIPS linux system to build your ramdisk.

Hope this is useful.
/Carsten


Shuanglin Wang wrote:

> > You are probably referring to the MIPS SEAD board, I have made a port for that board
> > now.
> > It runs with a small ramdisk, which basically only consist of a stand-alone shell
> > and a few simple commands like ls, etc...
> > So you can't do much with it, but you can make you own ramdisk, and just merge it in
> > with the kernel.
> > I will try to put an image on our FTP site
> > (ftp://ftp.mips.com/pub/linux/mips/kernel/2.4/images/) tomorrow.
> >
> > /Carsten
> >
>
> Yes, it is a MIPS SEAD-2 board. By the way, can I get the source code of the kernel
> with SEAD-2 board support ?
>
> >

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
