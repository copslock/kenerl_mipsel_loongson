Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 16:32:22 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:32423 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20021805AbZCaPcP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Mar 2009 16:32:15 +0100
Received: (qmail 11243 invoked by uid 1000); 31 Mar 2009 17:32:13 +0200
Date:	Tue, 31 Mar 2009 17:32:13 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	Linux MIPS org <linux-mips@linux-mips.org>
Subject: Re: PATCH for SMTC: Fix Name Collision in _clockevent_init
	functions
Message-ID: <20090331153213.GA11043@roarinelk.homelinux.net>
References: <49D1FA28.4030308@paralogos.com> <20090331131251.GC3804@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090331131251.GC3804@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Kevin, Ralf,

On Tue, Mar 31, 2009 at 03:12:51PM +0200, Ralf Baechle wrote:
> On Tue, Mar 31, 2009 at 01:10:32PM +0200, Kevin D. Kissell wrote:
> > From: "Kevin D. Kissell" <kevink@paralogos.com>
> > Date: Tue, 31 Mar 2009 13:10:32 +0200
> > To: Linux MIPS org <linux-mips@linux-mips.org>
> > Subject: PATCH for SMTC: Fix Name Collision in _clockevent_init functions
> > Content-Type: multipart/mixed;
> > 	boundary="------------070601030706030107070108"
> > 
> > Commit 779e7d41ad004946603da139da99ba775f74cb1c created a name collision
> > in SMTC builds.  The attached patch corrects this in a a

Oh, I'm sorry.


> > not-too-terribly-ugly manner.  Note that the SMTC case has to come
> > first, because CEVT_R4K will also be true.

I'm curious: Is it required to use the CP0 counter for SMTC kernels, or
could the SMTC-specific parts somehow be abstracted out and called by
other timer backends? (for a hypothetical SMTC-enhanced Alchemy core)


> Looks ok but I won't apply it immediately to give Manuel a chance to
> comment.

It works for me (both alchemy and CP0 timers).

Thanks!
	Manuel Lauss
