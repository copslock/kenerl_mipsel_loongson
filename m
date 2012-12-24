Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Dec 2012 12:07:30 +0100 (CET)
Received: from mail-la0-f49.google.com ([209.85.215.49]:41671 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820301Ab2LXLH2NtML0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Dec 2012 12:07:28 +0100
Received: by mail-la0-f49.google.com with SMTP id r15so8200749lag.8
        for <linux-mips@linux-mips.org>; Mon, 24 Dec 2012 03:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=VmUhbiPybqmcw5e/Bi3SpziFHrasyple9/emoYsqTf0=;
        b=k6KXhxaMa4d3E6L3bHGeH70ifltmg2IwABA4DYslMAW3NigF8OUZNVQwxIZMQD2Vfj
         EeQ5q+ydP4G0oPeOVWjSfz8mHDfdY2Oksqp75T8Pml8Cjo7JTEicR3vJHOadT1HHStey
         f8Fvn9+Pg74km/8TEaPaLf/4aELDa2OycfzNrwrPSrInVF+A2w4NvEgDEt23x5cZxh7o
         m/7Zz3Af6pe/vOC5eh7t7QrIM487qFqNlDX29ZHFPkxCSnU27ZgLtpEHbgYfmtPUAoj0
         ZDhJBfTgUCW4ZexyYbBKgtWzM8qR5TIgsGH6hYqBy9JWabVakUflTc4zwUU+HjO1ih4O
         kRAQ==
X-Received: by 10.152.105.203 with SMTP id go11mr19734604lab.53.1356347242183;
        Mon, 24 Dec 2012 03:07:22 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-84-95.pppoe.mtu-net.ru. [91.79.84.95])
        by mx.google.com with ESMTPS id bf3sm7294128lbb.16.2012.12.24.03.07.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Dec 2012 03:07:21 -0800 (PST)
Message-ID: <50D8376B.30202@mvista.com>
Date:   Mon, 24 Dec 2012 15:07:23 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Shane McDonald <mcdonald.shane@gmail.com>
CC:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: MSP71xx: Move include files
References: <E1Tn02j-0003nm-Hh@localhost>
In-Reply-To: <E1Tn02j-0003nm-Hh@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQm1l8vFql6i7Zr+rzc4OT+6XWi0sJUIfFGr7lDCS1U88EO6aNaGQTUgTAty1BPgHSdCtmhd
X-archive-position: 35318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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

Hello.

On 24-12-2012 8:53, Shane McDonald wrote:

> Now that Yosemite's gone we can move the MSP71xx include files
> one level up.

> Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
> ---
>   .../asm/mach-pmcs-msp71xx/cpu-feature-overrides.h  |   22 +
>   arch/mips/include/asm/mach-pmcs-msp71xx/gpio.h     |   46 ++
>   .../include/asm/mach-pmcs-msp71xx/msp_cic_int.h    |  151 +++++
>   .../asm/mach-pmcs-msp71xx/msp_gpio_macros.h        |  343 ++++++++++
>   arch/mips/include/asm/mach-pmcs-msp71xx/msp_int.h  |   43 ++
>   arch/mips/include/asm/mach-pmcs-msp71xx/msp_pci.h  |  205 ++++++
>   arch/mips/include/asm/mach-pmcs-msp71xx/msp_prom.h |  171 +++++
>   .../include/asm/mach-pmcs-msp71xx/msp_regops.h     |  236 +++++++
>   arch/mips/include/asm/mach-pmcs-msp71xx/msp_regs.h |  664 ++++++++++++++++++++
>   .../include/asm/mach-pmcs-msp71xx/msp_slp_int.h    |  141 +++++
>   arch/mips/include/asm/mach-pmcs-msp71xx/msp_usb.h  |  144 +++++
>   arch/mips/include/asm/mach-pmcs-msp71xx/war.h      |   29 +
>   .../asm/pmc-sierra/msp71xx/cpu-feature-overrides.h |   22 -
>   arch/mips/include/asm/pmc-sierra/msp71xx/gpio.h    |   46 --
>   .../include/asm/pmc-sierra/msp71xx/msp_cic_int.h   |  151 -----
>   .../asm/pmc-sierra/msp71xx/msp_gpio_macros.h       |  343 ----------
>   arch/mips/include/asm/pmc-sierra/msp71xx/msp_int.h |   43 --
>   arch/mips/include/asm/pmc-sierra/msp71xx/msp_pci.h |  205 ------
>   .../mips/include/asm/pmc-sierra/msp71xx/msp_prom.h |  171 -----
>   .../include/asm/pmc-sierra/msp71xx/msp_regops.h    |  236 -------
>   .../mips/include/asm/pmc-sierra/msp71xx/msp_regs.h |  664 --------------------
>   .../include/asm/pmc-sierra/msp71xx/msp_slp_int.h   |  141 -----
>   arch/mips/include/asm/pmc-sierra/msp71xx/msp_usb.h |  144 -----
>   arch/mips/include/asm/pmc-sierra/msp71xx/war.h     |   29 -
>   arch/mips/pmcs-msp71xx/Platform                    |    2 +-
>   25 files changed, 2196 insertions(+), 2196 deletions(-)
>   create mode 100644 arch/mips/include/asm/mach-pmcs-msp71xx/cpu-feature-overrides.h
>   create mode 100644 arch/mips/include/asm/mach-pmcs-msp71xx/gpio.h
>   create mode 100644 arch/mips/include/asm/mach-pmcs-msp71xx/msp_cic_int.h
>   create mode 100644 arch/mips/include/asm/mach-pmcs-msp71xx/msp_gpio_macros.h
>   create mode 100644 arch/mips/include/asm/mach-pmcs-msp71xx/msp_int.h
>   create mode 100644 arch/mips/include/asm/mach-pmcs-msp71xx/msp_pci.h
>   create mode 100644 arch/mips/include/asm/mach-pmcs-msp71xx/msp_prom.h
>   create mode 100644 arch/mips/include/asm/mach-pmcs-msp71xx/msp_regops.h
>   create mode 100644 arch/mips/include/asm/mach-pmcs-msp71xx/msp_regs.h
>   create mode 100644 arch/mips/include/asm/mach-pmcs-msp71xx/msp_slp_int.h
>   create mode 100644 arch/mips/include/asm/mach-pmcs-msp71xx/msp_usb.h
>   create mode 100644 arch/mips/include/asm/mach-pmcs-msp71xx/war.h
>   delete mode 100644 arch/mips/include/asm/pmc-sierra/msp71xx/cpu-feature-overrides.h
>   delete mode 100644 arch/mips/include/asm/pmc-sierra/msp71xx/gpio.h
>   delete mode 100644 arch/mips/include/asm/pmc-sierra/msp71xx/msp_cic_int.h
>   delete mode 100644 arch/mips/include/asm/pmc-sierra/msp71xx/msp_gpio_macros.h
>   delete mode 100644 arch/mips/include/asm/pmc-sierra/msp71xx/msp_int.h
>   delete mode 100644 arch/mips/include/asm/pmc-sierra/msp71xx/msp_pci.h
>   delete mode 100644 arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
>   delete mode 100644 arch/mips/include/asm/pmc-sierra/msp71xx/msp_regops.h
>   delete mode 100644 arch/mips/include/asm/pmc-sierra/msp71xx/msp_regs.h
>   delete mode 100644 arch/mips/include/asm/pmc-sierra/msp71xx/msp_slp_int.h
>   delete mode 100644 arch/mips/include/asm/pmc-sierra/msp71xx/msp_usb.h
>   delete mode 100644 arch/mips/include/asm/pmc-sierra/msp71xx/war.h

    You should have generated the patch with -M option (IIRC) to detect the 
file moves.

WBR, Sergei
