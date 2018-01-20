Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jan 2018 08:31:39 +0100 (CET)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:36609
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990397AbeATHbZKv7mt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jan 2018 08:31:25 +0100
Received: by mail-io0-x241.google.com with SMTP id l17so4491952ioc.3;
        Fri, 19 Jan 2018 23:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UmziYxfg7n7RhPSP4/jyO0Z9NfcQUXy0CWHVy2Hg90I=;
        b=YtMxZR58qA+8SuXkIHfKS5qriOgr23+rOxtvR/ZtOoYRIo4pmyEWSMW5XRGJVGDxg2
         CvYCimN9vu6Y/+c5sQTT7aUYa1lGulnmXYxwTXZanzUxGmiMzhqFXBqt2cysu3q7KyKI
         yfusJRnCaSFxXLSwviGNPTrOpC72pNCmDQMWQwHUZtuyPxYKNCWeN5rejzUpx8IC8jZX
         BRF2MDK8lZ9mt1H+aQlzJe5fJmqHMtt26g2rHJyC3TVUqfP4utUPWTFFsGbTnH79jEpQ
         X9MRpT9VXY7Rl25QfGrTsbq+16pVDjHVPT07ND19btP4Aw/QHZTZNFINDBOkcyxG1jFX
         eQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UmziYxfg7n7RhPSP4/jyO0Z9NfcQUXy0CWHVy2Hg90I=;
        b=W3LELoIB0AiEJWyZbXOIKZC12YrHU7OWItgiseh9jSdrBn2qtmffgRVlkSV/ClA12j
         CyJMViuykG25VjvNsjXe4SJ4cJSp6HTUJiqkadK9cZmOqY0MSDv/ooDuabazTQVdO21m
         m4y6oMuMpZj6FM2lcartmlKlzXBx2cZ5OJrpedKX2To5GcjiwpLcebiSmLTZRe+jIcWa
         uBCAl6Y/hJ8Oe72AYqGFWGGr/yZu/rZx7zOYO/7VXT7TBod8eMfX37bFpL6Okz6OvVbf
         vL3ePzUKaBgL0cdJYg97d2sa/w67cKUZ53aGTWL9Mva4Lp/3+mcs/5eOrMMYaejgUt8b
         E3xQ==
X-Gm-Message-State: AKwxytc7t/+VFnLJSLBKUmSsFRceTsLJOJkmlfu3LFqybcef1hKsPKK/
        zG+R54FeLZKCf9hltm4r3+yMrzgAZDZNNn18xnI=
X-Google-Smtp-Source: AH8x227W8VPnb1Be84w4nTAvEAd/ixjOqwzXWv/z0N2MieA3yN0tpxpo9FF7bSDvVh9xwQwUsse/WmGMKiBejvLvFI0=
X-Received: by 10.107.158.211 with SMTP id h202mr1025986ioe.129.1516433478539;
 Fri, 19 Jan 2018 23:31:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.165.9 with HTTP; Fri, 19 Jan 2018 23:31:17 -0800 (PST)
In-Reply-To: <20171230135108.6834-3-paul@crapouillou.net>
References: <20171228162939.3928-2-paul@crapouillou.net> <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-3-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sat, 20 Jan 2018 13:01:17 +0530
Message-ID: <CANc+2y7CT150cO61RfRgc6hCLEasx+NmqCacZtaFPKLgTPyt4w@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] watchdog: JZ4740: Register a restart handler
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Hi Paul,

On 30 December 2017 at 19:21, Paul Cercueil <paul@crapouillou.net> wrote:
> The watchdog driver can restart the system by simply configuring the
> hardware for a timeout of 0 seconds.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/jz4740_wdt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
>  v2: No change
>
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 92d6ca8ceb49..fa7f49a3212c 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -130,6 +130,14 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
>         return 0;
>  }
>
> +static int jz4740_wdt_restart(struct watchdog_device *wdt_dev,
> +                             unsigned long action, void *data)
> +{
> +       wdt_dev->timeout = 0;
> +       jz4740_wdt_start(wdt_dev);
> +       return 0;
> +}
> +
>  static const struct watchdog_info jz4740_wdt_info = {
>         .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>         .identity = "jz4740 Watchdog",
> @@ -141,6 +149,7 @@ static const struct watchdog_ops jz4740_wdt_ops = {
>         .stop = jz4740_wdt_stop,
>         .ping = jz4740_wdt_ping,
>         .set_timeout = jz4740_wdt_set_timeout,
> +       .restart = jz4740_wdt_restart,
>  };
>
>  #ifdef CONFIG_OF
> --
> 2.11.0
>
>

Noticed that min_timeout of the watchdog device is set to 1 but this
function calls start with timeout set to 0. Even though this works I
feel it is better to set min_timeout to 0.

Regards,
PrasannaKumar
