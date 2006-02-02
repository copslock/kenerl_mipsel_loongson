Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 17:19:29 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:21003 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465649AbWBBRTL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Feb 2006 17:19:11 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k12HOYSY021790;
	Thu, 2 Feb 2006 17:24:34 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k12HOYru021789;
	Thu, 2 Feb 2006 17:24:34 GMT
Date:	Thu, 2 Feb 2006 17:24:34 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
Message-ID: <20060202172434.GE17352@linux-mips.org>
References: <20060203.013401.41198517.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0602021636380.11727@blysk.ds.pg.gda.pl> <20060202165656.GC17352@linux-mips.org> <20060203.020428.59032357.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203.020428.59032357.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 03, 2006 at 02:04:28AM +0900, Atsushi Nemoto wrote:

> Is this preferred?  We can get rid of all TX49XX_MFC0_WAR on this way.

It should be ok for any R4000-style status register.  I'm not sure about
R3000 - but I'm sure Maciej will know.  If he agrees I'd say let's go for
it.

  Ralf
