Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 18:10:42 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34456 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024636AbZESRKf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 May 2009 18:10:35 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4JH9xvY024062;
	Tue, 19 May 2009 18:09:59 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4JH9v2I024060;
	Tue, 19 May 2009 18:09:57 +0100
Date:	Tue, 19 May 2009 18:09:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Michael Buesch <mb@bu3sch.de>
Cc:	"John W. Linville" <linville@tuxdriver.com>,
	matthieu castet <castet.matthieu@free.fr>,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] bc47xx : export ssb_watchdog_timer_set
Message-ID: <20090519170957.GA23711@linux-mips.org>
References: <4A11DCBF.9000700@free.fr> <20090518224128.GA11912@tuxdriver.com> <200905191524.20421.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200905191524.20421.mb@bu3sch.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 19, 2009 at 03:24:20PM +0200, Michael Buesch wrote:

> > What is the merge path for ssb nowadays?  I used to take these patches
> > (and I'm still happy to do so), but maybe Ralf is (or should be)
> > taking them now?
> 
> That depends on his speed. Last time I submitted a patch through his path,
> it bitrotted for several months before it finally hit mainline.

Maybe because I felt drivers/ssb/ was outside my jurisdiction - and unlike
what alot of people may seem to think I'm not a full time MIPS kernel
hacker.

I can deal with SSB patch if you so desire - but I have no experience with
SSB, so I'd have somebody to rubberstamp non-trivial SSB patches before I
queue them up.  I can keep them either in the usual MIPS trees on
linux-mips.org or I could create a separate linux-ssb tree, depending on
what seems to be sensible.  Also, reading the entry in the maintainers
file I wonder if netdev is really the list of a choice?

  Ralf
