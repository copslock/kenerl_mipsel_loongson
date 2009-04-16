Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Apr 2009 17:03:32 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:53272 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20024866AbZDPQDZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Apr 2009 17:03:25 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49e756b00001>; Thu, 16 Apr 2009 12:02:56 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 16 Apr 2009 09:02:01 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 16 Apr 2009 09:02:00 -0700
Message-ID: <49E75678.7050909@caviumnetworks.com>
Date:	Thu, 16 Apr 2009 09:02:00 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Include linux/errno.h from arch/mips/include/asm/compat.h
References: <1239388895-27305-1-git-send-email-ddaney@caviumnetworks.com>	<20090410191611.GB23582@linux-mips.org> <20090411.233150.25909696.anemo@mba.ocn.ne.jp>
In-Reply-To: <20090411.233150.25909696.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Apr 2009 16:02:00.0885 (UTC) FILETIME=[AD5B1650:01C9BEAC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 10 Apr 2009 12:16:11 -0700, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Fri, Apr 10, 2009 at 11:41:35AM -0700, David Daney wrote:
>>
>>> The recent change that added #include <linux/seccomp.h> breaks
>>> (because EINVAL is not defined) when building
>>> arch/mips/kernel/asm-offsets.s if CONFIG_SECCOMP is not defined.
>>> Including errno.h fixes the problem.
>> NAK, <linux/seccomp.h> should include <linux/errno.h>.
> 
> Then how about this?
> 
> ------------------------------------------------------
> Subject: [PATCH] Do not include seccomp.h from compat.h
> From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> The compat.h does not need seccomp.h since TIF_32BIT was moved to
> thread_info.h
> 
> This fixes a build error of 64-bit kernel without CONFIG_SECCOMP.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Signed-off-by: David Daney <ddaney@caviumnetworks.com>

> ---
>  arch/mips/include/asm/compat.h |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
> index 6c5b409..f58aed3 100644
> --- a/arch/mips/include/asm/compat.h
> +++ b/arch/mips/include/asm/compat.h
> @@ -3,7 +3,6 @@
>  /*
>   * Architecture specific compatibility types
>   */
> -#include <linux/seccomp.h>
>  #include <linux/thread_info.h>
>  #include <linux/types.h>
>  #include <asm/page.h>
> 
> 
