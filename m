Received:  by oss.sgi.com id <S305158AbQCILZg>;
	Thu, 9 Mar 2000 03:25:36 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:57153 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQCILZE>;
	Thu, 9 Mar 2000 03:25:04 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA20676; Thu, 9 Mar 2000 03:20:27 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id DAA24221; Thu, 9 Mar 2000 03:24:33 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA42608
	for linux-list;
	Thu, 9 Mar 2000 02:50:50 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA47612
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Mar 2000 02:50:32 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA00014
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Mar 2000 02:50:30 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA13550;
	Thu, 9 Mar 2000 11:49:36 +0100 (MET)
Date:   Thu, 9 Mar 2000 11:49:36 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     Dominic Sweetman <dom@algor.co.uk>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        Linux SGI <linux@cthulhu.engr.sgi.com>, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: R39xx and Processor IDs (was Re: FP emulation patch available)
In-Reply-To: <007701bf89ae$ae3d9710$0ceca8c0@satanas.mips.com>
Message-ID: <Pine.GSO.4.10.10003091149140.3760-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, 9 Mar 2000, Kevin D. Kissell wrote:
> The collision is real.  As has been noted elsewhere in this thread,
> the R4640/4650 has no business running Linux, as it lacks a
> page-based MMU.  I had a bit of "cognative dissonance" when

Side note: do I hear `uClinux'?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
