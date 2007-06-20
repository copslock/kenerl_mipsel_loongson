Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2007 14:55:52 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:59268 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024719AbXFTNzI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Jun 2007 14:55:08 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5KDlRYe030654;
	Wed, 20 Jun 2007 14:47:32 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5K85Egm024998;
	Wed, 20 Jun 2007 09:05:14 +0100
Date:	Wed, 20 Jun 2007 09:05:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Marc St-Jean <stjeanma@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 7/12] drivers: PMC MSP71xx GPIO char driver
Message-ID: <20070620080514.GA24818@linux-mips.org>
References: <200706152046.l5FKk3NU015608@pasqua.pmc-sierra.bc.ca> <20070619141256.3d573a41.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070619141256.3d573a41.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 19, 2007 at 02:12:56PM -0700, Andrew Morton wrote:

> > +/* Define the following for extra debug output */
> > +#undef DEBUG
> 
> The under shouldn't be needed: -DDEBUG can be provided on the kbuild
> command line.
> 
> > +#ifdef DEBUG
> > +#define DBG(args...) printk(KERN_DEBUG args)
> > +#else
> > +#define DBG(args...) do {} while (0)
> > +#endif

<linux/kernel.h> provides the equivalent pr_debug function so this
definition of DBG is redundant.

  Ralf
