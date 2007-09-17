Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Sep 2007 11:17:12 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:16275 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022034AbXIQKRK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Sep 2007 11:17:10 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8HAH8xe030536;
	Mon, 17 Sep 2007 11:17:08 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8HAH87F030535;
	Mon, 17 Sep 2007 11:17:08 +0100
Date:	Mon, 17 Sep 2007 11:17:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: beautify vmlinux.lds
Message-ID: <20070917101708.GC16523@linux-mips.org>
References: <20070915213553.GA15463@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070915213553.GA15463@uranus.ravnborg.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 15, 2007 at 11:35:53PM +0200, Sam Ravnborg wrote:

> Introduce a consistent style for vmlinux.lds.
> This style will be consitent with all other arch's - soon.
> 
> In addition:
> - Moved a few labels inside brackets for the sections they specify
>   to prevent that linker alignmnet made them point before the section start

Prettier indeed.  Queued for 2.6.24.  Thanks,

  Ralf
