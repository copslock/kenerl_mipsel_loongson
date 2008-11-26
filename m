Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 12:48:41 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:37385 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23930473AbYKZMsf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2008 12:48:35 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id ABDFF3EC9; Wed, 26 Nov 2008 04:48:26 -0800 (PST)
Message-ID: <492D4595.7060903@ru.mvista.com>
Date:	Wed, 26 Nov 2008 15:48:21 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	LMO <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2] Alchemy: cpu feature override constants.
References: <20081125231230.GA10366@roarinelk.homelinux.net>
In-Reply-To: <20081125231230.GA10366@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:

> Add cpu feature override constants for Alchemy.
>
> This helps code generation: fls() for instance is compiled without
> using the clz instruction; other macros which do runtime feature
> detection fall back on safe legacy code as well.  Adding this override
> fixes that.  As a sideeffect, the size of a kernel built with an
> extended db1200 defconfig is reduced by over 200kB:
>
>    text    data     bss     dec     hex filename
> 3901089  124160  436528 4461777  4414d1 vmlinux
> 3676433  124096  436528 4237057  40a701 vmlinux-patched
>   

   Great!

> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>   

   The whitespace police on the road. :-)

> diff --git a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
> new file mode 100644
> index 0000000..c22492e
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
> @@ -0,0 +1,51 @@
>   
[...]
> +
> +#define cpu_dcache_line_size()	32
> +#define cpu_icache_line_size()  32
>   

   Inconsistent alignment.

WBR, Sergei
