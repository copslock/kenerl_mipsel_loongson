Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Oct 2002 19:28:49 +0100 (CET)
Received: from atlrel8.hp.com ([156.153.255.206]:46231 "HELO atlrel8.hp.com")
	by linux-mips.org with SMTP id <S1122121AbSJaS2s>;
	Thu, 31 Oct 2002 19:28:48 +0100
Received: from xatlrelay1.atl.hp.com (xatlrelay1.atl.hp.com [15.45.89.190])
	by atlrel8.hp.com (Postfix) with ESMTP
	id 7293CA00B03; Thu, 31 Oct 2002 13:28:34 -0500 (EST)
Received: from xatlbh2.atl.hp.com (xatlbh2.atl.hp.com [15.45.89.187])
	by xatlrelay1.atl.hp.com (Postfix) with ESMTP
	id 2978D14D; Thu, 31 Oct 2002 13:28:19 -0500 (EST)
Received: by xatlbh2.atl.hp.com with Internet Mail Service (5.5.2655.55)
	id <VV368G90>; Thu, 31 Oct 2002 13:28:08 -0500
Message-ID: <CBD6266EA291D5118144009027AA63350A68F183@xboi05.boi.hp.com>
From: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
To: 'Ralf Baechle' <ralf@linux-mips.org>,
	"TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: NFS Root broken in 2.4.18?  Anyone successfully booted?
Date: Thu, 31 Oct 2002 13:28:05 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <roger_twede@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roger_twede@hp.com
Precedence: bulk
X-list: linux-mips

Ralf et al,

I found that the 2.4.18 system boots fine when booting from standard devices
(IDE disks etc.).

Init fails to execute successfully when booting from NFS.  The NFS booting
success appears to have died with 2.4.18.

The NFS boot completes fine in 2.4.17 but in 2.4.18 the NFS root is mounted
and /sbin/init and the ld.so.1 are at least accessed, but the system never
executes far enough in user space to even print a message to the console.

I've tried two different network card types just to be sure it wasn't a
single driver issue.

Has anyone noticed this or does anyone know what changes may have caused
this in 2.4.18? 
I'm curious whether anyone has successfully booted 2.4.18 over NFS.

Thanks,

Roger Twede
Hewlett Packard

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Wednesday, October 30, 2002 8:06 AM
To: TWEDE,ROGER (HP-Boise,ex1)
Cc: 'linux-mips@linux-mips.org'
Subject: Re: Recent Kernel Page Fault Problems Spawning Init?


On Tue, Oct 29, 2002 at 05:53:15PM -0500, TWEDE,ROGER (HP-Boise,ex1) wrote:

> I would be appreciative of any advice anyone can offer in this regard.
> 
> Were any fundamental kernel changes made in the 2.4.17 through 2.4.19
> timeframe which could explain why the spawning of init would hang?
> 
> After mounting a root filesystem and attempting to spawn init, 3 or 4 page
> faults occur.  The entry point of init, its bss section and an elf loader
> .text section get hit, etc.  followed by an endless series of page faults
to
> a bad address which just faults repeatedly, never allowing init or the elf
> loader to proceed.
> 
> I've tried a RM 7000A and 20KC based boards so far with apparently
identical
> behavior on both.

Various people have reported this kind of problem in past but so far all of
them turned out some local problem.  20kc and RM7000 are both supposed to be
working fine.

  Ralf
