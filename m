Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 08:37:10 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:3054 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20022068AbYFLHhI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 08:37:08 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5C7amun016531;
	Thu, 12 Jun 2008 08:36:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5C7alfZ016523;
	Thu, 12 Jun 2008 08:36:47 +0100
Date:	Thu, 12 Jun 2008 08:36:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/5] [MIPS] remove unused function alloc_legacy_irqno()
Message-ID: <20080612073647.GH30400@linux-mips.org>
References: <12124843631664-git-send-email-dmitri.vorobiev@movial.fi> <12124843634070-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12124843634070-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 03, 2008 at 12:12:42PM +0300, Dmitri Vorobiev wrote:

> The function alloc_legacy_irqno() is not used any more, and this
> patch removes it.
> 
> Inspired by a namespacecheck warning.

NAK.  While currently unused alloc_legacy_irqno() is needed for systems
such as SGI IP27 which use dynamic interrupt number allocation and may
feature EISA slots.  So there eventually will be a caller.

  Ralf
