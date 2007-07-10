Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2007 18:26:31 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:51359 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021756AbXGJR03 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jul 2007 18:26:29 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6AHFpKB011105;
	Tue, 10 Jul 2007 18:15:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6AHFoWo011104;
	Tue, 10 Jul 2007 18:15:50 +0100
Date:	Tue, 10 Jul 2007 18:15:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	pwatkins@sicortex.com
Cc:	linux-mips@linux-mips.org, From:
Subject: Re: [PATCH] [MIPS] Fix resume for 64K page size
Message-ID: <20070710171550.GA10909@linux-mips.org>
References: <11840880513393-git-send-email-pwatkins@sicortex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11840880513393-git-send-email-pwatkins@sicortex.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 10, 2007 at 01:20:51PM -0400, pwatkins@sicortex.com wrote:

> This fixes a bug when running 64K page size on r4k machines. 

Thanks, applied.

  Ralf
