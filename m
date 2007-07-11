Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 16:57:47 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:57224 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021596AbXGKP5p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 16:57:45 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6BFgoko026604;
	Wed, 11 Jul 2007 16:42:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6BFgoDj026603;
	Wed, 11 Jul 2007 16:42:50 +0100
Date:	Wed, 11 Jul 2007 16:42:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mohamed Bamakhrama <bamakhrama@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Porting SMP kernel into a dual-core MIPS architecture
Message-ID: <20070711154250.GA25553@linux-mips.org>
References: <40378e40707110807n2cd32c68tdb8604c5d39e72a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40378e40707110807n2cd32c68tdb8604c5d39e72a6@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 11, 2007 at 05:07:19PM +0200, Mohamed Bamakhrama wrote:

> Is there any guidelines/tutorial for porting the SMP kernel into a
> dual core new architecture based on MIPS32?
> AFAIK, in the x86 world we have Intel MPS 1.4 standard. I wonder if
> there exists a similar thing for MIPS. In other words, what are the
> minimum requirements needed to port the SMP kernel into such an
> architecture?

The MIPS Architecture definition defines the behaviour of the processor
in great detail.  It doesn't define the system level or firmware.  I
suggest you download the architecture manual from www.mips.com and if
that leaves any questions open, post again.

  Ralf
