Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 18:07:41 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:910 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030702AbXLESHj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Dec 2007 18:07:39 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB5I6EHq010705;
	Wed, 5 Dec 2007 18:06:39 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB5I6Dkp010704;
	Wed, 5 Dec 2007 18:06:13 GMT
Date:	Wed, 5 Dec 2007 18:06:13 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] Alchemy: replace ffs() with __ffs()
Message-ID: <20071205180613.GA10697@linux-mips.org>
References: <200712051908.24027.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200712051908.24027.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 05, 2007 at 07:08:24PM +0300, Sergei Shtylyov wrote:

> Fix havoc wrought by commit 56f621c7f6f735311eed3f36858b402013023c18 --
> au_ffs() and ffs() are equivalent, that patch should have just replaced
> one with another.  Now replace ffs() with __ffs() which returns an
> unbiased bit number.

Thanks, applied.

  Ralf
