Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2014 20:59:27 +0100 (CET)
Received: from hall.aurel32.net ([195.154.112.97]:33661 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870563AbaAHT6rxzoPr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jan 2014 20:58:47 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1W0zH4-0007fB-Ji; Wed, 08 Jan 2014 20:58:46 +0100
Date:   Wed, 8 Jan 2014 20:58:46 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V16 03/12] MIPS: Loongson 3: Add Lemote-3A machtypes
 definition
Message-ID: <20140108195846.GA10518@hall.aurel32.net>
References: <1389149068-24376-1-git-send-email-chenhc@lemote.com>
 <1389149068-24376-4-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1389149068-24376-4-git-send-email-chenhc@lemote.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Wed, Jan 08, 2014 at 10:44:19AM +0800, Huacai Chen wrote:
> Add four Loongson-3 based machine types:
> MACH_LEMOTE_A1004/MACH_LEMOTE_A1201 are laptops;
> MACH_LEMOTE_A1101 is mini-itx;
> MACH_LEMOTE_A1205 is all-in-one machine.
> 
> The most significant differrent between A1004/A1201 and A1101/A1205 is
> the laptops have EC but others don't.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> ---
>  arch/mips/include/asm/bootinfo.h              |   24 +++++++++++++++---------
>  arch/mips/include/asm/mach-loongson/machine.h |    6 ++++++
>  arch/mips/loongson/common/machtype.c          |    4 ++++
>  3 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
> index 4d2cdea..09956a0 100644
> --- a/arch/mips/include/asm/bootinfo.h
> +++ b/arch/mips/include/asm/bootinfo.h
> @@ -61,15 +61,21 @@
>  /*
>   * Valid machtype for Loongson family
>   */
> -#define MACH_LOONGSON_UNKNOWN  0
> -#define MACH_LEMOTE_FL2E       1
> -#define MACH_LEMOTE_FL2F       2
> -#define MACH_LEMOTE_ML2F7      3
> -#define MACH_LEMOTE_YL2F89     4
> -#define MACH_DEXXON_GDIUM2F10  5
> -#define MACH_LEMOTE_NAS	       6
> -#define MACH_LEMOTE_LL2F       7
> -#define MACH_LOONGSON_END      8
> +enum loongson_machine_type {
> +	MACH_LOONGSON_UNKNOWN,
> +	MACH_LEMOTE_FL2E,
> +	MACH_LEMOTE_FL2F,
> +	MACH_LEMOTE_ML2F7,
> +	MACH_LEMOTE_YL2F89,
> +	MACH_DEXXON_GDIUM2F10,
> +	MACH_LEMOTE_NAS,
> +	MACH_LEMOTE_LL2F,
> +	MACH_LEMOTE_A1004,
> +	MACH_LEMOTE_A1101,
> +	MACH_LEMOTE_A1201,
> +	MACH_LEMOTE_A1205,
> +	MACH_LOONGSON_END
> +};
>  
>  /*
>   * Valid machtype for group INGENIC
> diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
> index 3810d5c..1b1f592 100644
> --- a/arch/mips/include/asm/mach-loongson/machine.h
> +++ b/arch/mips/include/asm/mach-loongson/machine.h
> @@ -24,4 +24,10 @@
>  
>  #endif
>  
> +#ifdef CONFIG_LEMOTE_MACH3A
> +
> +#define LOONGSON_MACHTYPE MACH_LEMOTE_A1101
> +
> +#endif /* CONFIG_LEMOTE_MACH3A */
> +
>  #endif /* __ASM_MACH_LOONGSON_MACHINE_H */
> diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
> index 4becd4f..1a47979 100644
> --- a/arch/mips/loongson/common/machtype.c
> +++ b/arch/mips/loongson/common/machtype.c
> @@ -27,6 +27,10 @@ static const char *system_types[] = {
>  	[MACH_DEXXON_GDIUM2F10]		"dexxon-gdium-2f",
>  	[MACH_LEMOTE_NAS]		"lemote-nas-2f",
>  	[MACH_LEMOTE_LL2F]		"lemote-lynloong-2f",
> +	[MACH_LEMOTE_A1004]		"lemote-3a-notebook-a1004",
> +	[MACH_LEMOTE_A1101]		"lemote-3a-itx-a1101",
> +	[MACH_LEMOTE_A1201]		"lemote-2gq-notebook-a1201",
> +	[MACH_LEMOTE_A1205]		"lemote-2gq-aio-a1205",
>  	[MACH_LOONGSON_END]		NULL,
>  };

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
