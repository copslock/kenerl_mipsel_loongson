Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Dec 2007 13:09:28 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:65500 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20035339AbXL0NJ0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Dec 2007 13:09:26 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBRD8QFa015060;
	Thu, 27 Dec 2007 14:08:26 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBRD8O9V015059;
	Thu, 27 Dec 2007 14:08:24 +0100
Date:	Thu, 27 Dec 2007 14:08:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: fix modpost warning
Message-ID: <20071227130824.GA14037@linux-mips.org>
References: <200712252100.47365.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200712252100.47365.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 25, 2007 at 09:00:45PM +0300, Sergei Shtylyov wrote:

> WARNING: vmlinux.o(.text+0x1ca608): Section mismatch: reference to .init.text:
> add_wired_entry (between 'config_access' and 'config_read')
> 
> by refactoring the code calling add_wired_entry() from config_access() to
> a separate function which is called from aau1x_pci_setup(). While at it:
> 
> - make some unnecassarily global variables 'static';
> 
> - fix the letter case, whitespace, etc. in the comments...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Applied.  Thanks,

  Ralf
