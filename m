Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Aug 2016 01:24:55 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35966 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993505AbcHLXYtWCm5W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Aug 2016 01:24:49 +0200
Received: by mail-pf0-f193.google.com with SMTP id y134so51787pfg.3;
        Fri, 12 Aug 2016 16:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=C9s8D0KJ2nvOZ18dEFmdLklIihaWSB7fOCTlyYN4O/M=;
        b=tdz/3uAPjIIRDybiUavYL9VICrB3YkuWAkuqoK/M9tivHLj7/0X72wRaRR5iWGqIwE
         xbpqnU+O3R72Z6klvawC+GsRLjUbESBDBiqPPN5+ShnyZarMgBZOOuA9CjkHr7dBtMK/
         oxglOhVeFLm/9P7Kcy6EglHqyKdt+wGIjAytbUTJk+dymd41T52Cm5FurXiAd2m8e7ua
         Jdm7dqwmNtvcfMwMxZCV6RLkjoEVgcuItuiHwsW1atjhAFiyLXAz4T4x8sAjKc4U15mS
         ziXPrI4S3RcpXMaLBRM9ivHa7q5BeyGQe3G8Vqw1DNxaDslm7nLWz8DdUfU/cF2YTZO0
         ljbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=C9s8D0KJ2nvOZ18dEFmdLklIihaWSB7fOCTlyYN4O/M=;
        b=k4ZKiuVNWLEmNxvPiMW35w2qmB9WkRwvHz/Gan5THEoHKI7lYVays35MomsfEF1eQY
         pwXA6uS3VPlSutvr5pgolMAsgvf6WUTYxywKTg8ysPidb+bsj+1Yp+o2FT+67QFhMDyW
         tbcKfhGxy0Aq6ge820MKm0GGtRYjhGBLHkr9Eido6d3tB0yCg6DT4fygHJqx1TrUXAUn
         HZEd6ehbO5PHnbFQ72W7AEjzswcm4bwZ8AP6xWSatNlVzgiDbmyweofVEyC6kP1iELjS
         u45LJlkDUkMJMA8Tj0wE2Rlqav5bphLIa9uySTXfX6XylYJG04aKvdLKyirq4DQmnyR+
         avGQ==
X-Gm-Message-State: AEkoouuDa8GJ5a2GVozM77y0uxkRWJGYKOgGWNNF5g5Ne05s4dkRyg7HQgjI7zigMoAgmg==
X-Received: by 10.98.30.133 with SMTP id e127mr31695186pfe.104.1471044283604;
        Fri, 12 Aug 2016 16:24:43 -0700 (PDT)
Received: from [10.112.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id s89sm15489086pfi.83.2016.08.12.16.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Aug 2016 16:24:42 -0700 (PDT)
Subject: Re: [v3 3/5] MIPS: BMIPS: Add support SDHCI device nodes
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20160812085231.53290-1-jaedon.shin@gmail.com>
 <20160812085231.53290-4-jaedon.shin@gmail.com>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2d8ad754-e9b7-e80e-9925-15ccd9c15856@gmail.com>
Date:   Fri, 12 Aug 2016 16:24:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160812085231.53290-4-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 08/12/2016 01:52 AM, Jaedon Shin wrote:
> Adds SDHCI device nodes to BCM7xxx MIPS based SoCs.

While this looks good, I don't think you will have working SDHCI
interfaces on the 7425/7435 without additional pinmuxing, because
sometimes the bootloader indicates in a scratch register whether the
SDHCI0 is usable and the default pinmuxing does not necessarily make
this possible:

https://github.com/Broadcom/stblinux-3.3/blob/master/linux/drivers/brcmstb/board.c#L325

We have some currently out of tree patches using the pinctrl-single and
some CFE shim to fix that.

Other than that:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
