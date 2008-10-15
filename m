Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2008 22:36:47 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:6532 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21578596AbYJOSAo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 15 Oct 2008 19:00:44 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9FEc55Q019014;
	Wed, 15 Oct 2008 15:38:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9FEc4X7019012;
	Wed, 15 Oct 2008 15:38:04 +0100
Date:	Wed, 15 Oct 2008 15:38:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix include paths in malta-amon.c
Message-ID: <20081015143804.GA18506@linux-mips.org>
References: <48D52FF4.2000905@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48D52FF4.2000905@avtrex.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 20, 2008 at 10:16:36AM -0700, David Daney wrote:

> On linux-queue, malta doesn't build after the include file relocation.
> This should fix it.
> 
> There some occurrences of 'asm-mips' in the comments of quite a few
> files, but this is the only place I found it in any code.
> 
> Signed-off-by: David Daney <ddaney@avtrex.com>

Thanks, applied.

  Ralf
