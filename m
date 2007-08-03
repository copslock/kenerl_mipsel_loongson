Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2007 13:40:27 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:40941 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023877AbXHCMkZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Aug 2007 13:40:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l73CeNV8018955;
	Fri, 3 Aug 2007 13:40:24 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l73CeNhs018954;
	Fri, 3 Aug 2007 13:40:23 +0100
Date:	Fri, 3 Aug 2007 13:40:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mohamed Bamakhrama <bamakhrama@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Context switches & interrupts affecting cache?
Message-ID: <20070803124023.GA16519@linux-mips.org>
References: <40378e40708030359h3729e4b1m5390c258b29d6ae0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40378e40708030359h3729e4b1m5390c258b29d6ae0@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 03, 2007 at 12:59:41PM +0200, Mohamed Bamakhrama wrote:

> Hi all,
> I have one question regarding context switches between user and kernel
> modes and interrupts. Do they invalidate the I-cache or D-cache?

Never on MIPS.

I call an architecture that would require a cacheflush for such a
context switch totally broken and yes, they exist - but nothing from
the MIPS family.

  Ralf
