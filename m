Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2007 13:13:43 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:41923 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024998AbXIEMNl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Sep 2007 13:13:41 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l85CDdRs018155;
	Wed, 5 Sep 2007 13:13:40 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l85CDbKk018154;
	Wed, 5 Sep 2007 13:13:37 +0100
Date:	Wed, 5 Sep 2007 13:13:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	bo y <byu1000@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: tlbex.c
Message-ID: <20070905121337.GA18135@linux-mips.org>
References: <99ac6e0e0708270822w32f8a024gd18c5883c86c8713@mail.gmail.com> <Pine.LNX.4.64N.0708291302350.26167@blysk.ds.pg.gda.pl> <20070905111121.GC9977@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070905111121.GC9977@networkno.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 05, 2007 at 12:11:22PM +0100, Thiemo Seufer wrote:

> > > Should the following instruction field masks to be 0x3f ?
> > > 
> > >    #define OP_MASK         0x2f
> > >    #define FUNC_MASK       0x2f
> > > 
> > > I do not see OP_MASK is used but FUNC_MASK is used in the same file.
> > 
> >  Yes.  Send a patch.
> 
> Appended, please apply.

Applied, thanks.

  Ralf
