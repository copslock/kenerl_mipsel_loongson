Received:  by oss.sgi.com id <S553698AbRCMSSU>;
	Tue, 13 Mar 2001 10:18:20 -0800
Received: from hermes.research.kpn.com ([139.63.192.8]:11016 "EHLO
        hermes.research.kpn.com") by oss.sgi.com with ESMTP
	id <S553694AbRCMSSI>; Tue, 13 Mar 2001 10:18:08 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01K15QOTAXMI000JW2@research.kpn.com>; Tue,
 13 Mar 2001 19:18:06 +0100
Received: (from karel@localhost)	by sparta.research.kpn.com (8.8.8+Sun/8.8.8)
 id TAA14585; Tue, 13 Mar 2001 19:18:05 +0100 (MET)
X-URL:  http://www-lsdm.research.kpn.com/~karel
Date:   Tue, 13 Mar 2001 19:18:05 +0100 (MET)
From:   Karel van Houten <K.H.C.vanHouten@research.kpn.com>
Subject: Re: Compile error with current CVS kernel
In-reply-to: <20010313152236.B1208@bacchus.dhis.org>
To:     ralf@oss.sgi.com (Ralf Baechle)
Cc:     bunk@fs.tum.de (Adrian Bunk), linux-mips@oss.sgi.com
Message-id: <200103131818.TAA14585@sparta.research.kpn.com>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL2]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi Ralf,

Ralf wrote:
> 
> That's scary - these sections are explicitly mentioned in the linker
> script and yet ld places them near address zero.  Oh pleassure, oh
> garbage.
> 
> This can probably be fixed by changing the ldscript; can experiment what
> it takes to get your ld to place all sections with a LOAD attribute placed
> next to each other?  My ld behaves fine.

Can you point me to a binutils version and/or patches that should
behave OK for native compiles?

-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
