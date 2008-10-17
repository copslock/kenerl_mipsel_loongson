Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2008 16:05:44 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:7141 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21721296AbYJQPFk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Oct 2008 16:05:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9HF5T0q016714;
	Fri, 17 Oct 2008 16:05:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9HF5TJN016713;
	Fri, 17 Oct 2008 16:05:29 +0100
Date:	Fri, 17 Oct 2008 16:05:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Zhaolei <zhaolei@cn.fujitsu.com>
Cc:	linux-mips@linux-mips.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix debugfs_create_*'s error checking method for
	mips/math-emu/
Message-ID: <20081017150529.GB15932@linux-mips.org>
References: <48F8731E.40100@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48F8731E.40100@cn.fujitsu.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 17, 2008 at 07:12:30PM +0800, Zhaolei wrote:

> debugfs_create_*() returns NULL if an error occurs, returns -ENODEV
> when debugfs is not enabled in the kernel.

Thanks, applied.

  Ralf
