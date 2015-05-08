Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 07:45:14 +0200 (CEST)
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:40942 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012169AbbEHFpMQS0gp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 07:45:12 +0200
Received: from resomta-po-04v.sys.comcast.net ([96.114.154.228])
        by resqmta-po-06v.sys.comcast.net with comcast
        id RHkw1q0024vw8ds01Hl5hv; Fri, 08 May 2015 05:45:05 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-po-04v.sys.comcast.net with comcast
        id RHl31q00642s2jH01Hl4fb; Fri, 08 May 2015 05:45:05 +0000
Message-ID: <554C4D4E.6040904@gentoo.org>
Date:   Fri, 08 May 2015 01:44:46 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Nicholas Krause <xerofoify@gmail.com>, ralf@linux-mips.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips:Fix build error for ip32_defconfig configuration
References: <1431046356-27882-1-git-send-email-xerofoify@gmail.com>
In-Reply-To: <1431046356-27882-1-git-send-email-xerofoify@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1431063905;
        bh=OcrblxH9wAMe4PxG0Nt2aZ/589VQ96dQSPK40wcAzJM=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=KTraSvDRSpyjG1qfKceX+4chsxzB801CBMOeTACQ7f5XBCSbb91k9TUGtoDd3rsLa
         Fb222/W+417SnHJQ81nR8Mbkvtz49eGFFggYDbW/gaVheb/QCdwJnvju6ayqP71J7R
         vqRkSoOGJDPn5sSpEdLtjN7wvZ3zX7v9Md6RmLmGpBX3Qdp75zgjqdIFquFHtT7GTM
         GeWSB6E0QaWzabFC3lBiGLeyP1JS4QASFtiwamL2E3MBqJPn5hha2JB2t7ONcfPtJp
         lAa77nimF9Vup5lJCwYlevNfmUaoLE+8Hy3swYuvlH06+vn5VuKoWIGBut3XZm+Tkz
         4nSbLzBRxIUXw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 05/07/2015 20:52, Nicholas Krause wrote:
> This fixes the make error when building the ip32_defconfig
> configuration due to using sgio2_cmos_devinit rather then
> the correct function,sgio2_rtc_devinit in a device_initcall
> below this function's definition.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/mips/sgi-ip32/ip32-platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
> index 0134db2..2a7efcb 100644
> --- a/arch/mips/sgi-ip32/ip32-platform.c
> +++ b/arch/mips/sgi-ip32/ip32-platform.c
> @@ -130,9 +130,9 @@ struct platform_device ip32_rtc_device = {
>  	.resource		= ip32_rtc_resources,
>  };
>  
> -+static int __init sgio2_rtc_devinit(void)
> +static  __init int sgio2_rtc_devinit(void)
>  {
>  	return platform_device_register(&ip32_rtc_device);
>  }
>  
> -device_initcall(sgio2_cmos_devinit);
> +device_initcall(sgio2_rtc_devinit);
> 

I believe I sent this patch in already, back on 04/19/2015.  Didn't get an
acknowledgement on it from akpm, though.

--J
