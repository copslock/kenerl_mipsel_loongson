Received:  by oss.sgi.com id <S553711AbRCMSjb>;
	Tue, 13 Mar 2001 10:39:31 -0800
Received: from hermes.research.kpn.com ([139.63.192.8]:35592 "EHLO
        hermes.research.kpn.com") by oss.sgi.com with ESMTP
	id <S553695AbRCMSjB>; Tue, 13 Mar 2001 10:39:01 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01K15REQGXS8000J7C@research.kpn.com>; Tue,
 13 Mar 2001 19:39:00 +0100
Received: (from karel@localhost)	by sparta.research.kpn.com (8.8.8+Sun/8.8.8)
 id TAA14965; Tue, 13 Mar 2001 19:38:59 +0100 (MET)
X-URL:  http://www-lsdm.research.kpn.com/~karel
Date:   Tue, 13 Mar 2001 19:38:59 +0100 (MET)
From:   Karel van Houten <K.H.C.vanHouten@research.kpn.com>
Subject: Re: Compile error with current CVS kernel
In-reply-to: <20010313192711.F1208@bacchus.dhis.org>
To:     ralf@oss.sgi.com (Ralf Baechle)
Cc:     bunk@fs.tum.de (Adrian Bunk), linux-mips@oss.sgi.com
Message-id: <200103131838.TAA14965@sparta.research.kpn.com>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL2]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

Ralf wrote:
> Karel wrote:
> > Can you point me to a binutils version and/or patches that should
> > behave OK for native compiles?
> 
> It's not native vs. crosscompile; this problem with binutils hits in both
> cases and only older versions (which aren't suitable for use with
> glibc 2.2 ...) are not affected.

I've just finished compiling gcc 3.0, from CVS, and am now trying
to rebuild the kernel with this compiler (same binutils, from cvs).
Keith mentioned he did succeed in building a kernel with these...

-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
