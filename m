Received:  by oss.sgi.com id <S553850AbQLPKUY>;
	Sat, 16 Dec 2000 02:20:24 -0800
Received: from hermes.research.kpn.com ([139.63.192.8]:44299 "EHLO
        hermes.research.kpn.com") by oss.sgi.com with ESMTP
	id <S553866AbQLPKUE>; Sat, 16 Dec 2000 02:20:04 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01JXRQN1CS1U00180S@research.kpn.com> for
 linux-mips@oss.sgi.com; Sat, 16 Dec 2000 11:20:02 +0100
Received: (from karel@localhost)	by sparta.research.kpn.com (8.8.8+Sun/8.8.8)
 id LAA28799; Sat, 16 Dec 2000 11:20:01 +0100 (MET)
X-URL:  http://www-lsdm.research.kpn.com/~karel
Date:   Sat, 16 Dec 2000 11:20:00 +0100 (MET)
From:   Karel van Houten <K.H.C.vanHouten@research.kpn.com>
Subject: Re: Kernel Oops when booting on DECstation
In-reply-to: <20001216085603.A514@sumpf.cyrius.com>
To:     tbm@cyrius.com (Martin Michlmayr)
Cc:     linux-mips@oss.sgi.com
Message-id: <200012161020.LAA28799@sparta.research.kpn.com>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL2]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Martin wrote:
> When I boot a Linux kernel on a DECstation/125, I get the following oops:
> 
> >>boot 3/rz2/vmlinux root=/dev/sda1 console=ttyS2 root=/dev/sda1
> >> NetBSD/pmax Secondary Boot, Revision 1.0
> >> (root@vlad, Sat Mar  4 14:34:30 EST 2000)
> ...
> POSIX conformance testing by UNIFIX
> Unable to handle kernel paging request at virtual address 00000004, epc == 80054
> ...
> 
> Any ideas?  (I hope and think that it has nothing to do with me
> booting from a NetBSD partition.  I don't have ethernet on the machine
> and thus have to boot the kernel from the existing FFS partition in
> order to start Linux and then run delo.  NetBSD boots and works, btw.)

The next entry the kernel would print is the Turbochannel scan.
Do you have any unsupported cards in your system that could cause this?

Have you tried my kernels, by the way?

-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
