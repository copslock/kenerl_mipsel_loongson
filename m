Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 12:13:30 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:10392 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20044122AbXJSLN2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 12:13:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9JBCTq6015846;
	Fri, 19 Oct 2007 12:12:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9JBCSNF015845;
	Fri, 19 Oct 2007 12:12:28 +0100
Date:	Fri, 19 Oct 2007 12:12:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.24-rc0] au1xmmc: trivial buildfix
Message-ID: <20071019111228.GA30767@linux-mips.org>
References: <20071018190302.GA17906@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071018190302.GA17906@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 18, 2007 at 09:03:02PM +0200, Manuel Lauss wrote:

> Fix a trivial error in au1xmmc. 

The MMC maintainer Pierre Ossman already has an identical patch.

Please if you send fixes to drivers or other non-arch code, send them to
the respective maintainers and mailing lists.  See MAINTAINERS file for
addresses.  But by all means, keep cc'ing linux-mips.

> Not run-tested since there are some rather funky IRQ issues
> with this kernel...

No surprise, things have been _wild_.

  Ralf
