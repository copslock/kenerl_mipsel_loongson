Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 12:15:50 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34204 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S28577436AbYGNLPk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2008 12:15:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6EBFipk024466;
	Mon, 14 Jul 2008 12:15:45 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6EBFi6m024465;
	Mon, 14 Jul 2008 12:15:44 +0100
Date:	Mon, 14 Jul 2008 12:15:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] txx9: cleanup and fix some sparse warnings
Message-ID: <20080714111544.GC10379@linux-mips.org>
References: <20080714.001504.18284902.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080714.001504.18284902.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 14, 2008 at 12:15:04AM +0900, Atsushi Nemoto wrote:

> * Do not return void value
> * Make some functions static
> * Do not include unnecessary bootinfo.h

Thanks, queued for 2.6.27.

  Ralf
