Received:  by oss.sgi.com id <S553785AbQLSRJg>;
	Tue, 19 Dec 2000 09:09:36 -0800
Received: from hermes.research.kpn.com ([139.63.192.8]:6404 "EHLO
        hermes.research.kpn.com") by oss.sgi.com with ESMTP
	id <S553770AbQLSRJa>; Tue, 19 Dec 2000 09:09:30 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01JXWBSOTPKI0015S2@research.kpn.com> for
 linux-mips@oss.sgi.com; Tue, 19 Dec 2000 18:09:26 +0100
Received: (from karel@localhost)	by sparta.research.kpn.com (8.8.8+Sun/8.8.8)
 id SAA18908; Tue, 19 Dec 2000 18:09:25 +0100 (MET)
X-URL:  http://www-lsdm.research.kpn.com/~karel
Date:   Tue, 19 Dec 2000 18:09:25 +0100 (MET)
From:   Karel van Houten <K.H.C.vanHouten@research.kpn.com>
Subject: Re: Kernel Oops when booting on DECstation
In-reply-to: <XFMail.001219180300.Harald.Koerfgen@home.ivm.de>
To:     Harald.Koerfgen@home.ivm.de
Cc:     tbm@cyrius.com (Martin Michlmayr), linux-mips@oss.sgi.com,
        flo@rfc822.org (Florian Lohoff)
Message-id: <200012191709.SAA18908@sparta.research.kpn.com>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL2]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Harald wrote:
> 
> Is anybody else successfully using the NetBSD bootloader with a Linux kernel?
> 

I used to use the NetBSD bootloader just fine, but switched to delo
recently, which is easier to use because UFS read-write support
is not stable in the current kernels.

-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
