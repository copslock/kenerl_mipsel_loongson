Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Aug 2013 18:35:06 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:56135 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827311Ab3HNQeuUJ5wZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Aug 2013 18:34:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id ECE84521DA3;
        Wed, 14 Aug 2013 18:34:43 +0200 (CEST)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3HJm-2f+OjWM; Wed, 14 Aug 2013 18:34:43 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id ADBFB521D68;
        Wed, 14 Aug 2013 18:34:43 +0200 (CEST)
Message-ID: <520BB1B3.5000400@openwrt.org>
Date:   Wed, 14 Aug 2013 18:34:59 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] MIPS: ralink: mt7620: add spi clock definition
References: <1375960672-32619-1-git-send-email-blogic@openwrt.org> <1375960672-32619-2-git-send-email-blogic@openwrt.org>
In-Reply-To: <1375960672-32619-2-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.08.08. 13:17 keltezéssel, John Crispin írta:
> The definition of the spi clock is missing.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/ralink/mt7620.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
> index ccdec5a..769296f 100644
> --- a/arch/mips/ralink/mt7620.c
> +++ b/arch/mips/ralink/mt7620.c
> @@ -167,6 +167,7 @@ void __init ralink_clk_init(void)
>  	ralink_clk_add("cpu", cpu_rate);
>  	ralink_clk_add("10000100.timer", 40000000);
>  	ralink_clk_add("10000500.uart", 40000000);
> +	ralink_clk_add("10000b00.spi", 40000000);

Please verify this. The SPI core uses the system clock AFAIK.

-Gabor
