Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2007 13:40:30 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:60585 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20028948AbXH1Mk2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Aug 2007 13:40:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7SCeSoc031399;
	Tue, 28 Aug 2007 13:40:28 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7SCeSP3031398;
	Tue, 28 Aug 2007 13:40:28 +0100
Date:	Tue, 28 Aug 2007 13:40:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Brian Murphy <brian@murphy.dk>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add back support for LASAT platforms
Message-ID: <20070828124028.GC30614@linux-mips.org>
References: <200708212034.l7LKYGiD011023@potty.localnet> <20070823123231.GB19588@linux-mips.org> <46CDE4D1.3050706@murphy.dk> <twig.1188300294.58543@mail.murphy.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <twig.1188300294.58543@mail.murphy.dk>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 28, 2007 at 11:24:54AM -0000, Brian Murphy wrote:

> I can git-clone the tree but am having some difficulty in seeing / cloning
> the queue head where the changes are. What is the magic git incantation
> that does this?

  $ git clone git://git.linux-mips.org/pub/scm/linux-queue
  $ cd linux-queue
  $ git checkout queue

If you already have a clone of the main linux-mips tree around you can
accelerate the process and reduce disk space consumption by add 
--reference ../patch/to/linux-mips to the first git command.

  Ralf
