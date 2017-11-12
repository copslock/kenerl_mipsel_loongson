Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Nov 2017 10:56:44 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:36402 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990434AbdKLJ4dh9eTR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Nov 2017 10:56:33 +0100
Subject: Re: [PATCH 2/2] MIPS: ralink: fix typo in mt7628 pinmux function
To:     Mathias Kresin <dev@kresin.me>, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
References: <1494483075-17816-1-git-send-email-dev@kresin.me>
 <1494483075-17816-2-git-send-email-dev@kresin.me>
From:   John Crispin <john@phrozen.org>
Message-ID: <b9481e10-336e-f497-3d69-e3dbf531b4ad@phrozen.org>
Date:   Sun, 12 Nov 2017 10:56:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1494483075-17816-2-git-send-email-dev@kresin.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60843
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



On 11/05/17 08:11, Mathias Kresin wrote:
> There is a typo inside the pinmux setup code. The function is called
> refclk and not reclk.
>
> Signed-off-by: Mathias Kresin <dev@kresin.me>
Acked-by: John Crispin <john@phrozen.org>
> ---
>   arch/mips/ralink/mt7620.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
> index 528a6ac..86fac75 100644
> --- a/arch/mips/ralink/mt7620.c
> +++ b/arch/mips/ralink/mt7620.c
> @@ -144,7 +144,7 @@ static struct rt2880_pmx_func i2c_grp_mt7628[] = {
>   	FUNC("i2c", 0, 4, 2),
>   };
>   
> -static struct rt2880_pmx_func refclk_grp_mt7628[] = { FUNC("reclk", 0, 37, 1) };
> +static struct rt2880_pmx_func refclk_grp_mt7628[] = { FUNC("refclk", 0, 37, 1) };
>   static struct rt2880_pmx_func perst_grp_mt7628[] = { FUNC("perst", 0, 36, 1) };
>   static struct rt2880_pmx_func wdt_grp_mt7628[] = { FUNC("wdt", 0, 38, 1) };
>   static struct rt2880_pmx_func spi_grp_mt7628[] = { FUNC("spi", 0, 7, 4) };
