Received:  by oss.sgi.com id <S305177AbQAFTGI>;
	Thu, 6 Jan 2000 11:06:08 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:46716 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305175AbQAFTFm>;
	Thu, 6 Jan 2000 11:05:42 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA19984; Thu, 6 Jan 2000 11:02:11 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA22842
	for linux-list;
	Thu, 6 Jan 2000 10:58:03 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA46322;
	Thu, 6 Jan 2000 10:57:57 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id KAA01481;
	Thu, 6 Jan 2000 10:57:36 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14452.58782.750095.352886@liveoak.engr.sgi.com>
Date:   Thu, 6 Jan 2000 10:57:34 -0800 (PST)
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     "Florian Lohoff" <flo@rfc822.org>, <linux@cthulhu.engr.sgi.com>
Subject: Re: Decstation 5000/150 2.3.21 Boot successs
In-Reply-To: <000601bf5826$273af500$0ceca8c0@satanas.mips.com>
References: <000601bf5826$273af500$0ceca8c0@satanas.mips.com>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Kevin D. Kissell writes:
...
 > The default SGI/MIPS Linux kernel startup sets the
 > "FR" bit in the CP0.Status register, which enables
 > R4000-style FPU registers, which is to say a full
 > compliment of 32 double-precision registers.  This
 > has the side-effect of making the kernel incompatible
 > with the distributed mipsel binaries and the distributed
 > DECstation root file system, since those binaries which
 > do double-precision floating point load their initial values
 > from memory as two singles.  That works on an R3000
 > or an R4000-with-FR=0, but not on an R4000-with-FR=1.
...

     Note that the SVR4 MIPS ABI assumes FR=0 (R3000-compatible), as
do SGI IRIX "-32" ("O32") binaries (and, I believe, default gcc
binaries).  SGI IRIX "-n32" and "-n64" binaries assumes FR=1 (R4000-compatible),
and also have a somewhat different register calling convention (which
affects where arguments to system calls reside).
