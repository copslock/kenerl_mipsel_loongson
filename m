Received:  by oss.sgi.com id <S305165AbQAZTcM>;
	Wed, 26 Jan 2000 11:32:12 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:22553 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305158AbQAZTcA>; Wed, 26 Jan 2000 11:32:00 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA02673; Wed, 26 Jan 2000 11:35:13 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA94774
	for linux-list;
	Wed, 26 Jan 2000 11:15:31 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA37696
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 26 Jan 2000 11:15:17 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA09552
	for <linux@cthulhu.engr.sgi.com>; Wed, 26 Jan 2000 11:15:15 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port111.duesseldorf.ivm.net [195.247.65.111])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id UAA09305;
	Wed, 26 Jan 2000 20:14:56 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000126201529.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <388E2920.10597068@ti.com>
Date:   Wed, 26 Jan 2000 20:15:29 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Victor Wells <vwells@ti.com>
Subject: RE: Embedded system with RAM Disk
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On 25-Jan-00 Victor Wells wrote:

> I am developing an embedded system that will boot from flash.
> I would like to load a RAM based file system to physical memory
> and then have the kernel mount the RAM disk as the Root
> file system.
[...]
> 
> Our boot process is to:
> 1.) Load the kernel
> 2.) Load the RAM disk/Root file system
> 3.) Mount the RAM disk as the Root file system within the kernel
> 
> How can I hard code the kernel to know where the RAM disk will
> exist in physical memory?

Once upon a time I had a hack which did something similar, linking a ramdisk
image into the kernel image which resulted in a single file for kernel+ramdisk.

This is not only a nice feature for installation kernels but a must for boxes
which are only capable to boot a single file, for example via TFTP.

The current mechanism, i.e. "addinitrd", works for some boxen which boot ECOFF
kernel images, but even not for all of them. Creating an kernel+ramdisk ELF
image and converting that into ECOFF, on the other hand, even works for
DECstations. Depending on how you fiddle with the linker scripts the ramdisk
image can easily reside in ROM or flash or whatever.

Well, somehow this hack didn't make it into the mainstream kernel but came to a
new life within the LinuxCE project and I am beginning to wonder if we should
make this the default.

Opinions?

---
Regards,
Harald
