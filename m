Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2008 00:19:13 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:17146 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S29573444AbYISXTK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 20 Sep 2008 00:19:10 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8JNJ7Ym000730;
	Sat, 20 Sep 2008 01:19:07 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8JNIoCu000725;
	Sat, 20 Sep 2008 00:18:50 +0100
Date:	Sat, 20 Sep 2008 00:18:49 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, u1@terran.org,
	linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
In-Reply-To: <20080919163538.GA22497@networkno.de>
Message-ID: <Pine.LNX.4.55.0809200012030.29711@cliff.in.clinika.pl>
References: <20080917.222350.41199051.anemo@mba.ocn.ne.jp>
 <BD7F24AB-4B0C-4FA4-ADB3-5A86E7A4624F@terran.org> <20080919.011704.59652451.anemo@mba.ocn.ne.jp>
 <20080920.004319.93205397.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.55.0809191656030.29711@cliff.in.clinika.pl>
 <20080919163538.GA22497@networkno.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 19 Sep 2008, Thiemo Seufer wrote:

> >  Unfortunately you can't zero-extend with a single instruction (you can
> > use a single sll(v) to sign-extend), unless the R2 ISA provides some
> > suitable oddity (which I haven't checked).
> 
> AFAIR dext can do this for MIPS64 R2.

 Yeah, I would have thought if anything, it would be something as odd as
that...

  Maciej
