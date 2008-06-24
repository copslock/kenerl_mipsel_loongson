Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 05:11:43 +0100 (BST)
Received: from mta23.gyao.ne.jp ([125.63.38.249]:22177 "EHLO mx.gate01.com")
	by ftp.linux-mips.org with ESMTP id S20022131AbYFXELg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2008 05:11:36 +0100
Received: from [124.34.33.190] (helo=master.linux-sh.org)
	by smtp31.isp.us-com.jp with esmtp (Mail 4.41)
	id 1KAzs5-0004TR-UH; Tue, 24 Jun 2008 13:11:09 +0900
Received: from localhost (unknown [127.0.0.1])
	by master.linux-sh.org (Postfix) with ESMTP id D6CCC63754;
	Tue, 24 Jun 2008 04:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
	by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sFzR7qUSbnqL; Tue, 24 Jun 2008 13:08:44 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
	id 6DE1563758; Tue, 24 Jun 2008 13:08:44 +0900 (JST)
Date:	Tue, 24 Jun 2008 13:08:44 +0900
From:	Paul Mundt <lethal@linux-sh.org>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
	rmk@arm.linux.org.uk, cooloney@kernel.org, dev-etrax@axis.com,
	dhowells@redhat.com, gerg@uclinux.org,
	yasutake.koichi@jp.panasonic.com, linux-parisc@vger.kernel.org,
	paulus@samba.org, linuxppc-dev@ozlabs.org,
	linux-sh@vger.kernel.org, chris@zankel.net,
	linux-mips@linux-mips.org, ysato@users.sourceforge.jp,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
Message-ID: <20080624040844.GE22526@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Adrian Bunk <bunk@kernel.org>, Roland McGrath <roland@redhat.com>,
	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
	cooloney@kernel.org, dev-etrax@axis.com, dhowells@redhat.com,
	gerg@uclinux.org, yasutake.koichi@jp.panasonic.com,
	linux-parisc@vger.kernel.org, paulus@samba.org,
	linuxppc-dev@ozlabs.org, linux-sh@vger.kernel.org, chris@zankel.net,
	linux-mips@linux-mips.org, ysato@users.sourceforge.jp,
	Andrew Morton <akpm@linux-foundation.org>
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080623174809.GE4756@cs181140183.pp.htv.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <lethal@linux-sh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 23, 2008 at 08:48:09PM +0300, Adrian Bunk wrote:
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

Yes, that's fine. We've generally avoided relying entirely on the gcc
builtin definitions due to the rampant stupidity surrounding
__SH4_NOFPU__, but it is true that __SH5__ is always defined at least.

Acked-by: Paul Mundt <lethal@linux-sh.org>
