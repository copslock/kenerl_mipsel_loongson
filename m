Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2008 15:39:21 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:46254
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28586792AbYGROjS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2008 15:39:18 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6IEdEkw025734;
	Fri, 18 Jul 2008 15:39:14 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6IEdD35025732;
	Fri, 18 Jul 2008 15:39:13 +0100
Date:	Fri, 18 Jul 2008 15:39:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Brian Foster <brian.foster@innova-card.com>
Cc:	Daniel Laird <daniel.j.laird@nxp.com>, linux-mips@linux-mips.org
Subject: Re: HOWTO submit patches using WebMail - Help appreciated?
Message-ID: <20080718143913.GB25491@linux-mips.org>
References: <64660ef00807171259l55f85380l47cfdc7574f84099@mail.gmail.com> <200807181528.41119.brian.foster@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200807181528.41119.brian.foster@innova-card.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 18, 2008 at 03:28:40PM +0200, Brian Foster wrote:

> On Thursday 17 July 2008 21:59:45 Daniel Laird wrote:
> > 
> > I am having issues getting patches to the mailing list in a format
> > that seems to be acceptable.
> > I have done all I can to the patch itself but I am having mail client
> > issues as well.
> > I have tried Gmail with plaintext.  [ ... ]
> > 
> > Is there anyone who has used a web mail client and had success, most
> > details out there [ ... not for ] people with Work based mail accounts.
> 
> Dan,
> 
>   Guessing a bit, that sounds a lot like the problem I had:
>  It was (and still is) impossible to use the company's SMTP
>  MTA to send a patch (or even an acceptable list posting),
>  even if the client (MUA) wasn't going to mess things up.
> 
>   But, if you have a Gmail account, it can be done!  In fact,
>  that is what I'm doing to send this reply:  Using the MUA at
>  the company, but *not* using the company's SMTP.  The secret
>  is Gmail now has SMTP (and IMAP) support, as well as the POP
>  support they've had for awhile.  You need to enable the SMTP
>  for your Gmail account, and arrange for a non-corrupting MUA
>  to use Gmail's SMTP, and (assuming your company's firewall
>  et al. doesn't cause issues), things may just work.

I'd like to remind people of the wiki page on this topic at

  http://www.linux-mips.org/wiki/Mailing-patches

It's not been updated in a while and doesn't cover all clients or
possible solutions so feel free to update it.

  Ralf
