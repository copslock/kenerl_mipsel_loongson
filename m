Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 06:12:13 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:26534
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20029715AbYG2FMI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2008 06:12:08 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6T5AnMo018396;
	Tue, 29 Jul 2008 06:11:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6T5AlXS018395;
	Tue, 29 Jul 2008 06:10:47 +0100
Date:	Tue, 29 Jul 2008 06:10:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	linux-mips@linux-mips.org, dmitri.vorobiev@movial.fi
Subject: Re: [PATCH v2 1/1][MIPS] Initialization of Alchemy boards
Message-ID: <20080729051047.GA18334@linux-mips.org>
References: <1217268566.19887.3.camel@kh-ubuntu.razamicroelectronics.com> <20080728223603.GA1430@linux-mips.org> <1217303764.9702.4.camel@kh-d820-ubuntu.razamicroelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1217303764.9702.4.camel@kh-d820-ubuntu.razamicroelectronics.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 28, 2008 at 10:56:04PM -0500, Kevin Hickey wrote:

> > One little nit on the submission format - if you include a diffstat, please
> > put it after a line consisting only of three - like this:
> It was only after creating this that I discovered git-format-patch.
> I'll use that in the future (I can assume that it handles stat lines
> correctly, right?).

Of course.  But it only works if you maintain your patches in git ;-)

> Thanks!  Is there any chance of this making it into 2.6.27?  I saw that
> Linus marked the master branch as 2.6.27-rc1 today, so I'm not very
> optimistic.  But I have to make some decisions about internal releases
> etc and I'm still trying to get a handle on how the kernel gets
> versioned. 

Of course it will; it's a fix after all so not affected at all by the-rc1
deadline.

  Ralf
