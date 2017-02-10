Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2017 10:12:33 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:131:30e2::2]:47351 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991957AbdBJJM0hlvda (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Feb 2017 10:12:26 +0100
Subject: Re: [PATCH] MIPS: ralink: fix mt7628 alternative functions names
To:     =?UTF-8?Q?Andr=c3=a9_Draszik?= <git@andred.net>,
        linux-kernel@vger.kernel.org
References: <20170210090659.21873-1-git@andred.net>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
From:   John Crispin <john@phrozen.org>
Message-ID: <17885154-71f7-2d1e-7046-757e092de508@phrozen.org>
Date:   Fri, 10 Feb 2017 10:12:24 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170210090659.21873-1-git@andred.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56752
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



On 10/02/2017 10:06, André Draszik wrote:
> They're all referenced as utif in the datasheet, not util.
> 
> Fixes: 53263a1c6852 ("MIPS: ralink: add mt7628an support")
> Fixes: 2b436a351803 ("MIPS: ralink: add MT7628 EPHY LEDs pinmux support")
> 
> Signed-off-by: André Draszik <git@andred.net>

I was under the impression that I had sent this patch already, maybe it
got lost somewhere along the line

Acked-by: John Crispin <john@phrozen.org>


> ---
>  arch/mips/ralink/mt7620.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
> index 3c7c9bf57bf3..6f892c1f3ad7 100644
> --- a/arch/mips/ralink/mt7620.c
> +++ b/arch/mips/ralink/mt7620.c
> @@ -176,7 +176,7 @@ static struct rt2880_pmx_func spi_cs1_grp_mt7628[] = {
>  
>  static struct rt2880_pmx_func spis_grp_mt7628[] = {
>  	FUNC("pwm_uart2", 3, 14, 4),
> -	FUNC("util", 2, 14, 4),
> +	FUNC("utif", 2, 14, 4),
>  	FUNC("gpio", 1, 14, 4),
>  	FUNC("spis", 0, 14, 4),
>  };
> @@ -190,28 +190,28 @@ static struct rt2880_pmx_func gpio_grp_mt7628[] = {
>  
>  static struct rt2880_pmx_func p4led_kn_grp_mt7628[] = {
>  	FUNC("jtag", 3, 30, 1),
> -	FUNC("util", 2, 30, 1),
> +	FUNC("utif", 2, 30, 1),
>  	FUNC("gpio", 1, 30, 1),
>  	FUNC("p4led_kn", 0, 30, 1),
>  };
>  
>  static struct rt2880_pmx_func p3led_kn_grp_mt7628[] = {
>  	FUNC("jtag", 3, 31, 1),
> -	FUNC("util", 2, 31, 1),
> +	FUNC("utif", 2, 31, 1),
>  	FUNC("gpio", 1, 31, 1),
>  	FUNC("p3led_kn", 0, 31, 1),
>  };
>  
>  static struct rt2880_pmx_func p2led_kn_grp_mt7628[] = {
>  	FUNC("jtag", 3, 32, 1),
> -	FUNC("util", 2, 32, 1),
> +	FUNC("utif", 2, 32, 1),
>  	FUNC("gpio", 1, 32, 1),
>  	FUNC("p2led_kn", 0, 32, 1),
>  };
>  
>  static struct rt2880_pmx_func p1led_kn_grp_mt7628[] = {
>  	FUNC("jtag", 3, 33, 1),
> -	FUNC("util", 2, 33, 1),
> +	FUNC("utif", 2, 33, 1),
>  	FUNC("gpio", 1, 33, 1),
>  	FUNC("p1led_kn", 0, 33, 1),
>  };
> @@ -232,28 +232,28 @@ static struct rt2880_pmx_func wled_kn_grp_mt7628[] = {
>  
>  static struct rt2880_pmx_func p4led_an_grp_mt7628[] = {
>  	FUNC("jtag", 3, 39, 1),
> -	FUNC("util", 2, 39, 1),
> +	FUNC("utif", 2, 39, 1),
>  	FUNC("gpio", 1, 39, 1),
>  	FUNC("p4led_an", 0, 39, 1),
>  };
>  
>  static struct rt2880_pmx_func p3led_an_grp_mt7628[] = {
>  	FUNC("jtag", 3, 40, 1),
> -	FUNC("util", 2, 40, 1),
> +	FUNC("utif", 2, 40, 1),
>  	FUNC("gpio", 1, 40, 1),
>  	FUNC("p3led_an", 0, 40, 1),
>  };
>  
>  static struct rt2880_pmx_func p2led_an_grp_mt7628[] = {
>  	FUNC("jtag", 3, 41, 1),
> -	FUNC("util", 2, 41, 1),
> +	FUNC("utif", 2, 41, 1),
>  	FUNC("gpio", 1, 41, 1),
>  	FUNC("p2led_an", 0, 41, 1),
>  };
>  
>  static struct rt2880_pmx_func p1led_an_grp_mt7628[] = {
>  	FUNC("jtag", 3, 42, 1),
> -	FUNC("util", 2, 42, 1),
> +	FUNC("utif", 2, 42, 1),
>  	FUNC("gpio", 1, 42, 1),
>  	FUNC("p1led_an", 0, 42, 1),
>  };
> 
