Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 23:08:18 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:53030 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822668Ab3ISVIQFTs80 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Sep 2013 23:08:16 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 4A9578F61;
        Thu, 19 Sep 2013 23:08:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EbsqpsEgKlHh; Thu, 19 Sep 2013 23:08:11 +0200 (CEST)
Received: from [IPv6:2001:470:1f0b:447:9087:4f7f:af1b:18b] (unknown [IPv6:2001:470:1f0b:447:9087:4f7f:af1b:18b])
        by hauke-m.de (Postfix) with ESMTPSA id E74C9857F;
        Thu, 19 Sep 2013 23:08:10 +0200 (CEST)
Message-ID: <523B67B8.2060706@hauke-m.de>
Date:   Thu, 19 Sep 2013 23:08:08 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     thomas@m3y3r.de, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/10] MIPS: BCM47XX: Cocci spatch "noderef"
References: <1379604755850-858421494-0-diffsplit-thomas@m3y3r.de> <1379604755851-1504037195-1-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1379604755851-1504037195-1-diffsplit-thomas@m3y3r.de>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 09/19/2013 08:38 PM, thomas@m3y3r.de wrote:
> sizeof when applied to a pointer typed expression gives the size of the
> pointer.
> Found by coccinelle spatch "misc/noderef.cocci"

Thanks for spotting this.

Is this a new rule or has just nobody checked that part of the kernel?


The from field in the mail is broken.

> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> diff -u -p a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
> --- a/arch/mips/bcm47xx/sprom.c
> +++ b/arch/mips/bcm47xx/sprom.c
> @@ -162,7 +162,7 @@ static void nvram_read_alpha2(const char
>  		pr_warn("alpha2 is too long %s\n", buf);
>  		return;
>  	}
> -	memcpy(val, buf, sizeof(val));
> +	memcpy(val, buf, sizeof(*val));
>  }
>  
>  static void bcm47xx_fill_sprom_r1234589(struct ssb_sprom *sprom,
> 
