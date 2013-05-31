Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 May 2013 16:49:42 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:46245 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823073Ab3EaOtlU6tiR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 May 2013 16:49:41 +0200
Message-ID: <51A8B753.4090900@phrozen.org>
Date:   Fri, 31 May 2013 16:44:35 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: define write{b,w,l,q}_relaxed
References: <1370009264-22018-1-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1370009264-22018-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36659
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

On 31/05/13 16:07, Florian Fainelli wrote:
> MIPS does define read{b,w,l,q}_relaxed but does not define their write
> counterparts: write{b,w,l,q}_relaxed. This patch adds the missing
> definitions for the write*_relaxed I/O accessors.
>
> Signed-off-by: Florian Fainelli<f.fainelli@gmail.com>

Acked-by: John Crispin <blogic@openwrt.org>



> ---
>   arch/mips/include/asm/io.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index b7e5985..ca42c68 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -449,6 +449,11 @@ __BUILDIO(q, u64)
>   #define readl_relaxed			readl
>   #define readq_relaxed			readq
>
> +#define writeb_relaxed			writeb
> +#define writew_relaxed			writew
> +#define writel_relaxed			writel
> +#define writeq_relaxed			writeq
> +
>   #define readb_be(addr)							\
>   	__raw_readb((__force unsigned *)(addr))
>   #define readw_be(addr)							\
