Received:  by oss.sgi.com id <S305157AbQCTKci>;
	Mon, 20 Mar 2000 02:32:38 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:34135 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQCTKcY>;
	Mon, 20 Mar 2000 02:32:24 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA15992; Mon, 20 Mar 2000 02:27:45 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id CAA18247; Mon, 20 Mar 2000 02:31:36 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA59440
	for linux-list;
	Mon, 20 Mar 2000 02:07:21 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA37173
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 20 Mar 2000 02:07:18 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA01859
	for <linux@cthulhu.engr.sgi.com>; Mon, 20 Mar 2000 02:07:17 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA24946;
	Mon, 20 Mar 2000 11:06:53 +0100 (MET)
Date:   Mon, 20 Mar 2000 11:06:52 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     Andreas Jaeger <aj@suse.de>, Florian Lohoff <flo@rfc822.org>,
        linux@cthulhu.engr.sgi.com
Subject: Re: header files state
In-Reply-To: <004401bf924e$f0c526e0$0ceca8c0@satanas.mips.com>
Message-ID: <Pine.GSO.4.10.10003201105400.17246-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, 20 Mar 2000, Kevin D. Kissell wrote:
> >Linus has stated quite violantly that glibc should not include any
> >kernel headers at all - and we're now including less and less
> >headers.  But this process needs time and occasionally breaks older
> >glibc's.
> 
> What is Linus' rationale for his position?   It's true that 
> having includes "reaching in" from libc imposes constraints
> on kernel designers, but failure to do so is guaranteed
> to induce error - as we have seen.

The rationale is that you don't need to install Linux kernel sources to compile
user space programs that don't rely on Linux-specific things.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
