Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 07:47:48 +0100 (BST)
Received: from mx.globalone.ru ([194.84.254.251]:24338 "EHLO mx.globalone.ru")
	by ftp.linux-mips.org with ESMTP id S8133517AbWC2Grg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Mar 2006 07:47:36 +0100
Received: from mx.globalone.ru (localhost [127.0.0.1])
	by mx.globalone.ru (8.12.10/8.12.8) with ESMTP id k2T6vxIl022410
	for <linux-mips@linux-mips.org>; Wed, 29 Mar 2006 10:57:59 +0400
Received: from smtp.globalone.ru (smtp.globalone.ru [172.16.38.5])
	by mx.globalone.ru (8.12.10/8.12.8) with ESMTP id k2T6vpuZ022397
	for <linux-mips@linux-mips.org>; Wed, 29 Mar 2006 10:57:51 +0400
Received: from voropaya ([172.16.38.7]) by smtp.globalone.ru
          (Netscape Messaging Server 4.15) with SMTP id IWVNCE00.QE7; Wed,
          29 Mar 2006 10:57:50 +0400 
Message-ID: <0f1501c652fe$650d2950$e90d11ac@spb.in.rosprint.ru>
Reply-To: "Alexander Voropay" <a.voropay@equant.ru>
From:	"Alexander Voropay" <a.voropay@equant.ru>
To:	"Chris Boot" <bootc@bootc.net>, <linux-mips@linux-mips.org>
References: <44299EE6.7010309@bootc.net>
Subject: Re: Emulating MIPS -- please help!
Date:	Wed, 29 Mar 2006 10:59:13 +0400
Organization: &Equant
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Return-Path: <a.voropay@equant.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.voropay@equant.ru
Precedence: bulk
X-list: linux-mips

From: "Chris Boot" <bootc@bootc.net>

> Can anyone post some instructions and, perhaps, a .config for 2.6.16 so 
> I can get some output like kernel boot messages and a login screen?

 I've spent some time playing with GXEmul and Linux kernel.
The Linux 2.4.x under GXEemul 0.3.8 works fine.
The UART, timer, VGA/pckbd and IDE are working.
You could find a precompiled 2.4 kernel with built-in ramdisk there:
http://www.nwpi.ru/~alec/mips/
One kernel is compiled with GCC2.9.6 while another with
GCC 3.3.5. They shows different CPU frequency under
emulator due to the tricky "loop optimization" in the GXEmul/mips.

 You could use DISK-debian image with pivot_root also to
get a mips/debian with glibc and GCC. Use a -di: option
to attach an IDE disk image.

 To run this kernels, use Malta mode:
$ ./gxemul -E evbmips -e malta vmlinux_2_4_32-malta-ide-pci-ramdisk.elf.gz

 Wait a minute to fill GXEmul translation cache. PCI stuff in the
GXEmul does not work (try lspci).

 Unfortunately, I still can't get Linux 2.6.x working under GXEmul.
The interrupt routines in the 2.6 was massively changed
and this produces IRQ16 spurious interrupt infinity loop.
It's reasonable difficult to find such sort of bugs.

--
-=AV=-
