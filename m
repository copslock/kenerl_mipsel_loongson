Received:  by oss.sgi.com id <S305162AbQBOTAY>;
	Tue, 15 Feb 2000 11:00:24 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:15479 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQBOTAA>; Tue, 15 Feb 2000 11:00:00 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA05379; Tue, 15 Feb 2000 11:02:52 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA08084
	for linux-list;
	Tue, 15 Feb 2000 10:46:09 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA39248
	for <linux@relay.engr.sgi.com>;
	Tue, 15 Feb 2000 10:46:07 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id KAA15363
	for linux@engr.sgi.com; Tue, 15 Feb 2000 10:46:00 -0800
Date:   Tue, 15 Feb 2000 10:46:00 -0800
Message-Id: <200002151846.KAA15363@liveoak.engr.sgi.com>
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From:   geert@linux-m68k.org
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     Ralf Baechle <ralf@oss.sgi.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: Indy crashes
In-Reply-To: <022301bf7730$92b87180$0ceca8c0@satanas.mips.com>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, 14 Feb 2000, Kevin D. Kissell wrote:
> >On Thu, 3 Feb 2000, Ralf Baechle wrote:
> >> Today I exchanged the R5000 CPU module in my Indy against a R4600 module
> >> and found that on R4600SC the kernel runs reliable while it crashs pretty
> >> soon after booting on a R5000SC module.  This is consistent with the
> >> reports that I've looked at.
> >
> >That could explain the crashes I see on the DDB Vrc-5074 as well, which has a
> >NEC VR5000.
> >
> >I'll try to fix the bootmem stuff ASAP and upgrade to 2.3.38.
> 
> The problem may be in the assumption made even in the
> most recent 2.3.x code that a hit-writeback-invalidate cache
> operation on the secondary cache automagically affects the
> primary.  That's the way it is on the R4000/4400, but that's

In that case it doesn't affect the NEC DDB Vrc-5074, since there's no L2.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
