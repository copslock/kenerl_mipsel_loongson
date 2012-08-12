Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Aug 2012 08:07:30 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:51970 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901166Ab2HLGH0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Aug 2012 08:07:26 +0200
Message-ID: <502747E2.5090407@phrozen.org>
Date:   Sun, 12 Aug 2012 08:06:26 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH V5 04/18] MIPS: Loongson: Make Loongson-3 to use BCD format
 for RTC.
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com> <1344677543-22591-5-git-send-email-chenhc@lemote.com>
In-Reply-To: <1344677543-22591-5-git-send-email-chenhc@lemote.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/08/12 11:32, Huacai Chen wrote:
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> ---
>  arch/mips/include/asm/mach-loongson/mc146818rtc.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mach-loongson/mc146818rtc.h b/arch/mips/include/asm/mach-loongson/mc146818rtc.h
> index ed7fe97..6b10159 100644
> --- a/arch/mips/include/asm/mach-loongson/mc146818rtc.h
> +++ b/arch/mips/include/asm/mach-loongson/mc146818rtc.h
> @@ -27,7 +27,11 @@ static inline void CMOS_WRITE(unsigned char data, unsigned long addr)
>  	outb_p(data, RTC_PORT(1));
>  }
>  
> +#ifdef CONFIG_CPU_LOONGSON3
> +#define RTC_ALWAYS_BCD	1
> +#else
>  #define RTC_ALWAYS_BCD	0
> +#endif
>  


maybe use a static inline that checks the cpu at runtime to avoid a #ifdef ?



>  #ifndef mc146818_decode_year
>  #define mc146818_decode_year(year) ((year) < 70 ? (year) + 2000 : (year) + 1970)
