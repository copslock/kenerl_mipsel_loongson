Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2009 11:03:05 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:51554 "EHLO
	roarinelk.homelinux.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023983AbZE0KC5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2009 11:02:57 +0100
Received: (qmail 11212 invoked by uid 1000); 27 May 2009 12:01:56 +0200
Date:	Wed, 27 May 2009 12:01:56 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: Re: [loongson-PATCH-v2 19/23] Loongson2F cpufreq support
Message-ID: <20090527100156.GA11145@roarinelk.homelinux.net>
References: <cover.1243362545.git.wuzj@lemote.com> <1a75bd9d59ff0c92250ddb7238509a7a4b154505.1243362545.git.wuzj@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a75bd9d59ff0c92250ddb7238509a7a4b154505.1243362545.git.wuzj@lemote.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, May 27, 2009 at 03:08:55AM +0800, wuzhangjin@gmail.com wrote:
> From: Wu Zhangjin <wuzj@lemote.com>
> --- /dev/null
> +++ b/arch/mips/include/asm/clock.h
> @@ -0,0 +1,64 @@
> +#ifndef __ASM_MIPS_CLOCK_H
> +#define __ASM_MIPS_CLOCK_H

[...]

> +
> +#endif				/* __ASM_MIPS_CLOCK_H */


Please move this to your mach-loongson subdirectory since it is
currently specific to lemote cpus.

(I have a similar clock framework for Alchemy, also based on the sh port,
 but with a few extensions specific to the nature of the alchemy clock
 generators.  Maybe we could merge some aspects in the future).

	Manuel Lauss
