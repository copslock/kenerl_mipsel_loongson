Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2007 14:24:33 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:2025 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022686AbXGWNYb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jul 2007 14:24:31 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6NDOUZS001876;
	Mon, 23 Jul 2007 14:24:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6NDOUck001875;
	Mon, 23 Jul 2007 14:24:30 +0100
Date:	Mon, 23 Jul 2007 14:24:30 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Rientjes <rientjes@google.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch] mips: replace __attribute_used__ with __used
Message-ID: <20070723132430.GE31040@linux-mips.org>
References: <alpine.DEB.0.99.0707220101130.4908@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.0.99.0707220101130.4908@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jul 22, 2007 at 01:01:39AM -0700, David Rientjes wrote:

> Replaces the deprecated __attribute_used__ with __used.  Also makes some
> style adjustments to abide by the kernel coding conventions.

Thanks, applied.

  Ralf
