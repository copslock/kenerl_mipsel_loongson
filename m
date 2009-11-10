Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2009 17:04:04 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39575 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492799AbZKJQEB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Nov 2009 17:04:01 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAAG3vUe009419;
	Tue, 10 Nov 2009 17:04:00 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAAG3snl009417;
	Tue, 10 Nov 2009 17:03:54 +0100
Date:	Tue, 10 Nov 2009 17:03:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"wilbur.chan" <wilbur512@gmail.com>
Cc:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Could not use printf after init process
Message-ID: <20091110160354.GA7367@linux-mips.org>
References: <e997b7420911100737k3563b9a5l5c6463ba078e9d9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e997b7420911100737k3563b9a5l5c6463ba078e9d9@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 10, 2009 at 11:37:20PM +0800, wilbur.chan wrote:

> When booting , Kernel could not print on console after calling
> run_init_process-->kernel_execve("/sbin/init")
> 
> I guess that printf in busybox  might fail  after the init process began.
> 
> Any sugguestion on how to trace this problem? Thank you in advance.

I assume you meant printk, not printf.

If kernel_execve() is successful the function won't return so code following
that statement won't be executed.

  Ralf
