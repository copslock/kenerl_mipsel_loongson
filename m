Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2004 06:21:02 +0000 (GMT)
Received: from p508B767E.dip.t-dialin.net ([IPv6:::ffff:80.139.118.126]:1577
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224902AbUKVGUz>; Mon, 22 Nov 2004 06:20:55 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAM6Isbu025583;
	Mon, 22 Nov 2004 07:18:54 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAM6IsF4025582;
	Mon, 22 Nov 2004 07:18:54 +0100
Date: Mon, 22 Nov 2004 07:18:54 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Improve o32 syscall handling
Message-ID: <20041122061854.GA25433@linux-mips.org>
References: <20041121164557.GQ20986@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121164557.GQ20986@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 21, 2004 at 05:45:57PM +0100, Thiemo Seufer wrote:

> For the 64bit Kernel, it
>  - checks for unaligned user stack

Why bother, the unaligned exception handler should take care of this.

>  - also allows now up to 8 arguments

Quite frankly I'd prefer to see this being handle in userspace.  For o32
it's too late to go for that but for N32 / N64 we still may have a chance.

> -	LONG_L	a2, TI_FLAGS($28)	# current->work
> +	lw	a2, TI_FLAGS($28)	# current->work

Flags is a long variable.

  Ralf
