Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2003 12:27:38 +0000 (GMT)
Received: from p508B56DB.dip.t-dialin.net ([IPv6:::ffff:80.139.86.219]:40071
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225324AbTLUM1h>; Sun, 21 Dec 2003 12:27:37 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hBLCRaoK027164;
	Sun, 21 Dec 2003 13:27:36 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hBLCRZtU027163;
	Sun, 21 Dec 2003 13:27:35 +0100
Date: Sun, 21 Dec 2003 13:27:35 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: karthikeyan natarajan <karthik_96cse@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Info needed about cache..
Message-ID: <20031221122735.GA26652@linux-mips.org>
References: <20031221084425.35212.qmail@web10108.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221084425.35212.qmail@web10108.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Dec 21, 2003 at 08:44:25AM +0000, karthikeyan natarajan wrote:

>     I would like learn about L1, L2 & L3 caches w.r.t
> MIPS, in detail. Could you pls give me a pointer to
> the document available on the Net...

This information is horribly scattered over lots of resources.  A well
written and fun to read book is "See MIPS Run" by Dominik Sweetman; see
also the literature section of www.linux-mips.com.  The Hennesey &
Patterson books looks at caches from a more theoretical perspective but
provides the necessary background.

  Ralf
