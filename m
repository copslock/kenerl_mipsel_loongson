Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 May 2013 14:34:48 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:51569 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827530Ab3E1Mer0Pakj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 May 2013 14:34:47 +0200
Message-ID: <51A4A33E.3000605@openwrt.org>
Date:   Tue, 28 May 2013 14:29:50 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Chen Gang <gang.chen@asianux.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] arch: mips: lantiq: using strlcpy() instead of strncpy()
References: <51A1BF15.7070905@asianux.com>
In-Reply-To: <51A1BF15.7070905@asianux.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

On 26/05/13 09:51, Chen Gang wrote:
> 'compatible' is used by strlen() in __of_device_is_compatible().
>
> So for NUL terminated string, need always be sure of ended by zero.
>
> 'of_ids' is not a structure in "include/uapi/*", so not need initialize
> all bytes, just use strlcpy() instead of strncpy().
>
>
> Signed-off-by: Chen Gang<gang.chen@asianux.com>

Acked-by: John Crispin <blogic@openwrt.org>

> ---
>   arch/mips/lantiq/prom.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
> index 9f9e875..49c4603 100644
> --- a/arch/mips/lantiq/prom.c
> +++ b/arch/mips/lantiq/prom.c
> @@ -112,7 +112,7 @@ int __init plat_of_setup(void)
>   	if (!of_have_populated_dt())
>   		panic("device tree not present");
>
> -	strncpy(of_ids[0].compatible, soc_info.compatible,
> +	strlcpy(of_ids[0].compatible, soc_info.compatible,
>   		sizeof(of_ids[0].compatible));
>   	strncpy(of_ids[1].compatible, "simple-bus",
>   		sizeof(of_ids[1].compatible));
