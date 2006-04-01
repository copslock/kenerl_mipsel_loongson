Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Apr 2006 22:14:13 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:8347 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133560AbWDAVOF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 1 Apr 2006 22:14:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k31LJhgQ028706;
	Sat, 1 Apr 2006 22:19:43 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k31LJeI1028704;
	Sat, 1 Apr 2006 22:19:40 +0100
Date:	Sat, 1 Apr 2006 22:19:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Scott Ashcroft <scott.ashcroft@talk21.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Typo in arch/mips/Makefile breaks build on Cobalt
Message-ID: <20060401211940.GA28654@linux-mips.org>
References: <20060401185003.35183.qmail@web86301.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060401185003.35183.qmail@web86301.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 01, 2006 at 07:50:03PM +0100, Scott Ashcroft wrote:

> There appears to be a couple of typos in the clean up
> of the Makefile.
> 
> The cflags lines for NEVADA and R5432 have
> 'cc-options' rather than 'cc-option'.
> Attached patch fixes it up.

I ran into this an hour ago during builds across all platforms, so there
already is a fix in the tree.

Thanks anyway,

  Ralf
