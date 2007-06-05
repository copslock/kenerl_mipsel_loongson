Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2007 16:28:40 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:22982 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021620AbXFEP2i (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Jun 2007 16:28:38 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l55FNdFU030384;
	Tue, 5 Jun 2007 16:23:40 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l55FNc3E030383;
	Tue, 5 Jun 2007 16:23:39 +0100
Date:	Tue, 5 Jun 2007 16:23:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Mailing patches
Message-ID: <20070605152338.GA22937@linux-mips.org>
References: <20070604133551.GA24405@linux-mips.org> <4664DB12.80906@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4664DB12.80906@gentoo.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 04, 2007 at 11:40:02PM -0400, Kumba wrote:

> What about just attaching the patches to a message?  Seems like it'll avoid 
> most of the problems Tbird has with them.  I'm just not sure if that 
> hampers importing them into git or not.

There are issues if people have the log message in the attachment as
well.  And of course there is still the prime reason why attachments
are a no-no - most mailers won't quote them so commenting on them is
hard when discussing things.

Git has some limited abilities to handle MIME messages since quite a
while though.  But quilt which is the heart of how I manage the queue
tree doesn't.

   Ralf
