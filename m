Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 07:49:43 +0100 (CET)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33137 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010233AbcARGtlkmUuP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 07:49:41 +0100
Received: by mail-oi0-f67.google.com with SMTP id j3so11363879oig.0;
        Sun, 17 Jan 2016 22:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to
         :message-id;
        bh=TfDDb4NfNtcfq9BwM994VyQf7jiE0GAKC6tHlBP6av8=;
        b=CA+CMw0tlbqzavZONH5zubOouJijtp05QSqvth4MgC3FMFQ70RD/7DgfMqiA0LpGcv
         xjTIgpgP95pMOaZLKNlWRQxRRSSyn+5Gx9mdtlt0+9q/RarQ7EGjMnpCU2lKjC/1IxiQ
         fwYW87gJJKuJ+Y5B9FDz4FVzfff2/8RiRhMdPqQeK0iwL4pNbmS/e4nLXMC3tJZFrRJZ
         tQTRyRW3GwnCREH43g4Je5A7X+w0ybOS+Cw4TA7mvyc+4hST8k4LR4E1bsYkrakZIyQ4
         q9EA/rQEOiQjjzrJ4d/Cb8tO/3j8/n1Bt29WdFPpaVjcgKaUxOjp9aPXf+nkzrtW9SLT
         hgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to
         :message-id;
        bh=TfDDb4NfNtcfq9BwM994VyQf7jiE0GAKC6tHlBP6av8=;
        b=mC3g1v9pzopfDUCbuBkAIv+l4KMzCPvLtr4po0Eee1W4/WwppVwysWDU/tQePhJbFY
         z0wfDCPHI7/jk7Pcvh9wCkokIfe073Fp0R1awCzb0mblrN5LNelftXXGrDuOA5Zky3z1
         wysO+a7aPJqzelwpGEhPZObuDV3arabhkimxXVTaDUs0ROgzn8fcOoa9gIxkk1WnRnX/
         iOfFLjPWrjIg2zynqT3VQgHZ5Yb/8gvdiQpTah8jYNAmKotL40ssCrNIRIMMSPNbzAIr
         AoTOQhsfMZ3Ls8oz8cMbbCwR6gffuZhlmYD52S/g9RzUsyMhvLsfuho5yKx4pKgwx9va
         mqog==
X-Gm-Message-State: ALoCoQlzKZj+jF8ms1XPZT/0qUuboKfqXdAXwGqt58waFSd5tJ03Dp74ZHgeFEF40oCbcQh7xRFS4JkS3kaDR7n3jhH3TZhErA==
X-Received: by 10.202.203.198 with SMTP id b189mr17110087oig.39.1453099774425;
        Sun, 17 Jan 2016 22:49:34 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:903:9f9b:ce2a:20c0? ([2001:470:d:73f:903:9f9b:ce2a:20c0])
        by smtp.gmail.com with ESMTPSA id ur2sm12547544obc.11.2016.01.17.22.49.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Jan 2016 22:49:33 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <1453030101-14794-1-git-send-email-noltari@gmail.com>
References: <1453030101-14794-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 1/2] bmips: add BCM6358 support
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Sun, 17 Jan 2016 22:49:25 -0800
To:     =?ISO-8859-1?Q?=C1lvaro_Fern=E1ndez_Rojas?= <noltari@gmail.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jogo@openwrt.org, cernekee@gmail.com
Message-ID: <0BC6030C-7485-4193-B86D-E690BF673952@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51188
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

On January 17, 2016 3:28:20 AM PST, "Álvaro Fernández Rojas" <noltari@gmail.com> wrote:
>BCM6358 has a shared TLB which conflicts with current SMP support, so
>it must
>be disabled for now.
>BCM6358 uses >= 0xfff00000 addresses for internal registers, which need
>to be
>remapped (by using a simplified version of BRCM63xx ioremap.h).
>
>Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
>---
> arch/mips/bmips/setup.c                    | 10 +++++++++
>arch/mips/include/asm/mach-bmips/ioremap.h | 33
>++++++++++++++++++++++++++++++
> 2 files changed, 43 insertions(+)
> create mode 100644 arch/mips/include/asm/mach-bmips/ioremap.h
>
>diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
>index 3553528..38b5bd5 100644
>--- a/arch/mips/bmips/setup.c
>+++ b/arch/mips/bmips/setup.c
>@@ -95,6 +95,15 @@ static void bcm6328_quirks(void)
> 		bcm63xx_fixup_cpu1();
> }
> 
>+static void bcm6358_quirks(void)
>+{
>+	/*
>+	 * BCM6358 needs special handling for its shared TLB, so
>+	 * disable SMP for now
>+	 */
>+	bmips_smp_enabled = 0;
>+}

That part looks good.

>+
> static void bcm6368_quirks(void)
> {
> 	bcm63xx_fixup_cpu1();
>@@ -104,6 +113,7 @@ static const struct bmips_quirk bmips_quirk_list[]
>= {
> 	{ "brcm,bcm3384-viper",		&bcm3384_viper_quirks		},
> 	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
> 	{ "brcm,bcm6328",		&bcm6328_quirks			},
>+	{ "brcm,bcm6358",		&bcm6358_quirks			},
> 	{ "brcm,bcm6368",		&bcm6368_quirks			},
> 	{ "brcm,bcm63168",		&bcm6368_quirks			},
> 	{ },

<snip>

>+
>+static inline int is_bmips_internal_registers(phys_addr_t offset)
>+{
>+	if (offset >= 0xfff00000)
>+		return 1;
>+
>+	return 0;

That should probably be refined to be looking at the SoC/CPU you are running on, using eventually of_machine_is_compatible on the SoC-specific compatible string. For instance, on 6368 and newer, the physical register offset moves to PA 0x1000_0000.

Thanks!

-- 
Florian
