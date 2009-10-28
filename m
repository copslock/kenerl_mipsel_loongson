Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 23:33:09 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42891 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493432AbZJ1WdG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Oct 2009 23:33:06 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9SMYIHD009044;
	Wed, 28 Oct 2009 15:34:19 -0700
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9SMYHsF009042;
	Wed, 28 Oct 2009 15:34:17 -0700
Date:	Wed, 28 Oct 2009 15:34:17 -0700
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Manuel Lauss <manuel.lauss@googlemail.com>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Alchemy: UARTs are 16550A
Message-ID: <20091028223417.GC2921@linux-mips.org>
References: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com> <1256756954-29211-2-git-send-email-manuel.lauss@gmail.com> <20091028122430.f7670ae2.akpm@linux-foundation.org> <f861ec6f0910281227t455a6f5cw9e492a9a1fc1b07e@mail.gmail.com> <20091028125203.c513883e.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091028125203.c513883e.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 28, 2009 at 12:52:03PM -0700, Andrew Morton wrote:

> >  I know, that's why I added "The mips parts apply on top of Ralf's
> > mips-queue tree" below
> > the patch description.
> 
> If that's the case then Ralf's mips-queue tree isn't in linux-next :(

I just respun my tree for linux-next, just in case.

> > If it makes it easier to apply, I could split this one in a mips and in a
> > 8250 patch?
> 
> That's a hard call without knowing what's going on in mipsworld.  If

My tree for linux-next is at

  http://www.linux-mips.org/git?p=upstream-sfr.git;a=summary

  Ralf
