Received:  by oss.sgi.com id <S305166AbQBNXVW>;
	Mon, 14 Feb 2000 15:21:22 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:40475 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQBNXU6>; Mon, 14 Feb 2000 15:20:58 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA01133; Mon, 14 Feb 2000 15:23:48 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id PAA28743; Mon, 14 Feb 2000 15:20:56 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA43708
	for linux-list;
	Mon, 14 Feb 2000 15:13:00 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA24889
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 14 Feb 2000 15:12:58 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA05552
	for <linux@cthulhu.engr.sgi.com>; Mon, 14 Feb 2000 15:12:57 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-16.uni-koblenz.de (cacc-16.uni-koblenz.de [141.26.131.16])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id AAA23489;
	Tue, 15 Feb 2000 00:12:43 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407895AbQBNRNq>;
	Mon, 14 Feb 2000 18:13:46 +0100
Date:   Mon, 14 Feb 2000 18:13:46 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: Indy crashes
Message-ID: <20000214181346.I30488@uni-koblenz.de>
References: <20000203021018.A25786@uni-koblenz.de> <Pine.GSO.4.10.10002141000350.831-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.GSO.4.10.10002141000350.831-100000@dandelion.sonytel.be>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Feb 14, 2000 at 10:01:44AM +0100, Geert Uytterhoeven wrote:

> On Thu, 3 Feb 2000, Ralf Baechle wrote:
> > Today I exchanged the R5000 CPU module in my Indy against a R4600 module
> > and found that on R4600SC the kernel runs reliable while it crashs pretty
> > soon after booting on a R5000SC module.  This is consistent with the
> > reports that I've looked at.
> 
> That could explain the crashes I see on the DDB Vrc-5074 as well, which has a
> NEC VR5000.
> 
> I'll try to fix the bootmem stuff ASAP and upgrade to 2.3.38.

I made a silly mistake during my tests and will have to retry.

  Ralf
