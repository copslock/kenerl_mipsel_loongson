Received:  by oss.sgi.com id <S305157AbPLCQpJ>;
	Fri, 3 Dec 1999 08:45:09 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:40 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbPLCQom>; Fri, 3 Dec 1999 08:44:42 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id IAA02429; Fri, 3 Dec 1999 08:53:17 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA45015
	for linux-list;
	Fri, 3 Dec 1999 08:39:45 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA88087
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 3 Dec 1999 08:39:38 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA01339
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Dec 1999 08:39:26 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPLCQiZ>;
	Fri, 3 Dec 1999 14:38:25 -0200
Date:   Fri, 3 Dec 1999 14:38:25 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marc Esipovich <marc@mucom.co.il>, e1097757@ceng.metu.edu.tr,
        linux@cthulhu.engr.sgi.com
Subject: Re: EXT2 fs error
Message-ID: <19991203143825.M982@uni-koblenz.de>
References: <000c01bf3da2$dab2a400$e548e8c3@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <000c01bf3da2$dab2a400$e548e8c3@thinkpad>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Dec 03, 1999 at 04:26:42PM +0100, Kevin D. Kissell wrote:

> >I've seen this happening on my Indy as well like once every month or even
> >more rarely.  It only happens very rarely but it happens.  I think the
> >hardware of my Indy is fine as all my attempts to reduce the problems I'm
> >experiencing during my development to a hardware problem have failed.

> By any chance are you guys seeing this on R5000 Indys?

Yes.

> There is an assumption in arch/mips/mm/r4xx0.c that flushing the secondary
> cache automagically flushes the same address in the primary data cache,
> but that assumption is not universally valid and there is no reason to
> believe that it is true on the R5K.

We make this assumption for R[04]00[SM]C CPUs only.  For R5000SC CPU modules
as in the Indy the assumption is that we don't need to flush the l2 caches
unless we do a DMA operation in which case the special r4k_dma_*
functions will take care of the whatever might be necessary to keep caches
consistent with DMA.

  Ralf
