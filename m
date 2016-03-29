Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2016 03:36:43 +0200 (CEST)
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36426 "EHLO
        mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007881AbcC2BgmNpsAj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2016 03:36:42 +0200
Received: by mail-ob0-f174.google.com with SMTP id m7so811976obh.3;
        Mon, 28 Mar 2016 18:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=LDo3TbriMQ/VqzspUXzQm/CYz9GBOUoKlQQ7pvesiF8=;
        b=iY5Yx1R8SvZz0MM98W1xoF1iaX5nRUJy3NBcWkP6R7ugsUIU3Czto3TSw4/vEZPZdw
         SJcFOFXY0ofe4o1peZu18nLc4LlCIguVNqG6DnzzdXDidLgbbYVgmmYm5QZPWurRbp7k
         pyXzHN6HHELvEX6R04E1Sp+G3U8zUQ0kBmkKqHIyhKcsbDeeEFgTYB9GZ0HtrKZUkibk
         77ioaxwehoCUWt0bfgq8JFIxaEmywebr3pjOBzz/0DS0xQyJTT1zvmOigl/j5Zon/QEG
         wwM8U7Ji5r1z+XBjcENWdO+rOAqEFrXnwyDv62p0SAswNAh56hqQT+3PQuAhgGGu8Esc
         cvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=LDo3TbriMQ/VqzspUXzQm/CYz9GBOUoKlQQ7pvesiF8=;
        b=IJp1o2IzbuviG8CNGqb/cRagdOCkkI5yieRhg1bRpl6jANF0SGq7rdd83BIqID1zMG
         cWCm3pu/HFAQeLw+77FSf6/VAmNrkXOk3TDExv57LI7TFrXI3oRNdHjlaBOdhDOyZVJ1
         dWdYDJjt1od8am79I6VZfhBPFVP+2Oj2wb3B0om0seBqtvXLBqhtgADCDqEx5TNtYmhq
         DyY5GtODR9gqpm+gJhmKd51aWXHTyuwyxtOCfV69VaVxnoeDapNidkLjX+jU/bJKCMsA
         vFnNgkCOz9kMvEJ7RHUULEgesl3HmegKQ9um22jinDeRvI+oDRnbW5KLAh6ASbuzldyf
         3JTw==
X-Gm-Message-State: AD7BkJIg6/Q0v8K09Vl3jfMeG8TzN3BryNBgWidvua4TYFq/8RdTopphN2SPVOa2FXtqAg==
X-Received: by 10.60.132.180 with SMTP id ov20mr3185723oeb.71.1459215396564;
        Mon, 28 Mar 2016 18:36:36 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:2903:38c6:7796:9ae1? ([2001:470:d:73f:2903:38c6:7796:9ae1])
        by smtp.googlemail.com with ESMTPSA id 91sm8720047otg.16.2016.03.28.18.36.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2016 18:36:36 -0700 (PDT)
Subject: Re: [PATCH 0/4] MIPS: BMIPS5200 SMP support
To:     linux-mips@linux-mips.org
References: <1454552093-17897-1-git-send-email-f.fainelli@gmail.com>
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, jaedon.shin@gmail.com,
        dragan.stancevic@gmail.com, jogo@openwrt.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56F9DC22.9030309@gmail.com>
Date:   Mon, 28 Mar 2016 18:36:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1454552093-17897-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52716
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

Le 03/02/2016 18:14, Florian Fainelli a écrit :
> Hi all,
> 
> This patch series adds BCM7435/BMIPS52000 SMP support, it builds
> on top of the series submitted here:
> 
> https://www.linux-mips.org/archives/linux-mips/2016-01/msg00737.html

Ralf, can you also queue these for 4.6 if they look okay to you? Thanks!

> 
> Florian Fainelli (4):
>   MIPS: BMIPS: Add Whirlwind (BMIPS5200) initialization code
>   MIPS: BMIPS: Add missing 7038 L1 register cells to BCM7435
>   MIPS: BMIPS: Remove maxcpus from BCM97435SVMB DTS
>   MIPS: BMIPS: Fill in current_cpu_data.core
> 
>  arch/mips/boot/dts/brcm/bcm7435.dtsi     |   5 +-
>  arch/mips/boot/dts/brcm/bcm97435svmb.dts |   2 +-
>  arch/mips/kernel/Makefile                |   2 +-
>  arch/mips/kernel/bmips_5xxx_init.S       | 753 +++++++++++++++++++++++++++++++
>  arch/mips/kernel/bmips_vec.S             |  41 +-
>  arch/mips/kernel/smp-bmips.c             |   1 +
>  6 files changed, 797 insertions(+), 7 deletions(-)
>  create mode 100644 arch/mips/kernel/bmips_5xxx_init.S
> 


-- 
Florian
