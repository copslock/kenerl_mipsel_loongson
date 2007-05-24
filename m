Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2007 12:51:48 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:41422 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021933AbXEXLvo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 May 2007 12:51:44 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4OBpUpE001605;
	Thu, 24 May 2007 12:51:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4OBpSeG001604;
	Thu, 24 May 2007 12:51:28 +0100
Date:	Thu, 24 May 2007 12:51:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shane McDonald <Shane_McDonald@pmc-sierra.com>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [NET] meth driver renovation
Message-ID: <20070524115127.GB27073@linux-mips.org>
References: <8A9D56C5E50F774BABE033F1710B3576093B15@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A9D56C5E50F774BABE033F1710B3576093B15@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 23, 2007 at 01:02:18PM -0700, Shane McDonald wrote:

> >  static void __exit meth_exit_module(void)
> >  {
> > -	unregister_netdev(meth_dev);
> > -	free_netdev(meth_dev);
> > +	platform_driver_register(&meth_driver);
> >  }
> 
>                       ^^^^^^^^
> 
>       platform_driver_unregister(&meth_driver);

Indeed.  Will send new patch in separate email.

  Ralf
