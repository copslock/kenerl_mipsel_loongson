Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2015 00:21:00 +0100 (CET)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36093 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007410AbbLUXU7FjwFV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2015 00:20:59 +0100
Received: by mail-pa0-f53.google.com with SMTP id q3so86093080pav.3;
        Mon, 21 Dec 2015 15:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1KvlbvWtyXDnuEHuy/6V7/eVq+tC1OlpXa7Q1uo8+QM=;
        b=MlE9FcO9aqQ3P+zh86A74cH8zHxcKRJLF6/vmurm8qLOWM922I7gPmvGorbldpjDfE
         ZuNp6QcCodhKkQUE0Ilk+NnXf1JE7z5c/Yj/Q+D/pm5MtWWqwOS5TkVWshA7yYxotk3a
         d/CqXsrgRBeIhCj2n9xjKemd7N7kkGZ8RxU8u6B2sbCz0iH/SC8NeibICoVImBsS6Zkd
         hOBxOn9KnJYi70us09EilnRP3ULUwKErpdjt15pCxsVS5O5G9drBBQmXb8mRnbjEf+09
         224AfTyPeh1sqQFQPsf19tMF9dETPwOk0WBHHAW0sMTMxjPZphJvI+FNb+Q662Bb7N3N
         4I4Q==
X-Received: by 10.66.228.225 with SMTP id sl1mr31103015pac.63.1450740052913;
        Mon, 21 Dec 2015 15:20:52 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id zu6sm24314552pac.8.2015.12.21.15.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2015 15:20:52 -0800 (PST)
Message-ID: <56788942.3030601@gmail.com>
Date:   Mon, 21 Dec 2015 15:20:34 -0800
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
CC:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>
Subject: Re: [PATCH 0/7] cleanup and add device tree for BCM7xxx platforms
References: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
In-Reply-To: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50727
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

On 18/11/15 18:34, Jaedon Shin wrote:
> Hi all,
> 
> This patch series is including device tree entries that clean up existing
> entries and adds missing entries for BCM7xxx platforms.
> 
> Jaedon Shin (7):
>   MIPS: BMIPS: remove unused aliases in device tree
>   MIPS: BMIPS: remove wrong sata properties
>   MIPS: BMIPS: fix phy name in device tree
>   MIPS: BMIPS: fix interrupt number in bcm7425.dtsi
>   MIPS: BMIPS: add device tree entry for BCM7xxx UART
>   MIPS: BMIPS: add device tree entry for BCM7xxx I2C
>   MIPS: BMIPS: add device tree entry for BCM7xxx SATA

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!

Ralf, since 19e88101c78f MIPS: BMIPS: Add SATA/PHY nodes for bcm7346 and
other changes got into 4.4-rc1, could you queue at least

MIPS: BMIPS: remove wrong sata properties
and
MIPS: BMIPS: fix interrupt number in bcm7425.dtsi

for an upcoming 4.4 pull request so we have correct device trees from
there on?

Thank you!
-- 
Florian
