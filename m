Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Dec 2013 19:04:26 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:41548 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822429Ab3LHSEXwhTRJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Dec 2013 19:04:23 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id E38DB8F67;
        Sun,  8 Dec 2013 19:04:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tTMBtlVr6Hby; Sun,  8 Dec 2013 19:04:16 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:609b:6857:e4ae:c4e9] (unknown [IPv6:2001:470:1f0b:447:609b:6857:e4ae:c4e9])
        by hauke-m.de (Postfix) with ESMTPSA id 0B4E58F66;
        Sun,  8 Dec 2013 19:04:15 +0100 (CET)
Message-ID: <52A4B49E.5030600@hauke-m.de>
Date:   Sun, 08 Dec 2013 19:04:14 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
MIME-Version: 1.0
To:     Ilia Mirkin <imirkin@alum.mit.edu>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: BCM47XX: Fix some very confused types and data
 corruption
References: <1386374213-25765-1-git-send-email-imirkin@alum.mit.edu>
In-Reply-To: <1386374213-25765-1-git-send-email-imirkin@alum.mit.edu>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38678
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

On 12/07/2013 12:56 AM, Ilia Mirkin wrote:
> Fix nvram_read_alpha2 copying too many bytes over the ssb_sprom
> structure. Also fix the arguments of the read_macaddr, although the code
> was technically not wrong before due to an extra dereference.
> 
> Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

This patch looks good to me. I have build tested it.

There was a similar patch on the mailing list but it did not get it into
3.13-rc1, this will supersede that patch:
http://patchwork.linux-mips.org/patch/5862/

> ---
> 
> I found this with coccinelle. Looking over the code, I'm pretty sure the below
> patch was the original intent. Or it is I that may be very confused. But if
> you have an argument like T foo[6], it's essentially equivalent to having an
> agument of T *foo. I don't even know what &foo.x does when x is declared as
> T[2]. Right now the memcpy is copying sizeof(val), which is char *val[2], and
> while I'm not 100% sure how sizeof works in this situation, that will
> translate to either sizeof(void*) or 2*sizeof(void*). I believe the intent was
> to only copy 2 bytes, since that is the size of the alpha2 field.
> 
> The macaddress situation is similar, except that the argument actually gets
> dereferenced, so it all works out. But I don't think that's necessary.
> 
> All that said, I haven't even build-tested this (no MIPS toolchain handy). But
> hopefully this will make sense to someone.
> 
>  arch/mips/bcm47xx/sprom.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
> index ad03c93..a8b5408 100644
> --- a/arch/mips/bcm47xx/sprom.c
> +++ b/arch/mips/bcm47xx/sprom.c
> @@ -135,7 +135,7 @@ static void nvram_read_leddc(const char *prefix, const char *name,
>  }
>  
>  static void nvram_read_macaddr(const char *prefix, const char *name,
> -			       u8 (*val)[6], bool fallback)
> +			       u8 val[6], bool fallback)
>  {
>  	char buf[100];
>  	int err;
> @@ -144,11 +144,11 @@ static void nvram_read_macaddr(const char *prefix, const char *name,
>  	if (err < 0)
>  		return;
>  
> -	bcm47xx_nvram_parse_macaddr(buf, *val);
> +	bcm47xx_nvram_parse_macaddr(buf, val);
>  }
>  
>  static void nvram_read_alpha2(const char *prefix, const char *name,
> -			     char (*val)[2], bool fallback)
> +			     char val[2], bool fallback)
>  {
>  	char buf[10];
>  	int err;
> @@ -162,7 +162,7 @@ static void nvram_read_alpha2(const char *prefix, const char *name,
>  		pr_warn("alpha2 is too long %s\n", buf);
>  		return;
>  	}
> -	memcpy(val, buf, sizeof(val));
> +	memcpy(val, buf, 2);
>  }
>  
>  static void bcm47xx_fill_sprom_r1234589(struct ssb_sprom *sprom,
> @@ -180,7 +180,7 @@ static void bcm47xx_fill_sprom_r1234589(struct ssb_sprom *sprom,
>  		      fallback);
>  	nvram_read_s8(prefix, NULL, "ag1", &sprom->antenna_gain.a1, 0,
>  		      fallback);
> -	nvram_read_alpha2(prefix, "ccode", &sprom->alpha2, fallback);
> +	nvram_read_alpha2(prefix, "ccode", sprom->alpha2, fallback);
>  }
>  
>  static void bcm47xx_fill_sprom_r12389(struct ssb_sprom *sprom,
> @@ -633,20 +633,20 @@ static void bcm47xx_fill_sprom_path_r45(struct ssb_sprom *sprom,
>  static void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom,
>  					const char *prefix, bool fallback)
>  {
> -	nvram_read_macaddr(prefix, "et0macaddr", &sprom->et0mac, fallback);
> +	nvram_read_macaddr(prefix, "et0macaddr", sprom->et0mac, fallback);
>  	nvram_read_u8(prefix, NULL, "et0mdcport", &sprom->et0mdcport, 0,
>  		      fallback);
>  	nvram_read_u8(prefix, NULL, "et0phyaddr", &sprom->et0phyaddr, 0,
>  		      fallback);
>  
> -	nvram_read_macaddr(prefix, "et1macaddr", &sprom->et1mac, fallback);
> +	nvram_read_macaddr(prefix, "et1macaddr", sprom->et1mac, fallback);
>  	nvram_read_u8(prefix, NULL, "et1mdcport", &sprom->et1mdcport, 0,
>  		      fallback);
>  	nvram_read_u8(prefix, NULL, "et1phyaddr", &sprom->et1phyaddr, 0,
>  		      fallback);
>  
> -	nvram_read_macaddr(prefix, "macaddr", &sprom->il0mac, fallback);
> -	nvram_read_macaddr(prefix, "il0macaddr", &sprom->il0mac, fallback);
> +	nvram_read_macaddr(prefix, "macaddr", sprom->il0mac, fallback);
> +	nvram_read_macaddr(prefix, "il0macaddr", sprom->il0mac, fallback);
>  }
>  
>  static void bcm47xx_fill_board_data(struct ssb_sprom *sprom, const char *prefix,
> 
