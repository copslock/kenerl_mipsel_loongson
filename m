Received:  by oss.sgi.com id <S305157AbQCRFTv>;
	Fri, 17 Mar 2000 21:19:51 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:47731 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQCRFTT>;
	Fri, 17 Mar 2000 21:19:19 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id VAA25044; Fri, 17 Mar 2000 21:14:41 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA92664
	for linux-list;
	Fri, 17 Mar 2000 21:00:18 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA15086;
	Fri, 17 Mar 2000 21:00:16 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from dial-2-116.cwb.matrix.com.br (dial-2-116.cwb.matrix.com.br [200.202.9.116]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA06345; Fri, 17 Mar 2000 21:00:00 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407911AbQCRE7n>;
	Sat, 18 Mar 2000 01:59:43 -0300
Date:   Sat, 18 Mar 2000 01:59:43 -0300
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "William J. Earl" <wje@cthulhu.engr.sgi.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>,
        "Kevin D. Kissell" <kevink@mips.com>,
        SGI Linux Alias <linux@cthulhu.engr.sgi.com>
Subject: Re: Include coherency problem, sigaction and otherwise
Message-ID: <20000318015943.A1536@uni-koblenz.de>
References: <000e01bf903e$a0e864a0$0ceca8c0@satanas.mips.com> <20000318010801.B811@uni-koblenz.de> <14547.2292.467349.391271@liveoak.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <14547.2292.467349.391271@liveoak.engr.sgi.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Mar 17, 2000 at 08:41:24PM -0800, William J. Earl wrote:

>  > The bits/ subdirectory was introduced for glibc 2.1.
> 
>     The bits/ subdirectory is present in 2.1, but at least 2.1.1-7 does
> not have a bits/sigaction.h for MIPS in the source, so the generic 
> one is used, and that is inconsistent with the kernel.

2.1 isn't supposed to be usable or even compilable for MIPS thanks to the
infamous linker problems.  Details on request.

> Which source for glibc has a MIPS bits/sigaction.h?

The latest Cygnus CVS development version has this and many other buglets
corrected mostly thanks to Andreas Jaeger who did start integrating my
old 2.0 port with the GNU sources and fix a ton of such buglets.

  Ralf
