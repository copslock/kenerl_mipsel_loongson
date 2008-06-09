Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 22:54:48 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:6386 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20030582AbYFIVyq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Jun 2008 22:54:46 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m59Ls324030005;
	Mon, 9 Jun 2008 23:54:03 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m59Ls2tl030001;
	Mon, 9 Jun 2008 22:54:02 +0100
Date:	Mon, 9 Jun 2008 22:54:01 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Richard Sandiford <rdsandiford@googlemail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: Changing the treatment of the MIPS HI and LO registers
In-Reply-To: <87zlpuxqfb.fsf@firetop.home>
Message-ID: <Pine.LNX.4.55.0806092247001.29754@cliff.in.clinika.pl>
References: <87tzgj4nh6.fsf@firetop.home> <Pine.LNX.4.55.0805272134540.18833@cliff.in.clinika.pl>
 <87abib4d9t.fsf@firetop.home> <Pine.LNX.4.55.0805272357020.18833@cliff.in.clinika.pl>
 <87r6bm1ebd.fsf@firetop.home> <Pine.LNX.4.55.0805290213140.29522@cliff.in.clinika.pl>
 <878wxtvarg.fsf@firetop.home> <8763stz2p3.fsf@firetop.home>
 <87zlpuxqfb.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 9 Jun 2008, Richard Sandiford wrote:

> Please shout if you find anything wrong with either the patch or
> the documentation changes.

 Lacking the time to review your changes or at least test at the run time
(sorry!) I trust you have done a decent job as usually.  Perhaps someone
else can to that.  Otherwise the results will come back and haunt you in
some two years or suchlike when people start using this version of GCC to
build the kernel. ;)

 To give you an indicator -- I am still using 4.1.2 and will keep doing so
for another year or so.  I may skip a version or two when I finally decide
to upgrade though.

  Maciej
