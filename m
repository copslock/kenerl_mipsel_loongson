Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2008 23:21:50 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:64665 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21420077AbYJMWVs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Oct 2008 23:21:48 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9DMLkPH018662;
	Mon, 13 Oct 2008 23:21:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9DMLkPZ018660;
	Mon, 13 Oct 2008 23:21:46 +0100
Date:	Mon, 13 Oct 2008 23:21:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Johannes Dickgreber <tanzy@gmx.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] show_cpuinfo prints the name of the calling CPU,
	which i think is wrong.
Message-ID: <20081013222146.GD8145@linux-mips.org>
References: <1223919381-24521-1-git-send-email-tanzy@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1223919381-24521-1-git-send-email-tanzy@gmx.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 13, 2008 at 07:36:21PM +0200, Johannes Dickgreber wrote:

> Cc: linux-mips@linux-mips.org
> Subject: [PATCH 2/2] show_cpuinfo prints the name of the calling CPU, which i
> 	think is wrong.

Patch is correct and so I applied it.  Not a big issue though.  There is
only one system supported currently that supports a mix of different
processor types (IP27) and those are very similar so it doesn't cause
pain.

  Ralf
