Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2018 15:35:00 +0200 (CEST)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:34359
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993997AbeEGNexcWEdm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 May 2018 15:34:53 +0200
Received: by mail-it0-x244.google.com with SMTP id c5-v6so11087673itj.1
        for <linux-mips@linux-mips.org>; Mon, 07 May 2018 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z3GPSfXBqzWi0eVJlO8QjGJu/msLqL1PxpsfZFZZHPs=;
        b=ckqNP1JxQ2qeNNjFWICWxsC5Lnq0oZK6BQauOjTnlC72ukIZ5e/qrw2ivCZaznV9VL
         03NACz044zGBD16K2zp04tKRqIAyqKGGYeDyJGBN4uTunawDNJV7G9jE7Mv1qKhV8X3w
         M4SbYkSlfsYr4B/5u7GMb9jqNrMlhnfzDf+Ytk8ObJAkBAZT7tBtt23ATp+I0DFLsRCE
         ugVHGZX/ewj0aH5v7AzVkswGhHrgoWwMN6e64MdpA1lzAFseH52kB3sJFhnnpH68Vzzb
         UteY+yZvNDOKGjGRi7Ztb0Inz7QM/A5Lt5OviSx5x0FvrMB7cSlFmlDqY2MxqsiLoZ4H
         JJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z3GPSfXBqzWi0eVJlO8QjGJu/msLqL1PxpsfZFZZHPs=;
        b=V9sdEktYKidRpLwUAYHzDNPAiVFjLbpCRRU8Qge3J6Ews8zVaD6hlLfEUip4zshozB
         vm8+6G9+5PLJJ/qLDW8Ck34+0aqaC2mTX6ouxeZV0XQ4HWjmipPWQ+IQMOBJR4+VNYw2
         f+DXrXcsMddwHf88c12pvetJfln3JIILvL/NFD0IWpf8wFhnZnoTv4GctTouFE6uvwY6
         0fEil7XLdZoDGqtrFUc3KTUuNRenkNRUl5z6it9zASU74DI71dK/0H4j9O+M6kuw4oKP
         RrQfmJTkTx0TQOkfo5i8Zi4NG7ejiPSq5Iqwdj6Z5jvedVDZ5rV4eXbryhASKKdSIbD6
         FobQ==
X-Gm-Message-State: ALQs6tDvfIhw+j7n4Gad/f/KgiRj8+VH7UyWMO50+fKgf1/TT0xUOs0h
        EaaMlFeLFm6FZ4yJY7gOMxlK6Q==
X-Google-Smtp-Source: AB8JxZrDUa0T4SpeHVz0t54h0wdphD2stKb20zFgBAj8LDUKpOkOsMkblVcQSpcJPqNuo+LQGjX8jw==
X-Received: by 2002:a17:902:10c:: with SMTP id 12-v6mr38385407plb.252.1525700086856;
        Mon, 07 May 2018 06:34:46 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a6sm40867944pfo.88.2018.05.07.06.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 06:34:45 -0700 (PDT)
Subject: Re: [PATCH] watchdog: ath79: fix maximum timeout
To:     John Crispin <john@phrozen.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
References: <20180507131642.11440-1-john@phrozen.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <319719c3-eeec-c75f-68c1-b6d15cf884c5@roeck-us.net>
Date:   Mon, 7 May 2018 06:34:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507131642.11440-1-john@phrozen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 05/07/2018 06:16 AM, John Crispin wrote:
> If the userland tries to set a timeout higher than the max_timeout,
> then we should fallback to max_timeout.
> 

We don't do that for drivers using the watchdog core, so we should not
do it here either for consistency.

Guenter

> Signed-off-by: John Crispin <john@phrozen.org> > ---
>   drivers/watchdog/ath79_wdt.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
> index e2209bf5fa8a..c2fc6c3d0092 100644
> --- a/drivers/watchdog/ath79_wdt.c
> +++ b/drivers/watchdog/ath79_wdt.c
> @@ -115,10 +115,14 @@ static inline void ath79_wdt_disable(void)
>   
>   static int ath79_wdt_set_timeout(int val)
>   {
> -	if (val < 1 || val > max_timeout)
> +	if (val < 1)
>   		return -EINVAL;
>   
> -	timeout = val;
> +	if (val > max_timeout)
> +		timeout = max_timeout;
> +	else
> +		timeout = val;
> +
>   	ath79_wdt_keepalive();
>   
>   	return 0;
> 
