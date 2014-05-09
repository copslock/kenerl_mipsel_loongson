Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2014 23:22:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:65026 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6854786AbaEIVWXUm0zy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 May 2014 23:22:23 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F2318C8C523C5;
        Fri,  9 May 2014 22:22:12 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 9 May 2014 22:22:16 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 9 May
 2014 22:22:16 +0100
Message-ID: <536D4707.5090207@imgtec.com>
Date:   Fri, 9 May 2014 22:22:15 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 06/11] kvm tools, mips: Enable build of mips support
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1399391491-5021-7-git-send-email-andreas.herrmann@caviumnetworks.com>
In-Reply-To: <1399391491-5021-7-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi Andreas,

On 06/05/14 16:51, Andreas Herrmann wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> ---
>  tools/kvm/Makefile |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/kvm/Makefile b/tools/kvm/Makefile
> index b872651..91286ad 100644
> --- a/tools/kvm/Makefile
> +++ b/tools/kvm/Makefile
> @@ -105,7 +105,7 @@ OBJS	+= virtio/mmio.o
>  
>  # Translate uname -m into ARCH string
>  ARCH ?= $(shell uname -m | sed -e s/i.86/i386/ -e s/ppc.*/powerpc/ \
> -	  -e s/armv7.*/arm/ -e s/aarch64.*/arm64/)
> +	  -e s/armv7.*/arm/ -e s/aarch64.*/arm64/ -e s/mips64/mips/)
>  
>  ifeq ($(ARCH),i386)
>  	ARCH         := x86
> @@ -184,6 +184,15 @@ ifeq ($(ARCH), arm64)
>  	ARCH_WANT_LIBFDT := y
>  endif
>  
> +ifeq ($(ARCH),mips)
> +	DEFINES		+= -DCONFIG_MIPS
> +	ARCH_INCLUDE	:= mips/include
> +	CFLAGS		+= -I../../arch/mips/include/asm/mach-cavium-octeon
> +	CFLAGS		+= -I../../arch/mips/include/asm/mach-generic

I can't see any obvious includes from these two directories in the
previous patch. Are there any?

> +	OBJS		+= mips/kvm.o
> +	OBJS		+= mips/kvm-cpu.o
> +	OBJS		+= mips/irq.o
> +endif
>  ###
>  
>  ifeq (,$(ARCH_INCLUDE))
> 

Cheers
James
