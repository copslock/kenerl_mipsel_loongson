Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2014 12:05:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23620 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6855389AbaHTKE6WhlIy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Aug 2014 12:04:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 36FD6152923BE;
        Wed, 20 Aug 2014 11:04:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 20 Aug 2014 11:04:51 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 20 Aug
 2014 11:04:50 +0100
Message-ID: <53F472C2.2030202@imgtec.com>
Date:   Wed, 20 Aug 2014 11:04:50 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     chenj <chenj@lemote.com>, <linux-mips@linux-mips.org>
CC:     <chenhc@lemote.com>, <ralf@linux-mips.org>
Subject: Re: [PATCH] mips: define _MIPS_ARCH_LOONGSON3A for Loongson3
References: <1408504488-12319-1-git-send-email-chenj@lemote.com> <1408504488-12319-2-git-send-email-chenj@lemote.com>
In-Reply-To: <1408504488-12319-2-git-send-email-chenj@lemote.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42160
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

Hi,

On 20/08/14 04:14, chenj wrote:
> diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
> index 0ac20eb..5f527d1 100644
> --- a/arch/mips/loongson/Platform
> +++ b/arch/mips/loongson/Platform
> @@ -22,6 +22,9 @@ ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
>    endif
>  endif
>  
> +# Define _MIPS_ARCH_LOONGSON3A for Loongson3
> +cflags-$(CONFIG_CPU_LOONGSON3)  += -D_MIPS_ARCH_LOONGSON3A

Any reason not to just refer directly to CONFIG_CPU_LOONGSON3 from the
source rather than adding an intermediate definition?

Cheers
James
