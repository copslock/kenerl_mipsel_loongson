Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 09:25:48 +0100 (BST)
Received: from atlanta.zankel.net ([69.61.78.146]:27408 "EHLO
	atlanta.zankel.net") by ftp.linux-mips.org with ESMTP
	id S20023130AbYFXIZl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jun 2008 09:25:41 +0100
Message-ID: <4860AF80.5060809@zankel.net>
Date:	Tue, 24 Jun 2008 01:25:36 -0700
From:	Chris Zankel <chris@zankel.net>
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
MIME-Version: 1.0
To:	Adrian Bunk <bunk@kernel.org>
CC:	Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
	rmk@arm.linux.org.uk, cooloney@kernel.org, dev-etrax@axis.com,
	dhowells@redhat.com, gerg@uclinux.org,
	yasutake.koichi@jp.panasonic.com, linux-parisc@vger.kernel.org,
	paulus@samba.org, linuxppc-dev@ozlabs.org,
	linux-sh@vger.kernel.org, linux-mips@linux-mips.org,
	ysato@users.sourceforge.jp,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
In-Reply-To: <20080623174809.GE4756@cs181140183.pp.htv.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <chris@zankel.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@zankel.net
Precedence: bulk
X-list: linux-mips

Adrian Bunk wrote:
> This patch contains the following cleanups for the asm/ptrace.h 
> userspace headers:
> - xtensa: cosmetical change to remove empty
>             #ifndef __ASSEMBLY__ #else #endif
>           from the userspace headers
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

The Xtensa part also looks ok.

Acked-by: Chris Zankel <chris@zankel.net>


Regards,
-Chris
