Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 11:24:47 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:49102 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S20038741AbYGNKYp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2008 11:24:45 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6EAOor3006320;
	Mon, 14 Jul 2008 11:24:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6EAOlU9006319;
	Mon, 14 Jul 2008 11:24:48 +0100
Date:	Mon, 14 Jul 2008 11:24:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH v2] IP22: Add platform device for Indy volume buttons
Message-ID: <20080714102447.GB32633@linux-mips.org>
References: <20080711210303.8377DC2EC0@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080711210303.8377DC2EC0@solo.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 11, 2008 at 11:03:03PM +0200, Thomas Bogendoerfer wrote:

> Create platform device for Indy volume buttons and remove button
> handling from ip22-reset.c
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks, queued for 2.6.27.

  Ralf
