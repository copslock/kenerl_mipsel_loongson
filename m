Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jul 2017 09:24:53 +0200 (CEST)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:35664
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990552AbdGHHYrdAlzY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jul 2017 09:24:47 +0200
Received: by mail-wr0-x242.google.com with SMTP id z45so12302744wrb.2
        for <linux-mips@linux-mips.org>; Sat, 08 Jul 2017 00:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gAtfiyqSjImY5leLat8vLsaz9S1lQ9l+NUHjTjqrt7k=;
        b=e+RFHYV5qpFafMQmT9Qe8C3eZ2fd84YdNGVxqjmLGQGQs4Y46Y6p1KGF+okMutqsR+
         LSzvz5VIZLe+hIGCAhVAcvtM1A7MJ8ehta1ChI9bHOSOpqSE59q0ArnRd2637rTDUpp9
         0kh5kTat1kIVjQPBLC7yvqNUjcOgXQuxaWDIF+5wcMoPNdgp6keqodVQf1gofJ+getYN
         NR634GKNZptjgSXN1d3/AF4QJ/9pRPsenYxiImwD6r9ng/sMUZGqtcaKUrvRdgGKFT8+
         HQbRFZ2ye/Df2T3sOFei0LzJgiscjWqhts+Ntae310/r18gV0YpIIS6hc+8CUD1A1c5m
         6qQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gAtfiyqSjImY5leLat8vLsaz9S1lQ9l+NUHjTjqrt7k=;
        b=hxMKg4VF/nX4KabhNCUtlXAYy7PYEgItCDouJ2fzuQbQnQ7qpQFFVWnqCjBCOZg/WD
         oOpulG3u32u3lMQd588oCZC1UTdR2i24EKUt+wb5Dy1jhgnSu8aoGwJFd0t8z3jF5ljr
         Cfqp2DHmfF9I+CH79nlAmsQFlCSEam198HzqOhB32hL06SMmR0OJKvAyQjOtzMfCJ/me
         DWKDhSLWN+/Cfh+UlkG8lW8yoqVPNHgo2h11j/Du7VIOU3frrzBd0aa9blTTmtJ/Gdcw
         cz/ZBfXbUfMK/R/QQX/fy8ja1j96FIOhkrX4VfOXDXKLd7k0/MwvpO3ovFd80ztdkIly
         FSLg==
X-Gm-Message-State: AIVw111WVCMmxCF0K6OLKhX9AvrmAu4Y1Ksj0WZMKsfc+4wkpZXd6qVE
        p5ErEr5xzBus9toTmNY=
X-Received: by 10.223.149.33 with SMTP id 30mr2815360wrs.186.1499498681991;
        Sat, 08 Jul 2017 00:24:41 -0700 (PDT)
Received: from ?IPv6:2003:8c:2f4d:3200:11e3:9c90:60ac:7945? (p2003008C2F4D320011E39C9060AC7945.dip0.t-ipconnect.de. [2003:8c:2f4d:3200:11e3:9c90:60ac:7945])
        by smtp.googlemail.com with ESMTPSA id l14sm3935495wrb.19.2017.07.08.00.24.40
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jul 2017 00:24:41 -0700 (PDT)
Subject: Re: [PATCH] rt2x00: call clk_get_rate only if we have a clock
From:   Mathias Kresin <dev@kresin.me>
To:     linux-mips@linux-mips.org
References: <1499495441-4098-1-git-send-email-dev@kresin.me>
Message-ID: <a94548c1-90de-1d22-0829-463cbbb92c61@kresin.me>
Date:   Sat, 8 Jul 2017 09:24:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1499495441-4098-1-git-send-email-dev@kresin.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <dev@kresin.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev@kresin.me
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

08.07.2017 08:30, Mathias Kresin:
> If clk_get returns an error, rt2x00dev->clk is set to NULL. In
> contrast to the common clock framework provided clk_get_rate(), at
> least the ramips and bcm63xx legacy implementation of the clk API
> access the rate member of the clk struct without a NULL check. This
> results into a kernel panic if we do not have a (SoC) clock.
> 
> Call clk_get_rate only if we have a clock to fix the issues. This
> approach is similar to what is done in the kernel at various places.
> Usually clk_get_rate() is only called if clk_get_rate() doesn't return
> an error.
> 
> Signed-off-by: Mathias Kresin <dev@kresin.me>
> ---
>   drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> index d11c7b2..2a525b9 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -2059,6 +2059,9 @@ static void rt2800_config_lna_gain(struct rt2x00_dev *rt2x00dev,
>   
>   static inline bool rt2800_clk_is_20mhz(struct rt2x00_dev *rt2x00dev)
>   {
> +	if (!rt2x00dev->clk)
> +		return 0;
> +
>   	return clk_get_rate(rt2x00dev->clk) == 20000000;
>   }
>   
> 

Please disregard the patch. Send it to the wrong list.

Mathias
