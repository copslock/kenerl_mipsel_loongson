Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Sep 2004 01:22:43 +0100 (BST)
Received: from p508B659A.dip.t-dialin.net ([IPv6:::ffff:80.139.101.154]:20790
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225236AbUINAWj>; Tue, 14 Sep 2004 01:22:39 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i8E0Mbcw021806;
	Tue, 14 Sep 2004 02:22:37 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i8E0MbtK021805;
	Tue, 14 Sep 2004 02:22:37 +0200
Date: Tue, 14 Sep 2004 02:22:37 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Peter Buckingham <peter@pantasys.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] fix mips atomic_lock declaration
Message-ID: <20040914002237.GA21739@linux-mips.org>
References: <41462025.9070607@pantasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41462025.9070607@pantasys.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 13, 2004 at 03:33:09PM -0700, Peter Buckingham wrote:

> diff -u -r1.36 atomic.h
> --- include/asm-mips/atomic.h	19 Aug 2004 09:54:23 -0000	1.36
> +++ include/asm-mips/atomic.h	13 Sep 2004 21:51:56 -0000
> @@ -26,7 +26,7 @@
>  #include <asm/cpu-features.h>
>  #include <asm/war.h>
>  
> -extern spinlock_t atomic_lock;
> +static spinlock_t atomic_lock;
>  
>  typedef struct { volatile int counter; } atomic_t;


No.  atomic_lock is intentionally undefined, so this patch seems very
broken.

  Ralf
