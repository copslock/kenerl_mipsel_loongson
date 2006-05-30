Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 May 2006 14:40:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:4313 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133462AbWE3Mko (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 May 2006 14:40:44 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4UCeikf018334;
	Tue, 30 May 2006 13:40:44 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4UCehms018333;
	Tue, 30 May 2006 13:40:43 +0100
Date:	Tue, 30 May 2006 13:40:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: SIGSTKFLT in mips
Message-ID: <20060530124043.GB3185@linux-mips.org>
References: <20060530.181218.74754108.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530.181218.74754108.kaminaga@sm.sony.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 30, 2006 at 06:12:18PM +0900, Hiroki Kaminaga wrote:

> I'm using linux 2.6.16.11, and want to use SIGSTKFLT.
> 
> This signal is defined in most other architectures (in
> include/asm-xxx/signal.h) but not in mips.

SIGSTKFLT is used for stack faults on coprocessors.  That condition
simply doesn't exist on MIPS thus no SIGSTKFLT.

  Ralf
