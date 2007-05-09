Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 May 2007 14:54:47 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:64739 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023494AbXEINyp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 May 2007 14:54:45 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l49DsfHr026169;
	Wed, 9 May 2007 14:54:41 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l49Dse0K026168;
	Wed, 9 May 2007 14:54:40 +0100
Date:	Wed, 9 May 2007 14:54:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] time: replace board_time_init() by plat_clk_setup()
Message-ID: <20070509135440.GE25192@linux-mips.org>
References: <11782930063123-git-send-email-fbuihuu@gmail.com> <20070506.010313.41199101.anemo@mba.ocn.ne.jp> <cda58cb80705070150u75165c47n252a664fc92646f3@mail.gmail.com> <20070507.182837.126143175.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070507.182837.126143175.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 07, 2007 at 06:28:37PM +0900, Atsushi Nemoto wrote:

> Both boards have been listed on
> 
> http://www.linux-mips.org/wiki/Category:Deprecated
> 
> since Jun 2006.

Mostly because when I removed them from feature-removal-schedule.txt I
left them listed.  Oh well, now they're gone and as usual if somebody
cares (care as in sends patches) I can resurrect them.

  Ralf
