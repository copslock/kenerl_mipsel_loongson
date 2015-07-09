Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 12:03:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46307 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009976AbbGIKDlzLvth (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jul 2015 12:03:41 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t69A3fii032155;
        Thu, 9 Jul 2015 12:03:41 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t69A3e0s032154;
        Thu, 9 Jul 2015 12:03:40 +0200
Date:   Thu, 9 Jul 2015 12:03:40 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 02/19] MIPS: Add cases for CPU_I6400
Message-ID: <20150709100340.GB31002@linux-mips.org>
References: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
 <1436434853-30001-3-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1436434853-30001-3-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Jul 09, 2015 at 10:40:36AM +0100, Markos Chandras wrote:

> index d41e8e284825..abee2bfd10dc 100644
> --- a/arch/mips/include/asm/cpu-type.h
> +++ b/arch/mips/include/asm/cpu-type.h
> @@ -77,6 +77,10 @@ static inline int __pure __get_cpu_type(const int cpu_type)
>  	 */
>  #endif
>  
> +#ifdef CONFIG_SYS_HAS_CPU_MIPS64_R6
> +	case CPU_I6400:
> +#endif
> +

To ensure best possible optimization you may want to introduce a new
CPU type CPU_I6400 in Kconfig then change above code segment to

#ifdef CONFIG_SYS_HAS_CPU_I6400
	case CPU_I6400:
#endif

__get_cpu_type is ideally meant to get folded to a constant on any
particular platform which then will allow the compiler to discard lots
of other code.

Of course Malta being as hetergenous as it is that's not goint help
with Malta but it will make a noticable difference for SOCs which usually
come only with a single supported CPU type.

  Ralf
