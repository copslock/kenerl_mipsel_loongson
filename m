Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 09:24:56 +0100 (CET)
Received: from mout.gmx.net ([212.227.17.22]:49890 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009232AbcARIYxesdVx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jan 2016 09:24:53 +0100
Received: from [10.95.162.180] ([155.56.40.73]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0MPYqL-1aGyMY3hxp-004ftD; Mon, 18 Jan 2016 09:23:52
 +0100
Subject: Re: [PATCH] mm: Remove duplicate definitions of MADV_FREE
To:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1453087746-4658-1-git-send-email-linux@roeck-us.net>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Zankel <chris@zankel.net>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, Chen Gang <gang.chen.5i5j@gmail.com>,
        Minchan Kim <minchan@kernel.org>
From:   Helge Deller <deller@gmx.de>
Message-ID: <569CA115.3010305@gmx.de>
Date:   Mon, 18 Jan 2016 09:23:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1453087746-4658-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:i38AfTZjK41GkZKU2dmNITCEEFeHmZFoVic8caYJmCCSleXIOIW
 XdwwgsEdeRKfcIifoCXcj5uuEnQdvcEgtUr6RJAawGPXneWBNBSqCtSFbPBmjPJ4s7lcjRv
 ZpJjV9YWqUl3R4PMR6OfKAJ2cP9117TVJTS3hWGfh60ma4yUOdai9khpVQSPQp5DqJPuYV1
 QWZD/Gq7Q4xC/n3hvbyPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VSzWWqyIQu4=:sVP94BYMAYzx9FXYPNSWL7
 afXl5v2Hf8bfY9382flL9fkmCGV6ge8oBt9knfmm28t4UMSgJ5fVMOOG5NlGu5UpOZj5CaTYO
 EXVrcSmnbwecY2iqJy2+NLq26aHhQyajCcHcJKxOpFx18DsApfGPUbaO4zT6IGMoTyUB/UZ01
 Rzzgf1oLXNF/YL3GE78MVAko8PBBKWJxK10C+DoA839qNvOLtPJdJrW3E9Ng14gkroDGVSTfO
 RlzKAsTPtnAzpuiitaQquwVOFoHTG0/ZPtoNN/qPs9yuXe+D8HrDm0ulHNiLghQtdbK+rtEIx
 XcQQdybS0Z5trLqGxEjl1dukufzzVfYriL6DRXtGTvQ88LX6h0MrkiAYEti4yNsqiREpJrChp
 1Sjl3YBvCa4CeNYOPlYgch5tNq33/vKzJQkSLG/Kil9f/dyFLh3LUv6sNOPSG9UZwhrotmirP
 0jBK3fGCLWdCt8kCdSBmz7Hd9L9V5iFbazZkfHv9wK7YLetMoYKsxAfuo9Rp4oelHycwuh0GZ
 rkm7FzTrDYslFAATXIPCNQqLOihRizTzrv7N4uSxQxH6CNDOQbn7WfQTLRSWz1DJpfOFBVTgG
 DJYLIF5NRU9ieMPvx8j9Z1hvMZvaw/YEHp8pfxCGnpVOGo6plWVGrIu5ds5oDrLdS/wdq3LcZ
 6KPNS5dnqgELWqW/tJOHijr3mOHbCsTG5+unw3v/I+8t158/HEq6lcEHDiYCzvcY3AjY6me1J
 IhQ/LxNRlUTv9cvxXcUTHi9WQWg7dJiVG5Ui/BirLQkEdLhmg5W6DsR7dXZuIv5MP4Dr7J6P5
 iUWC41u
Return-Path: <deller@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deller@gmx.de
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

On 18.01.2016 04:29, Guenter Roeck wrote:
> Commits 21f55b018ba5 ("arch/*/include/uapi/asm/mman.h: : let MADV_FREE
> have same value for all architectures") and ef58978f1eaa ("mm: define
> MADV_FREE for some arches") both defined MADV_FREE, but did not use the
> same values. This results in build errors such as
> 
> ./arch/alpha/include/uapi/asm/mman.h:53:0: error: "MADV_FREE" redefined
> ./arch/alpha/include/uapi/asm/mman.h:50:0: note:
> 	this is the location of the previous definition
> 
> for the affected architectures.
> 
> Fixes: 21f55b018ba5 ("arch/*/include/uapi/asm/mman.h: : let MADV_FREE have same value for all architectures")
> Fixes: ef58978f1eaa ("mm: define MADV_FREE for some arches")
> Cc: Chen Gang <gang.chen.5i5j@gmail.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>


On parisc both definitions of MADV_FREE are 8, so I do not face the compiler error.
Nevertheless it should be cleaned up.

Acked-by: Helge Deller <deller@gmx.de>  (for parisc)

Thanks!
Helge

> ---
>  arch/alpha/include/uapi/asm/mman.h  | 1 -
>  arch/mips/include/uapi/asm/mman.h   | 1 -
>  arch/parisc/include/uapi/asm/mman.h | 1 -
>  arch/xtensa/include/uapi/asm/mman.h | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
> index cf830d465f75..f3db7d8eb0c2 100644
> --- a/arch/parisc/include/uapi/asm/mman.h
> +++ b/arch/parisc/include/uapi/asm/mman.h
> @@ -43,7 +43,6 @@
>  #define MADV_SPACEAVAIL 5               /* insure that resources are reserved */
>  #define MADV_VPS_PURGE  6               /* Purge pages from VM page cache */
>  #define MADV_VPS_INHERIT 7              /* Inherit parents page size */
> -#define MADV_FREE	8		/* free pages only if memory pressure */
>  
>  /* common/generic parameters */
>  #define MADV_FREE	8		/* free pages only if memory pressure */
