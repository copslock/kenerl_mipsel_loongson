Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Feb 2005 18:09:32 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:63429 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225296AbVBFSI5>; Sun, 6 Feb 2005 18:08:57 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j16I4A9t006955
	for <linux-mips@linux-mips.org>; Sun, 6 Feb 2005 18:04:10 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j16I49Me006954
	for linux-mips@linux-mips.org; Sun, 6 Feb 2005 18:04:09 GMT
Resent-Message-Id: <200502061804.j16I49Me006954@dea.linux-mips.net>
Date:	Sun, 6 Feb 2005 18:03:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Paul Mundt <lethal@linux-sh.org>, Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add as-option to top-level Makefile
Message-ID: <20050206180308.GA21172@linux-mips.org>
References: <20050206170347.GB27853@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206170347.GB27853@linux-sh.org>
User-Agent: Mutt/1.4.1i
Resent-From: ralf@linux-mips.org
Resent-Date: Sun, 6 Feb 2005 18:04:09 +0000
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 06, 2005 at 07:03:47PM +0200, Paul Mundt wrote:

> cc-option can presently not be used for checking as flags. It seems like
> MIPS ran into this already and added their own as-option (which at this
> point seems to be completely unused on MIPS, so perhaps it's worth
> removing entirely from there).
> 
> This patch moves the definition to the top-level Makefile so that others
> can make use of it (sh wants this with newer binutils that allow for ISA
> tuning, for instance).
> 
> Additionally, it may make more sense to move the -Wa$(comma) stuff into
> as-option directly so it doesn't get repeated all over the place (though
> it seems unlikely that there will be enough users that actually care
> about this).

For MIPS as-option became unused when old binutils versions finally had to
be retired.  Patch looks good to me but since it's sort of a no-op patch I
won't merge it into linux-mips.org but if accepted rather wait until it
comes to me vi Linus's patches, as usual.

Thanks,

  Ralf
