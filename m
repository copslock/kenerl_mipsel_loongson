Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Aug 2003 18:05:48 +0100 (BST)
Received: from p508B60FA.dip.t-dialin.net ([IPv6:::ffff:80.139.96.250]:2231
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225347AbTHBRFq>; Sat, 2 Aug 2003 18:05:46 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h72H5hpR005112;
	Sat, 2 Aug 2003 19:05:43 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h72H5gLi005111;
	Sat, 2 Aug 2003 19:05:42 +0200
Date: Sat, 2 Aug 2003 19:05:42 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] More time fixes: do_gettimeofday() & do_settimeofday()
Message-ID: <20030802170542.GB19401@linux-mips.org>
References: <Pine.GSO.3.96.1030801134735.3800D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030801134735.3800D-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 01, 2003 at 02:04:29PM +0200, Maciej W. Rozycki wrote:

>  Here are fixes for do_gettimeofday() and do_settimeofday() not taking the
> wall time and the value of tick properly into account.  OK to apply? 

Yes, looks good.  One user less of USECS_PER_JIFFY ...

  Ralf
