Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2007 09:47:12 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:62621 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022346AbXKHJrK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Nov 2007 09:47:10 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA89l99A010871;
	Thu, 8 Nov 2007 09:47:09 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA89l8jf010870;
	Thu, 8 Nov 2007 09:47:08 GMT
Date:	Thu, 8 Nov 2007 09:47:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][au1000] Remove useless EXTRA_CFLAGS
Message-ID: <20071108094708.GA10665@linux-mips.org>
References: <200710252108.43357.florian.fainelli@telecomint.eu> <20071029151010.GA3953@linux-mips.org> <Pine.LNX.4.64N.0711071239560.14970@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0711071239560.14970@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 07, 2007 at 12:41:29PM +0000, Maciej W. Rozycki wrote:

> > And to ensure it will stay that way I'll keep -Werror.  It seems only
> > little PITAs like this keep everybody on their toes :-)
> 
>  Yeah...  If only GCC had no bugs and always had a clue of what to warn 
> about...

The least of all problems.

As of 2.6.20-rc2-git2 we had 137 warnings in MIPS specific code of a total
of 218 for the kernel and 44 for modules - that's a insane 52%.  And people
happily added more crappy code because they didn't not even _notice_ the
warnings some of which indeed were bugs.

Compare to 2.6.23 - 13 warnings for MIPS specific code of a total of 48
warnings and another 23 warnings for all the modules.  For a codebase
which overall had grown by half a million lines between those releases.

  Ralf
