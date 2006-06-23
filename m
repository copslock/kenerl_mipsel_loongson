Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 12:16:27 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:17616 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133563AbWFWLQM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2006 12:16:12 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5NBGBiG007955;
	Fri, 23 Jun 2006 12:16:11 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5NBGBxM007954;
	Fri, 23 Jun 2006 12:16:11 +0100
Date:	Fri, 23 Jun 2006 12:16:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Domen Puncer <domen.puncer@ultra.si>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch 4/8] au1xxx: dbdma, no sleeping under spin_lock
Message-ID: <20060623111611.GN5896@linux-mips.org>
References: <20060623095703.GA30980@domen.ultra.si> <20060623095950.GD31017@domen.ultra.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623095950.GD31017@domen.ultra.si>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 23, 2006 at 11:59:50AM +0200, Domen Puncer wrote:

> kmalloc under spin_lock can't sleep.

Applied.

  Ralf
