Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 May 2013 12:43:47 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:44215 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825747Ab3E0Knm3WPdM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 May 2013 12:43:42 +0200
Message-ID: <51A337B9.60402@openwrt.org>
Date:   Mon, 27 May 2013 12:38:49 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] arch: mips: kernel: using strlcpy() instead of strncpy()
References: <51A1C26E.5000609@asianux.com>
In-Reply-To: <51A1C26E.5000609@asianux.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36606
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

On 26/05/13 10:06, Chen Gang wrote:
> For NUL terminated string, need always be sure of ended by zero.
>
> Or the next pr_info() will cause issue.
>
>
> Signed-off-by: Chen Gang<gang.chen@asianux.com>
> ---
>   arch/mips/kernel/prom.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
> index 5712bb5..7e95404 100644
> --- a/arch/mips/kernel/prom.c
> +++ b/arch/mips/kernel/prom.c
> @@ -30,7 +30,7 @@ __init void mips_set_machine_name(const char *name)
>   	if (name == NULL)
>   		return;
>
> -	strncpy(mips_machine_name, name, sizeof(mips_machine_name));
> +	strlcpy(mips_machine_name, name, sizeof(mips_machine_name));
>   	pr_info("MIPS: machine is %s\n", mips_get_machine_name());
>   }
>
Acked-by: John Crispin <blogic@openwrt.org>
