Received:  by oss.sgi.com id <S305160AbQCMVlT>;
	Mon, 13 Mar 2000 13:41:19 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:14910 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQCMVlR>;
	Mon, 13 Mar 2000 13:41:17 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA12568; Mon, 13 Mar 2000 13:36:40 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id NAA21999; Mon, 13 Mar 2000 13:40:46 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA33237
	for linux-list;
	Mon, 13 Mar 2000 12:19:54 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA41856;
	Mon, 13 Mar 2000 12:13:42 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id MAA29284;
	Mon, 13 Mar 2000 12:13:41 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14541.19445.892133.659757@liveoak.engr.sgi.com>
Date:   Mon, 13 Mar 2000 12:13:41 -0800 (PST)
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     "Kevin D. Kissell" <kevink@mips.com>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@vger.rutgers.edu, linux-mips@fnet.fr,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: FP emulation patch available
In-Reply-To: <20000313144657.E845@uni-koblenz.de>
References: <002701bf8cc6$c2ef0200$0ceca8c0@satanas.mips.com>
	<20000313144657.E845@uni-koblenz.de>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ralf Baechle writes:
 > On Mon, Mar 13, 2000 at 09:33:02AM +0100, Kevin D. Kissell wrote:
 > 
 > > Does anyone out there actually need/want an SMP
 > > version of the emulator?   It's not completely trivial,
 > > but it would not be all that difficult to do...
 > 
 > It should be fixed if it's going to be used as the base for the kernel
 > fp support we need also for the Origins.

      Yes, all MIPS CPUs with which I am familiar require at least some
kernel FP support for certain corner cases and workarounds.  
