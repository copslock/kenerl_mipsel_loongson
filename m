Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Oct 2004 15:54:52 +0100 (BST)
Received: from p508B61D6.dip.t-dialin.net ([IPv6:::ffff:80.139.97.214]:4730
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224912AbUJDOys>; Mon, 4 Oct 2004 15:54:48 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i94EqlE0008433;
	Mon, 4 Oct 2004 16:52:47 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i94EqiDu008432;
	Mon, 4 Oct 2004 16:52:44 +0200
Date: Mon, 4 Oct 2004 16:52:44 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
Message-ID: <20041004145244.GB8198@linux-mips.org>
References: <4152D58B.608@longlandclan.hopto.org> <20040923154855.GA2550@paradigm.rfc822.org> <20041002185057.GN21351@rembrandt.csv.ica.uni-stuttgart.de> <20041002204014.GO21351@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.58L.0410022213140.18388@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0410022213140.18388@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 03, 2004 at 01:58:27AM +0100, Maciej W. Rozycki wrote:

> Still, tlbw_eret_hazard expands to nothing for non-RM9000 processors.
> 
>  I think we should either handcode all handlers explicitly or build a
> single one dynamically, like we do for copy_page()/clear_page().

That was the plan.

> For now,
> I'll just add the missing nop directly to the handlers.  Thanks for 
> working on it.

Those nops are now cluttering the handler for all those processors
that don't need it.  Great.

  Ralf
