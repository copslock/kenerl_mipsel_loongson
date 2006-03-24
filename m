Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 22:30:09 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:18578 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133923AbWCXWaB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2006 22:30:01 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k2OMe6Pl004450;
	Fri, 24 Mar 2006 22:40:06 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k2OMe6Pm004449;
	Fri, 24 Mar 2006 22:40:06 GMT
Date:	Fri, 24 Mar 2006 22:40:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	James E Wilson <wilson@specifix.com>
Cc:	dhunjukrishna@gmail.com, linux-mips@linux-mips.org
Subject: Re: Compilation problem with kernel 2.4.16
Message-ID: <20060324224005.GA4145@linux-mips.org>
References: <20060324082842.68469.qmail@web53506.mail.yahoo.com> <1143236139.13187.55.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143236139.13187.55.camel@aretha.corp.specifix.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 24, 2006 at 01:35:40PM -0800, James E Wilson wrote:

> You can use the specifix toolchain release to build the linux kernel. 
> However, you can't use the sb1-elf binaries.  These are only for
> building embedded applications that run on top of CFE without an OS.  To
> build the linux kernel, you need to grab the sources (which are just FSF
> gcc-3.4.x with some SB-1 support backported), configure them for
> mips-linux (or mips64-linux), and then build and install them.  You can
> then use this compile to build the linux kernel.
> 
> There is a learning curve here if you have never done this before. 
> There is probably a FAQ somewhere that explains how to do this.  I don't
> know offhand where to look for linux kernel building FAQs.  Perhaps
> someone else can point you at one.

There is a lot of information in the wiki http://www.linux-mips.org/ and
I would like to encourage people to contribute to it.  Editing a wiki
page _once_ is more productive than answering the same question again
and again ...  In particular I also want to encourage the mere mortals
to contribute to the wikis.

  Ralf
