Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 22:32:22 +0000 (GMT)
Received: from pD9562327.dip.t-dialin.net ([IPv6:::ffff:217.86.35.39]:55597
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225005AbUKXWcR>; Wed, 24 Nov 2004 22:32:17 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAOMWGVs024974;
	Wed, 24 Nov 2004 23:32:16 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAOMWCNs024972;
	Wed, 24 Nov 2004 23:32:12 +0100
Date: Wed, 24 Nov 2004 23:32:12 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kapoor, Pankaj" <pkapoor@ti.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Cache Question
Message-ID: <20041124223211.GB22439@linux-mips.org>
References: <C4D23DECD6CD714BBFB38B0AE8D25A3A24FF66@dlee2k03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C4D23DECD6CD714BBFB38B0AE8D25A3A24FF66@dlee2k03.ent.ti.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 23, 2004 at 12:19:21PM -0600, Kapoor, Pankaj wrote:

> Is there any specific reason why the cache invalidation routine is
> executed with interrupts disabled? 

That interrupt disabling in some cache flushes dates back further than
CVS history.  Seems once uppon a time there was some CPU which didn't
like cache flushes with interrupts enabled.  This is rather bad for
latencies so unless somebody else on this list recalls a good reason
I'd like to remove this.

  Ralf
