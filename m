Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Apr 2016 20:39:59 +0200 (CEST)
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34225 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007359AbcDCSj4b2qmg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Apr 2016 20:39:56 +0200
Received: by mail-oi0-f41.google.com with SMTP id s79so41831369oie.1;
        Sun, 03 Apr 2016 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=79wJ09UGDVwnAXVNqt+3uXS5Lr6zCyWOmpWRDsWC+BA=;
        b=jXiMMU6KfrUFwVXTQsDBQChkkkjA2CbzcNiAT8T+Dj/nbl/3eaWBf9PYROQSDMhaqO
         x6HBHQiOh6IZV8ioyy5FgA8A/oca1KjTGktR262yoNsNowPAIY5UBYtS30IwI/kEC8Ar
         AR+y7tjauN59tEvjnhCvrvmzF2wllPUmSlWWCfSD1eRRmfPx2GoPJCSSAxG0ZLtqkPif
         1vQTG0xli5NrefFjGea5Au4PjeGD6+lrrYWg/V3pv9of0o6E31xGMsEDc6FaYZ6FpKFS
         srXAuQMldy/k1kznRsU7YhdW7//zeRUqk/BScbw8E6GcsBWBJwkji0g7MHxXCOAVd89k
         +8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=79wJ09UGDVwnAXVNqt+3uXS5Lr6zCyWOmpWRDsWC+BA=;
        b=I1FyiwOZ0PQSg886yFELNFDckUBvwiUHvA3ZojpMRdxC6DomVVGZZWVE2Hw0dI9b+d
         4dhxsp3UgMCM2ZJCpXXYvlEL2uJ+qRUmFG4yEPcmmgaUbfUBaQPy/1jPt2MARCz3Xm32
         qn726N6TE75PamFzMRYclS2yF0D37KX0amdoUaLk3+711FD762M2b5AlozqgnK/Mj0Co
         sHWo1oTXZmRKEA4MfxenHCsQ6t7QjwhV1khwgaO0v/8KNjriA30ke7tfNLck7GcPjuuz
         NZXS3AkuivtmKnPvuLOHTVq0ZSTw/QfwhcJv52ZrWZehb6ueaQwAAq0x6+zVOyOkLwCl
         P9ow==
X-Gm-Message-State: AD7BkJJMZfo23KuC+s59ewKq5Jx/whNG7/+xV2hy2MuwWEnafFwRszpl6zmysScYhYhK3g==
X-Received: by 10.202.194.198 with SMTP id s189mr8437670oif.17.1459708790930;
        Sun, 03 Apr 2016 11:39:50 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:14c4:8f1:9484:755e? ([2001:470:d:73f:14c4:8f1:9484:755e])
        by smtp.googlemail.com with ESMTPSA id u8sm7273416obf.5.2016.04.03.11.39.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2016 11:39:50 -0700 (PDT)
Subject: Re: [PATCH 0/4] MIPS: BMIPS5200 SMP support
To:     linux-mips@linux-mips.org
References: <1454552093-17897-1-git-send-email-f.fainelli@gmail.com>
 <56F9DC22.9030309@gmail.com>
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, jaedon.shin@gmail.com,
        dragan.stancevic@gmail.com, jogo@openwrt.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <57016375.1000507@gmail.com>
Date:   Sun, 3 Apr 2016 11:39:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56F9DC22.9030309@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52848
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

Le 28/03/2016 18:36, Florian Fainelli a écrit :
> Le 03/02/2016 18:14, Florian Fainelli a écrit :
>> Hi all,
>>
>> This patch series adds BCM7435/BMIPS52000 SMP support, it builds
>> on top of the series submitted here:
>>
>> https://www.linux-mips.org/archives/linux-mips/2016-01/msg00737.html
> 
> Ralf, can you also queue these for 4.6 if they look okay to you? Thanks!

Same here, can this make it into 4.6? Thanks

> 
>>
>> Florian Fainelli (4):
>>   MIPS: BMIPS: Add Whirlwind (BMIPS5200) initialization code
>>   MIPS: BMIPS: Add missing 7038 L1 register cells to BCM7435
>>   MIPS: BMIPS: Remove maxcpus from BCM97435SVMB DTS
>>   MIPS: BMIPS: Fill in current_cpu_data.core
>>
>>  arch/mips/boot/dts/brcm/bcm7435.dtsi     |   5 +-
>>  arch/mips/boot/dts/brcm/bcm97435svmb.dts |   2 +-
>>  arch/mips/kernel/Makefile                |   2 +-
>>  arch/mips/kernel/bmips_5xxx_init.S       | 753 +++++++++++++++++++++++++++++++
>>  arch/mips/kernel/bmips_vec.S             |  41 +-
>>  arch/mips/kernel/smp-bmips.c             |   1 +
>>  6 files changed, 797 insertions(+), 7 deletions(-)
>>  create mode 100644 arch/mips/kernel/bmips_5xxx_init.S
>>
> 
> 


-- 
Florian
