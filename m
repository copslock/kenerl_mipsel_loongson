Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 13:40:03 +0000 (GMT)
Received: from mail.soc-soft.com ([202.56.254.199]:38926 "EHLO
	igateway.soc-soft.com") by ftp.linux-mips.org with ESMTP
	id S8133417AbWCQNjx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Mar 2006 13:39:53 +0000
Received: from keys.soc-soft.com ([192.168.4.44]) by igateway.soc-soft.com with InterScan VirusWall; Fri, 17 Mar 2006 19:19:09 +0530
Received: from soc-mail.soc-soft.com ([192.168.4.25])
  by keys.soc-soft.com (PGP Universal service);
  Fri, 17 Mar 2006 19:17:01 +0530
X-PGP-Universal: processed;
	by keys.soc-soft.com on Fri, 17 Mar 2006 19:17:01 +0530
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: RE: Init not working in 64-bit kernel
Date:	Fri, 17 Mar 2006 19:19:08 +0530
Message-ID: <4BF47D56A0DD2346A1B8D622C5C5902C01524E41@soc-mail.soc-soft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Init not working in 64-bit kernel
Thread-Index: AcZJxVga7OOWTNLfTxiYaSxMZjf+BQAAbCaA
From:	<Vadivelan@soc-soft.com>
To:	<ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <Vadivelan@soc-soft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vadivelan@soc-soft.com
Precedence: bulk
X-list: linux-mips


Hi,
	first thanx for ur reply.

All the following options are enabled in the kernel.

CONFIG_MIPS32_COMPAT=y
CONFIG_MIPS32_O32=y
CONFIG_MIPS32_N32=y

I've another doubt. Is it enough to set only the bits KX,SX and UX of
the status register to work in 64-bit mode?
Though I've used the cross compiler mips64_fp_be-gcc from MontaVista,
the generated vmlinux image seems to boot fine even without setting the
above bits.
I don't know if I'm operating in 32-bit or 64-bit mode.
But I've enabled 64-bit support in kernel configuration.

Regards,
vadi

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Friday, March 17, 2006 6:49 PM
To: Vadivelan M
Cc: linux-mips@linux-mips.org
Subject: Re: Init not working in 64-bit kernel


On Fri, Mar 17, 2006 at 03:36:50PM +0530, Vadivelan@soc-soft.com wrote:

> 	I'm porting a 64-bit linux kernel provided for a mips4
architecture
> to a mips3 target board. The existing NFS root file system has been
> compiled for a 64-bit mips4 architecture. If I mount this file system,

> the init does not run. After mounting the filesystem, I get the
> following messages and the kernel hangs.
>
> -------------------------------------------------
> Looking up port of RPC 100003/2 on 192.168.5.93
> Looking up port of RPC 100005/1 on 192.168.5.93
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 132k freed

That's a rather generic kind of death uppon entry of userspace sympthom,
so I cannot really give alot of advice other than below:

> I also tried to mount a 32-bit working NFS root filesystem. Still I
> get the same problem. I thought 32-bit binaries will execute fine in
> 64-bit kernel.

They do - but you need to enable 32-bit compatibility:

CONFIG_MIPS32_COMPAT=y
CONFIG_MIPS32_O32=y

And if you have an N32 root filesystem (unlikely) you also have to set
CONFIG_MIPS32_N32=y.

> Do I have to recompile the binutils and glibc for my target file
> system?

No.  The entire software should just work.

> Kindly ignore the confidentiality notice attached at the end of the
> mail. It is an automatically generated one and I cannot remove it.I'm
> extremely sorry for the inconvenience.

We're fabulous at ignoring things ;-)

  Ralf






The information contained in this e-mail message and in any annexure is
confidential to the  recipient and may contain privileged information. If you are not
the intended recipient, please notify the sender and delete the message along with
any annexure. You should not disclose, copy or otherwise use the information contained
in the message or any annexure. Any views expressed in this e-mail are those of the
individual sender except where the sender specifically states them to be the views of
SoCrates Software India Pvt Ltd., Bangalore.
