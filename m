Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2008 20:29:41 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:666 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S28647366AbYIWT3g (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2008 20:29:36 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8NJTXKT007619;
	Tue, 23 Sep 2008 21:29:33 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8NJTWvN007617;
	Tue, 23 Sep 2008 21:29:32 +0200
Date:	Tue, 23 Sep 2008 21:29:32 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bruno Randolf <br1@einfach.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] au1000: fix gpio direction
Message-ID: <20080923192932.GA5309@linux-mips.org>
References: <20080923174828.8694.12510.stgit@void>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080923174828.8694.12510.stgit@void>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 23, 2008 at 07:48:36PM +0200, Bruno Randolf wrote:

> when setting the direction of one GPIO pin we have to keep the state of the
> other pins, hence use binary OR. also gpio_direction_output() wants to set an
> initial value, so add that too.

Thanks, applied.

  Ralf
