Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Dec 2004 01:24:09 +0000 (GMT)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:21535 "EHLO
	[205.229.50.10]") by linux-mips.org with ESMTP id <S8225285AbUL2BYF>;
	Wed, 29 Dec 2004 01:24:05 +0000
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with ESMTP; Tue, 28 Dec 2004 17:24:05 -0800
Received: by miles.echelon.com with Internet Mail Service (5.5.2653.19)
	id <ZK16S71Y>; Tue, 28 Dec 2004 17:23:54 -0800
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB59016543E2@miles.echelon.com>
From: Prashant Viswanathan <vprashant@echelon.com>
To: 'Josh Green' <jgreen@users.sourceforge.net>,
	Prashant Viswanathan <vprashant@echelon.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: dbAu1550 (Cabarnet) - problems booting kernel - hangs at "Sen
	ding BOOTP" and root file system for MIPS (BE)
Date: Tue, 28 Dec 2004 17:23:54 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips

> > However, the kernel seems to hang in "Sending BOOTP Requests"
> > <snip>
> > Sending BOOTP requests .<6>eth0: link up
> > eth1: link up
> > ..... timed out!
> > IP-Config: Reopening network devices...
> > Sending BOOTP requests ....
> > </snip>
> >
> 
> Perhaps you don't have a bootp service on your network.  I usually put
> ip=dhcp (go to Device Drivers->Networking support->Networking options
> and enable IP: DHCP support).

With DHCP support enabled it works.

> You could build your own tool chain and root file system, which is what
> I did (I have a dbAu1100 board).  I used the buildroot package which is
> part of the uclibc project:
> http://www.uclibc.org/
> 
> You can download the buildroot CVS tarball here (just look for the
> "Download tarball" link at the bottom:
> http://www.uclibc.org/cgi-bin/cvsweb/buildroot/
> 
> It has a "make menuconfig" style configuration system and will build
> busybox and other programs and create an ext2 file system, etc.  I opted
> to build busybox and the mips kernel separately though (so I could more
> easily configure them).  I now have a cross compiler and tool chain for
> my x86 laptop.

I used the toolchain from mips.com to build the kernel. I guess I will have
to do what you suggest to get a root file system. I was under the impression
that several pre-built root file systems existed for MIPS.

Thanks a lot!
Prashant
