Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2THd5O06564
	for linux-mips-outgoing; Thu, 29 Mar 2001 09:39:05 -0800
Received: from hermes.research.kpn.com (hermes.research.kpn.com [139.63.192.8])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2THd4M06561
	for <linux-mips@oss.sgi.com>; Thu, 29 Mar 2001 09:39:04 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01K1S43AL8TK000OD0@research.kpn.com> for
 linux-mips@oss.sgi.com; Thu, 29 Mar 2001 19:39:02 +0200
Received: (from karel@localhost)	by sparta.research.kpn.com (8.8.8+Sun/8.8.8)
 id TAA01695; Thu, 29 Mar 2001 19:39:02 +0200 (MET DST)
X-URL: http://www-lsdm.research.kpn.com/~karel
Date: Thu, 29 Mar 2001 19:39:01 +0200 (MET DST)
From: Karel van Houten <K.H.C.vanHouten@research.kpn.com>
Subject: Re: Recommended toolchain
In-reply-to: <200103291728.TAA01350@sparta.research.kpn.com>
To: linux-mips@oss.sgi.com
Cc: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Reply-to: vhouten@kpn.com
Message-id: <200103291739.TAA01695@sparta.research.kpn.com>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL2]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I wrote:
> This happens when I compile kernel 2.4.0-test9 with
> binutils 2.10.1, gcc 2.95.3, glibc 2.2.2 on my 5000/260 (R4k)
> (the same source/config compiles fine with 2.8.1/egcs-2.90.27/glibc-2.0.6):
> ....

Oh, and the resulting (ELF) kernel doesn't boot at all:
>>boot 3/rz0 1/new
delo V0.7 Copyright 2000 Florian Lohoff <flo@rfc822.org>
Loading /etc/delo.conf .. ok
Loading /boot/vmlinux.new ....... ok

KN05 V2.1k    (PC: 0xa002cab8, SP: 0x8043fef0)
>>                            

-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
