Received:  by oss.sgi.com id <S305161AbQCMUdt>;
	Mon, 13 Mar 2000 12:33:49 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:38945 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305160AbQCMUdR>;
	Mon, 13 Mar 2000 12:33:17 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA29140; Mon, 13 Mar 2000 12:28:40 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id MAA08105; Mon, 13 Mar 2000 12:33:16 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA38375
	for linux-list;
	Mon, 13 Mar 2000 11:30:41 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA16389
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 13 Mar 2000 11:29:59 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi ([200.250.58.146]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA10139
	for <linux@cthulhu.engr.sgi.com>; Mon, 13 Mar 2000 11:25:13 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S408081AbQCMRq5>;
	Mon, 13 Mar 2000 14:46:57 -0300
Date:   Mon, 13 Mar 2000 14:46:57 -0300
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@vger.rutgers.edu, linux-mips@fnet.fr,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: FP emulation patch available
Message-ID: <20000313144657.E845@uni-koblenz.de>
References: <002701bf8cc6$c2ef0200$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <002701bf8cc6$c2ef0200$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Mar 13, 2000 at 09:33:02AM +0100, Kevin D. Kissell wrote:

> Does anyone out there actually need/want an SMP
> version of the emulator?   It's not completely trivial,
> but it would not be all that difficult to do...

It should be fixed if it's going to be used as the base for the kernel
fp support we need also for the Origins.

  Ralf
