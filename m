Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2004 20:06:14 +0100 (BST)
Received: from pD9562698.dip.t-dialin.net ([IPv6:::ffff:217.86.38.152]:17260
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225195AbUJETGJ>; Tue, 5 Oct 2004 20:06:09 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i95J48O7004411;
	Tue, 5 Oct 2004 21:04:08 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i95J48KZ004410;
	Tue, 5 Oct 2004 21:04:08 +0200
Date: Tue, 5 Oct 2004 21:04:08 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
Message-ID: <20041005190408.GD2160@linux-mips.org>
References: <4152D58B.608@longlandclan.hopto.org> <20040923154855.GA2550@paradigm.rfc822.org> <20041002185057.GN21351@rembrandt.csv.ica.uni-stuttgart.de> <20041002204014.GO21351@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.58L.0410022213140.18388@blysk.ds.pg.gda.pl> <20041004145244.GB8198@linux-mips.org> <Pine.LNX.4.58L.0410050044510.14763@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0410050044510.14763@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 05, 2004 at 12:48:37AM +0100, Maciej W. Rozycki wrote:

> 1. The handler is expected to be for R4000/R4400 only.  If it's used for

You're alone in that believe.  Despite it's name it's being used for
anything that doesn't need it's own special handler.

> 2. The except_vec0_sb1 handler is one with the nop omitted, so it can be
>    used for these processors.

Adding more obscurity?

> 3. Correct operation first, only then optimization.

On of the free software lessons is a bad solution is worse than no solution.

> 5. Given the "gran plan" as referred to above, points 1 - 4 above are
>    probably irrelevant anyway. ;-)

Only once implemented.

  Ralf
