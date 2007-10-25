Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 15:13:27 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:28094 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022661AbXJYONZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 15:13:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9PEDE31023605;
	Thu, 25 Oct 2007 15:13:14 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9PEDDqd023604;
	Thu, 25 Oct 2007 15:13:13 +0100
Date:	Thu, 25 Oct 2007 15:13:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [IDE] Fix build bug
Message-ID: <20071025141313.GA23536@linux-mips.org>
References: <20071025135334.GA23272@linux-mips.org> <20071025141305.GA11698@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071025141305.GA11698@uranus.ravnborg.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 25, 2007 at 04:13:05PM +0200, Sam Ravnborg wrote:

> On Thu, Oct 25, 2007 at 02:53:34PM +0100, Ralf Baechle wrote:
> >   CC      drivers/ide/pci/generic.o
> > drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
> > +section type conflict
> > 
> > This sort of build error is becoming a regular issue.  Either all or non
> > of the elements that go into a particular section of a compilation unit
> > need to be const.  Or an error may result such as in this case if
> > CONFIG_HOTPLUG is unset.
> So we can avoid this if we invent a __constinitdata tag that uses
> a new section?
> I ask mainly to understand this error - not that I am that found
> of the idea.

Yes.

  Ralf
