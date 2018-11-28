Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2018 04:10:57 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990474AbeK1DKxUYirF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Nov 2018 04:10:53 +0100
Date:   Wed, 28 Nov 2018 03:10:53 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@mips.com>
cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>
Subject: Re: [PATCH] MIPS: Hardcode cpu_has_mmips=1 for microMIPS kernels
In-Reply-To: <20181107231931.6136-1-paul.burton@mips.com>
Message-ID: <alpine.LFD.2.21.1811280308430.32615@eddie.linux-mips.org>
References: <20181107231931.6136-1-paul.burton@mips.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Wed, 7 Nov 2018, Paul Burton wrote:

> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index 0edba3e75747..8669fdb503a5 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -195,7 +195,9 @@
>  #endif
>  
>  #ifndef cpu_has_mmips
> -# ifdef CONFIG_SYS_SUPPORTS_MICROMIPS
> +# if defined(__mips_micromips)

 Wouldn't it be cleaner if it was written:

# if defined(CONFIG_CPU_MICROMIPS)

?

  Maciej
