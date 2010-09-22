Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Sep 2010 18:44:58 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1146 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491112Ab0IVQoy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Sep 2010 18:44:54 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c9a32a40000>; Wed, 22 Sep 2010 09:45:24 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 22 Sep 2010 09:44:51 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 22 Sep 2010 09:44:51 -0700
Message-ID: <4C9A327E.6030109@caviumnetworks.com>
Date:   Wed, 22 Sep 2010 09:44:46 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     wuzhangjin@gmail.com
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Make EARLY_PRINTK selectable for !EMBEDDED
References: <1285135150-14772-1-git-send-email-wuzhangjin@gmail.com>
In-Reply-To: <1285135150-14772-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2010 16:44:51.0697 (UTC) FILETIME=[7A22DE10:01CB5A75]
X-archive-position: 27794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17361

On 09/21/2010 10:59 PM, wuzhangjin@gmail.com wrote:
> From: Wu Zhangjin<wuzhangjin@gmail.com>
>
> When EMBEDDED is disabled, the EARLY_PRINTK option will be hiden and we
> have no way to disable it.
>
> For EARLY_PRINTK is not necessary for !EMBEDDED, we should make it
> selectable and only enable it by default for EMBEDDED.
>
> Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
> ---
>   arch/mips/Kconfig.debug |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
> index 43dc279..77eba81 100644
> --- a/arch/mips/Kconfig.debug
> +++ b/arch/mips/Kconfig.debug
> @@ -7,9 +7,9 @@ config TRACE_IRQFLAGS_SUPPORT
>   source "lib/Kconfig.debug"
>
>   config EARLY_PRINTK
> -	bool "Early printk" if EMBEDDED
> +	bool "Early printk"
>   	depends on SYS_HAS_EARLY_PRINTK
> -	default y
> +	default y if EMBEDDED

I hate to be a pedant, but how about if we don't make it depend on 
EMBEDDED at all?  I.E. just: 'default y'

If the system has SYS_HAS_EARLY_PRINTK, the overhead of enabling 
EARLY_PRINTK is low, although it may slow down booting.  But it is 
really not at all related to EMBEDDED.

David Daney


>   	help
>   	  This option enables special console drivers which allow the kernel
>   	  to print messages very early in the bootup process.
