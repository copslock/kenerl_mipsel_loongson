Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 13:09:30 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:6328 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022600AbXG3MJ2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jul 2007 13:09:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6UC9QcS014252;
	Mon, 30 Jul 2007 13:09:26 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6UC9PLO014251;
	Mon, 30 Jul 2007 13:09:25 +0100
Date:	Mon, 30 Jul 2007 13:09:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Songmao Tian <tiansm@lemote.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Fix name conflict
Message-ID: <20070730120925.GF11436@linux-mips.org>
References: <11857558271466-git-send-email-tiansm@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11857558271466-git-send-email-tiansm@lemote.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 30, 2007 at 08:37:07AM +0800, Songmao Tian wrote:

> error: 'cpu_clock' redeclared as different kind of symbol
> include/linux/sched.h:1356: error: previous declaration of 'cpu_clock' was here

Thanks for the patch but I already applied something virtually identical
on the weekend.

  Ralf
