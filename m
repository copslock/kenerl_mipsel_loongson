Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 10:52:44 +0100 (CET)
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38180 "EHLO
        mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007571AbbCZJwnFgIC5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 10:52:43 +0100
Received: by wibgn9 with SMTP id gn9so77099251wib.1
        for <linux-mips@linux-mips.org>; Thu, 26 Mar 2015 02:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=YUs2GzH2Xd1nbRO5hsh9yhhwQmNFDKTPz3trRxPdO1U=;
        b=TttefpoJNrviOdrG0muTLI0N1hCvDyqiAODr4vtNB8Zs3BnKTq4W5zs93zy1T/SsDQ
         pjWE6OzaQSYhwsVJDXVZYF1853lgWBoCgkwlWHl1VpJGMkLZZpRcNuiQCf252algQqJD
         /IYzP+sMJNQhHGU1J3dxqGIKcjZ9AZx+dF+z5VYdnOJzfCSaSFvEHDc2gVTyrwtkKbkp
         l2Xs83ioG/igij+st6OVJgEb1wFYZl8P7H24qlTlWGN1EjCwJlhjAAlhTyypo38BRboV
         Zb0YeEPA/iMmFk+3zMrU0Otr0c9Cygh9HqJXjC6SorRXCjo8/6TG6sHG7UFFhmPeZBOf
         jAKg==
X-Gm-Message-State: ALoCoQmQ/JAPATO/QRcW7DJ7+Y84xFj4oCdWef5N/7IMqICNx7kAoygkUFe+YHqUvzDoNcEdw2WB
X-Received: by 10.180.91.11 with SMTP id ca11mr23127533wib.10.1427363558770;
        Thu, 26 Mar 2015 02:52:38 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:fc9a:462b:8dd9:d151? ([2001:41d0:fe90:b800:fc9a:462b:8dd9:d151])
        by mx.google.com with ESMTPSA id i3sm1394787wiy.23.2015.03.26.02.52.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2015 02:52:37 -0700 (PDT)
Message-ID: <5513D6E4.4000101@linaro.org>
Date:   Thu, 26 Mar 2015 10:52:36 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
CC:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] clocksource: mips-gic-timer: Ensure GIC counter is
 running
References: <1427113923-9840-1-git-send-email-markos.chandras@imgtec.com> <1427113923-9840-3-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1427113923-9840-3-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 03/23/2015 01:32 PM, Markos Chandras wrote:
> Start the GIC counter after configuring the clocksource since there
> are no guarantees the counter will be running after a CPU reset.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/clocksource/mips-gic-timer.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
> index 3bd31b1321f6..16adbc1fa4c1 100644
> --- a/drivers/clocksource/mips-gic-timer.c
> +++ b/drivers/clocksource/mips-gic-timer.c
> @@ -133,6 +133,9 @@ static void __init __gic_clocksource_init(void)
>   	clocksource_register_hz(&gic_clocksource, gic_frequency);
>
>   	gic_clockevent_init();
> +
> +	/* And finally start the counter */
> +	gic_start_count();
>   }
>
>   void __init gic_clocksource_init(unsigned int frequency)
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
