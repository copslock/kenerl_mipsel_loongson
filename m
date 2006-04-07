Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 17:26:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:654 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133569AbWDGQ0n (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2006 17:26:43 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k37GcAeH017043;
	Fri, 7 Apr 2006 17:38:10 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k37Gc91q017042;
	Fri, 7 Apr 2006 17:38:09 +0100
Date:	Fri, 7 Apr 2006 17:38:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] nullify __ide_flush_{prologue,epilogue} on UP
Message-ID: <20060407163809.GA10564@linux-mips.org>
References: <20060408.012511.75185496.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060408.012511.75185496.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 08, 2006 at 01:25:11AM +0900, Atsushi Nemoto wrote:

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Looks good, applied.

Actually I have my objections wrt to shared caches such as with SMP on
the 34K but that's another project.

  Ralf
