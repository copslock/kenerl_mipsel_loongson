Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Feb 2015 14:22:54 +0100 (CET)
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:37189 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013012AbbBRNWxE8zX4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Feb 2015 14:22:53 +0100
Received: from resomta-ch2-17v.sys.comcast.net ([69.252.207.113])
        by resqmta-ch2-03v.sys.comcast.net with comcast
        id tpMj1p0012TL4Rh01pNjaQ; Wed, 18 Feb 2015 13:22:43 +0000
Received: from [192.168.1.13] ([69.250.160.75])
        by resomta-ch2-17v.sys.comcast.net with comcast
        id tpNg1p00X1duFqV01pNhof; Wed, 18 Feb 2015 13:22:43 +0000
Message-ID: <54E49216.2050007@gentoo.org>
Date:   Wed, 18 Feb 2015 08:22:30 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1685: Remove superfluous checks for out-of-range
 u8 values
References: <1424256279-20526-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1424256279-20526-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1424265763;
        bh=WLBaIGnH/F5CJxdQYHlUmghdnxhVzjL4iR4nh0J5fzA=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=M4QxcPHUZZRbDPNP4aYkK2Au+gX0VUk7360W0kQQ8yu8QnvwRmPjwk/XvVBOADRYi
         yhTjk6rOxS8IkvSLZ+U68aPFKDOeuN96WcnIThOGrKTboPRAhJOO7KocOzfbSS0zyg
         LZIqKDZrh/ugT67+RMyS1jB7p7CuFLnYWYiMjTVljVD+19A3lrPiVNSE0oUerR+nnR
         Ct5FBTzxVFTx3YDrs+Nsd2QpJ9BjvJHKfZDbqrEo6X7FfbxQTWpX9cdZABn5b6URTM
         9jGYVtz+iCMCo4ytrrstUQN6fRl9YieK0W3Vgy1muhrn7TsXux3KDd3++q3Y+NMtyH
         PWWywW6s4hOsA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45850
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

On 02/18/2015 05:44, Geert Uytterhoeven wrote:
> drivers/rtc/rtc-ds1685.c: In function ‘ds1685_rtc_read_alarm’:
> drivers/rtc/rtc-ds1685.c:402: warning: comparison is always true due to limited range of data type
> drivers/rtc/rtc-ds1685.c:409: warning: comparison is always true due to limited range of data type
> drivers/rtc/rtc-ds1685.c:416: warning: comparison is always true due to limited range of data type
> drivers/rtc/rtc-ds1685.c: In function ‘ds1685_rtc_set_alarm’:
> drivers/rtc/rtc-ds1685.c:475: warning: comparison is always true due to limited range of data type
> drivers/rtc/rtc-ds1685.c:478: warning: comparison is always true due to limited range of data type
> drivers/rtc/rtc-ds1685.c:481: warning: comparison is always true due to limited range of data type
> 
> u8 cannot contain a value larger than 0xff, hence drop the checks.
> Wrapping the checks in unlikely() indicated some sense of humor, though ;-)
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Actually, I think I was operating in -pedantic mode the night I added those
checks.  Good catch, thanks!

Acked-by: Joshua Kinard <kumba@gentoo.org>


> ---
>  drivers/rtc/rtc-ds1685.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index 8c3bfcb115b78731..5077078a9305b9d5 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -399,21 +399,21 @@ ds1685_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	 * of this RTC chip.  We check for it anyways in case support is
>  	 * added in the future.
>  	 */
> -	if (unlikely((seconds >= 0xc0) && (seconds <= 0xff)))
> +	if (unlikely(seconds >= 0xc0))
>  		alrm->time.tm_sec = -1;
>  	else
>  		alrm->time.tm_sec = ds1685_rtc_bcd2bin(rtc, seconds,
>  						       RTC_SECS_BCD_MASK,
>  						       RTC_SECS_BIN_MASK);
>  
> -	if (unlikely((minutes >= 0xc0) && (minutes <= 0xff)))
> +	if (unlikely(minutes >= 0xc0))
>  		alrm->time.tm_min = -1;
>  	else
>  		alrm->time.tm_min = ds1685_rtc_bcd2bin(rtc, minutes,
>  						       RTC_MINS_BCD_MASK,
>  						       RTC_MINS_BIN_MASK);
>  
> -	if (unlikely((hours >= 0xc0) && (hours <= 0xff)))
> +	if (unlikely(hours >= 0xc0))
>  		alrm->time.tm_hour = -1;
>  	else
>  		alrm->time.tm_hour = ds1685_rtc_bcd2bin(rtc, hours,
> @@ -472,13 +472,13 @@ ds1685_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	 * field, and we only support four fields.  We put the support
>  	 * here anyways for the future.
>  	 */
> -	if (unlikely((seconds >= 0xc0) && (seconds <= 0xff)))
> +	if (unlikely(seconds >= 0xc0))
>  		seconds = 0xff;
>  
> -	if (unlikely((minutes >= 0xc0) && (minutes <= 0xff)))
> +	if (unlikely(minutes >= 0xc0))
>  		minutes = 0xff;
>  
> -	if (unlikely((hours >= 0xc0) && (hours <= 0xff)))
> +	if (unlikely(hours >= 0xc0))
>  		hours = 0xff;
>  
>  	alrm->time.tm_mon	= -1;
> 
