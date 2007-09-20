Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 15:21:45 +0100 (BST)
Received: from pentafluge.infradead.org ([213.146.154.40]:44775 "EHLO
	pentafluge.infradead.org") by ftp.linux-mips.org with ESMTP
	id S20021926AbXITOVg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 15:21:36 +0100
Received: from localhost ([127.0.0.1])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IYMuN-0003YI-D1; Thu, 20 Sep 2007 15:21:35 +0100
Date:	Thu, 20 Sep 2007 19:54:31 +0530 (IST)
From:	Satyam Sharma <satyam@infradead.org>
X-X-Sender: satyam@enigma.security.iitk.ac.in
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
cc:	Andrew Morton <akpm@linux-foundation.org>,
	Antonino Daplas <adaplas@pol.net>,
	linux-fbdev-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/video/pmag-ba-fb.c: Improve diagnostics
In-Reply-To: <Pine.LNX.4.64N.0709201445590.30788@blysk.ds.pg.gda.pl>
Message-ID: <alpine.LFD.0.999.0709201946130.17093@enigma.security.iitk.ac.in>
References: <Pine.LNX.4.64N.0709171736580.17606@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.64N.0709181314300.9650@blysk.ds.pg.gda.pl>
 <20070919172412.725508d0.akpm@linux-foundation.org>
 <Pine.LNX.4.64N.0709201342160.30788@blysk.ds.pg.gda.pl>
 <alpine.LFD.0.999.0709201837160.17093@enigma.security.iitk.ac.in>
 <Pine.LNX.4.64N.0709201445590.30788@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Return-Path: <satyam@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: satyam@infradead.org
Precedence: bulk
X-list: linux-mips



On Thu, 20 Sep 2007, Maciej W. Rozycki wrote:
> 
>  Perhaps preinitialising to an error value such as -EINVAL would be of
> more sense.  This way any error paths lacking initialisation are still
> reported as errors, even though the classification might be wrong.

Eeee ... at least I wouldn't prefer that. Why not simply use the
"int x = x;" trick (which is what uninitialized_var() does) -- it shuts
up the warning, and does *nothing* else. The bug will not be hidden, if
there's bad misbehaviour happening due to the bug, it will continue to
happen that way -- thus bringing our attention to it. Pre-initializing
to -EINVAL (or whatever) has the problem that when the bug actually
triggers, something unrelated might happen higher up the callchain, and
we'd be scratching our heads in a "why are we getting a -EINVAL here?"
kind of way ... worse still, we might think that this was _really_ an
EINVAL and go about debugging it ...

Plus, pre-initializing to -EINVAL (or even 0) will waste some bytes in
kernel text size, but no such overhead with uninitialized_var() :-)


Satyam
