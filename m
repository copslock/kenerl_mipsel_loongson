Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Feb 2009 02:23:55 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:31314 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20643871AbZBOCXw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Feb 2009 02:23:52 +0000
Received: from Mobile0.Peter (194.105.100.66.dynamic.cablesurf.de [194.105.100.66])
	by mail1.pearl-online.net (Postfix) with ESMTP id 12507D5BA;
	Sun, 15 Feb 2009 03:23:43 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by Mobile0.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id n1F3PK1E001242;
	Sun, 15 Feb 2009 03:25:20 GMT
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id n1F2K4BQ000478;
	Sun, 15 Feb 2009 03:20:05 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id n1F2K4IN000475;
	Sun, 15 Feb 2009 03:20:04 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Sun, 15 Feb 2009 03:20:04 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: cacheflush system call-MIPS
In-Reply-To: <20090213235603.GA32274@linux-mips.org>
Message-ID: <Pine.LNX.4.58.0902150312460.459@Indigo2.Peter>
References: <f5a7b3810902100716t2658ce95t2dcc7f85634522@mail.gmail.com>
 <20090211131649.GA1365@linux-mips.org> <Pine.LNX.4.58.0902140002180.408@Indigo2.Peter>
 <20090213235603.GA32274@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips


> Why does it need that flush?

To prepare the update-area (in the Shadow-FB) for DMA to RE.


kind regards



On Fri, 13 Feb 2009, Ralf Baechle wrote:

> Date: Fri, 13 Feb 2009 23:56:03 +0000
> From: Ralf Baechle <ralf@linux-mips.org>
> To: peter fuerst <post@pfrst.de>
> Cc: naresh kamboju <naresh.kernel@gmail.com>, linux-mips@linux-mips.org
> Subject: Re: cacheflush system call-MIPS
>
> On Sat, Feb 14, 2009 at 12:50:46AM +0100, peter fuerst wrote:
>
> > there is one more good reason to ... : the Impact Xserver needs to do
> > a cacheflush(a,w,DCACHE) as part of the refresh-sequence.
> > And hence requires a sys_cacheflush, let's say, more conforming to the
> > man-page (or some disgusting new ioctl in the Impact kernel-driver to
> > do an equivalent operation ;-)
>
> Why does it need that flush?
>
>   Ralf
>
>
