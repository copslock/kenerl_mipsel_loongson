Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 09:17:37 +0100 (BST)
Received: from miranda.se.axis.com ([193.13.178.8]:28294 "EHLO
	miranda.se.axis.com") by ftp.linux-mips.org with ESMTP
	id S20022455AbYFXIRa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jun 2008 09:17:30 +0100
Received: from stork.se.axis.com (stork.se.axis.com [10.84.39.1])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m5O8Fi0l000722;
	Tue, 24 Jun 2008 10:15:44 +0200
Received: (from jespern@localhost)
	by stork.se.axis.com (8.13.8/8.13.8/Submit) id m5O8Fd67026514;
	Tue, 24 Jun 2008 10:15:39 +0200
Date:	Tue, 24 Jun 2008 10:15:39 +0200
From:	Jesper Nilsson <jesper.nilsson@axis.com>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Roland McGrath <roland@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>,
	"cooloney@kernel.org" <cooloney@kernel.org>,
	dev-etrax <dev-etrax@axis.com>,
	"dhowells@redhat.com" <dhowells@redhat.com>,
	"gerg@uclinux.org" <gerg@uclinux.org>,
	"yasutake.koichi@jp.panasonic.com" <yasutake.koichi@jp.panasonic.com>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"paulus@samba.org" <paulus@samba.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"chris@zankel.net" <chris@zankel.net>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
Message-ID: <20080624081539.GE5064@axis.com>
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080623174809.GE4756@cs181140183.pp.htv.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <jespern@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesper.nilsson@axis.com
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, Jun 23, 2008 at 07:48:09PM +0200, Adrian Bunk wrote:
> This patch contains the following cleanups for the asm/ptrace.h
> userspace headers:
> - include/asm-generic/Kbuild.asm already lists ptrace.h, remove
>   the superfluous listings in the Kbuild files of the following
>   architectures:
>   - cris
>   - frv
>   - powerpc
>   - x86
> - don't expose function prototypes and macros to userspace:
>   - arm
>   - blackfin
>   - cris
>   - mn10300
>   - parisc
> - remove #ifdef CONFIG_'s around #define's:
>   - blackfin
>   - m68knommu
> - sh: AFAIK __SH5__ should work in both kernel and userspace,
>       no need to leak CONFIG_SUPERH64 to userspace
> - xtensa: cosmetical change to remove empty
>             #ifndef __ASSEMBLY__ #else #endif
>           from the userspace headers
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

The CRIS parts look ok.

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
