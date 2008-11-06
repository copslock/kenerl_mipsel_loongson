Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2008 23:34:15 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:26044 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23303879AbYKFXeN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Nov 2008 23:34:13 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 6D1413ECC; Thu,  6 Nov 2008 15:34:10 -0800 (PST)
Message-ID: <49137EEE.5040004@ru.mvista.com>
Date:	Fri, 07 Nov 2008 02:34:06 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 18/29] MIPS: Add SMP_ICACHE_FLUSH for the Cavium CPU family.
References: <491358F5.7040002@caviumnetworks.com> <1226004875-27654-18-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1226004875-27654-18-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Daney wrote:

> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
> Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/include/asm/smp.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
> index 0ff5b52..e6f419f 100644
> --- a/arch/mips/include/asm/smp.h
> +++ b/arch/mips/include/asm/smp.h
> @@ -37,6 +37,9 @@ extern int __cpu_logical_map[NR_CPUS];
>  
>  #define SMP_RESCHEDULE_YOURSELF	0x1	/* XXX braindead */
>  #define SMP_CALL_FUNCTION	0x2
> +/* Octeon - Tell another core to flush its icache */
> +#define SMP_ICACHE_FLUSH	0x4
> +
>   

   Sigh, again new macro without users...

WBR, Sergei
