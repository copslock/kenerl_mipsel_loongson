Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 16:32:53 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:42697 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902243Ab2FOOcr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 16:32:47 +0200
Received: by ggcs5 with SMTP id s5so2554676ggc.36
        for <multiple recipients>; Fri, 15 Jun 2012 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UaT07pgMynON+BJRVPlZ/USdMnMdnhyZ+uII59J5XrI=;
        b=mV0T0QzvAbVyHGakY70t4QG3+31F0D/ht3cn1Eb1DLMMomi4s1r4by8gJz1Bcn5VkX
         Ww/c1pFmA6rlqbcFi14a2EC4StOlwTaEYbw7teI7owfWTE0HtbUCvqzlAmi4qIFXLdEz
         q5CruWSd3xYQYVWm1WJR4zAvmyU+FB8Uq7D8tMep4bcIAzKojFLitCA3wQZimX5xf7l+
         9OKy/oLgHZug16/OzIUqgJQbWNjRzy1/gOFvjmFzDAbHwCnr6tPbYo0bKHIXCQvBB7o2
         a1ldumraDaFtF0mZXAV6jxqQDVumwOks3mNm73tmMn/XfhjVx7XpJM/0vqRDtoytUQ+L
         JDdQ==
Received: by 10.50.219.162 with SMTP id pp2mr2191139igc.40.1339770760875;
        Fri, 15 Jun 2012 07:32:40 -0700 (PDT)
Received: from mars ([159.226.43.42])
        by mx.google.com with ESMTPS id dc7sm1371056igc.13.2012.06.15.07.32.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 07:32:40 -0700 (PDT)
Date:   Fri, 15 Jun 2012 22:32:34 +0800
From:   LIU Qi <liuqi82@gmail.com>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH 06/14] MIPS: Loongson 3: Add IRQ init and dispatch
 support.
Message-ID: <20120615143234.GB15800@gmail.com>
Reply-To: LIU Qi <liuqi82@gmail.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
 <1339747801-28691-7-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1339747801-28691-7-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liuqi82@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Jun 15, 2012 at 04:09:53PM +0800, Huacai Chen wrote:
 > IRQ routing path of Loongson-3:
 > Devices(most) --> I8259 --> HT Controller --> IRQ Routing Table --> CPU
 >                                                   ^
 >                                                   |
 > Device(legacy devices such as UART) --> Bonito ---|
 > 
 > IRQ Routing Table route 32 INTs to CPU's INT0~INT3(IP2~IP5 of CP0), 32
 > INTs include 16 HT INTs(mostly), 4 PCI INTs, 1 LPC INT, etc. IP6 is used
 > for IPI and IP7 is used for internal MIPS timer. LOONGSON_INT_ROUTER_*
 > are IRQ Routing Table registers.
 > 
 > I8259 IRQs are 1:1 mapped to HT1 INTs. LOONGSON_HT1_* are configuration
 > registers of HT1 controller.
 > 
 > Signed-off-by: Huacai Chen <chenhc@lemote.com>
 > Signed-off-by: Hongliang Tao <taohl@lemote.com>
 > Signed-off-by: Hua Yan <yanh@lemote.com>
 > ---
 >  arch/mips/include/asm/mach-loongson/irq.h      |   26 +++++++
 >  arch/mips/include/asm/mach-loongson/loongson.h |    9 +++
 >  arch/mips/loongson/Makefile                    |    6 ++
 >  arch/mips/loongson/loongson-3/Makefile         |    4 +
 >  arch/mips/loongson/loongson-3/irq.c            |   87 ++++++++++++++++++++++++
 >  5 files changed, 132 insertions(+), 0 deletions(-)
 >  create mode 100644 arch/mips/include/asm/mach-loongson/irq.h
 >  create mode 100644 arch/mips/loongson/loongson-3/Makefile
 >  create mode 100644 arch/mips/loongson/loongson-3/irq.c
Fix the following compiling warning please:

  CC      drivers/input/serio/i8042.o
In file included from drivers/input/serio/i8042.h:32,
                 from drivers/input/serio/i8042.c:91:
drivers/input/serio/i8042-io.h:36:1: warning: "I8042_KBD_IRQ" redefined
In file included from
/home/liuqi/workspace/linux.git/arch/mips/include/asm/irq.h:18,
                 from include/linux/irq.h:27,
                 from include/asm-generic/hardirq.h:12,
                 from
/home/liuqi/workspace/linux.git/arch/mips/include/asm/hardirq.h:16,
                 from include/linux/hardirq.h:7,
                 from include/linux/interrupt.h:12,
                 from drivers/input/serio/i8042.c:18:
/home/liuqi/workspace/linux.git/arch/mips/include/asm/mach-loongson/irq.h:9:1: warning: this is the location of the previous definition

LIU Qi
