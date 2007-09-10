Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2007 13:28:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:33453 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021669AbXIJM2q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Sep 2007 13:28:46 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8ACShCG010708;
	Mon, 10 Sep 2007 13:28:43 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8ACScEK010707;
	Mon, 10 Sep 2007 13:28:38 +0100
Date:	Mon, 10 Sep 2007 13:28:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jiri Slaby <jirislaby@gmail.com>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Adrian Bunk <bunk@kernel.org>,
	rth@twiddle.net, hskinnemoen@atmel.com,
	uclinux-dist-devel@blackfin.uclinux.org, dev-etrax@axis.com,
	dhowells@redhat.com, discuss@x86-64.org,
	linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
	parisc-linux@parisc-linux.org, sparclinux@vger.kernel.org,
	chris@zankel.net
Subject: Re: [PATCH 2/2] forbid asm/bitops.h direct inclusion
Message-ID: <20070910122838.GA10143@linux-mips.org>
References: <30483262301654323266@pripojeni.net> <276116173913632310@pripojeni.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <276116173913632310@pripojeni.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 08, 2007 at 09:00:48PM +0100, Jiri Slaby wrote:

> forbid asm/bitops.h direct inclusion
> 
> Because of compile errors that may occur after bit changes if asm/bitops.h is
> included directly without e.g. linux/kernel.h which includes linux/bitops.h, forbid
> direct inclusion of asm/bitops.h. Thanks to Adrian Bunk.

This is the kind of thing that checkpatch.pl is already checking for and
I like that idea much more than adding thousands of checks over many of
the header files under asm.

  Ralf
