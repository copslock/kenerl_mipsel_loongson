Received:  by oss.sgi.com id <S305160AbQAYQME>;
	Tue, 25 Jan 2000 08:12:04 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:3635 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305158AbQAYQLo>;
	Tue, 25 Jan 2000 08:11:44 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA06729; Tue, 25 Jan 2000 08:14:03 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA29930
	for linux-list;
	Tue, 25 Jan 2000 08:01:49 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA43981
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 25 Jan 2000 08:01:45 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (root@lilith.dpo.uab.edu [138.26.1.128]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA17973
	for <linux@cthulhu.engr.sgi.com>; Tue, 25 Jan 2000 07:57:18 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id KAA24065;
	Tue, 25 Jan 2000 10:01:12 -0600
Date:   Tue, 25 Jan 2000 09:59:40 -0600 (CST)
From:   "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Unimplemented exception
In-Reply-To: <200001241939.LAA11957@liveoak.engr.sgi.com>
Message-ID: <Pine.LNX.3.96.1000125095617.16098A-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



On Mon, 24 Jan 2000, Geert Uytterhoeven wrote:
> I get
> 
> | Unimplemented exception for insn 4620a0a4 at 0x0046f084 in install-info.
> 
> in my kernel messages, using 2.3.21 from cvs last week.

That message is from the floating point exception handler.  It looks like
the instruction is a CVT.W.S (convert to single fixed from single float).
This will require full floating point support from the kernel to handle
properly.  I have done some work on floating point support, but this is
not an instruction I have implemented yet.

-Andrew
