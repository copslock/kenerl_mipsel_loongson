Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jun 2013 23:13:21 +0200 (CEST)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:53298 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827511Ab3FCVNT46d5a convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Jun 2013 23:13:19 +0200
Received: by mail-wi0-f176.google.com with SMTP id hr14so3131896wib.15
        for <multiple recipients>; Mon, 03 Jun 2013 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=FSWBnsgfQMuNm7XWJPdBDKgjF4vlq7ZfxoqdjToRNng=;
        b=xdE8MOi2eicfKxny/QnJ0I3FBqySdyTVgvWDjAWey3M2ufb8l9RM1zjLljo1bDko5G
         q3OupztMXvHuFniomIPF5hqqj2SdlBh1Na3DPqhrkmranZqG7HIfZQaUV4qNnJXAGAGr
         /jwye1mOwblePq5IUoAeqvefD1KhJyymHiaWr+7wlgauv1NDIKnSbkXtv9BYWGdi/YFu
         h+dzLZmk9Cyyt4QZ1kFTjpVNCZZH6908TUZcfMkKztEVYhWcaezhzqqsibuE52tQCTNI
         lvvDyfgy+sH3UHVB89vU4TPKHjrolsuAlN8pQVPnVVhYBkDHZFRIBjoUw2olDwA83tFv
         MqQA==
X-Received: by 10.194.243.129 with SMTP id wy1mr10356700wjc.47.1370293994487;
        Mon, 03 Jun 2013 14:13:14 -0700 (PDT)
Received: from lenovo.localnet (cpc24-aztw25-2-0-cust938.aztw.cable.virginmedia.com. [92.233.35.171])
        by mx.google.com with ESMTPSA id d5sm26249729wic.1.2013.06.03.14.13.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Jun 2013 14:13:13 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH 0/3] MIPS: BCM63XX: add SMP support
Date:   Mon, 3 Jun 2013 22:13:02 +0100
User-Agent: KMail/1.13.7 (Linux/3.8-2-amd64; KDE/4.8.4; x86_64; ; )
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
References: <1370273975-12373-1-git-send-email-jogo@openwrt.org>
In-Reply-To: <1370273975-12373-1-git-send-email-jogo@openwrt.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201306032213.03552.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Le lundi 03 juin 2013 16:39:32, Jonas Gorski a écrit :
> Most newer BCM63XX SoCs after BCM6358 use a BMIPS4350 CPU with SMP
> support. This patchset allows BCM6368 and BCM6362 to boot a SMP kernel
> (both tested, as well as (not yet upstreamed) BCM63268).
> 
> BCM6328 is skipped because the only SMP versions will be rejected by
> current code (they are BCM6329, which is treated as a totally
> unsupported chip).
> 
> BCM6358 is intentionally skipped because it shares a single TLB for
> both cores/threads, which requires implementing locking for TLB accesses,
> and ain't nobody got time for that.
> 
> The internal interrupt controller supports routing IRQs to both CPUs,
> and support will be added in a later patchset. For now all hardware
> interrupts will go to CPU0.
> 
> Totally unscientific OpenSSL benchmarking shows a nice ~90% speed
> increase when enabling the second core.
> 
> No idea about the FIXME in 1/3, never had a problem with it so I left it
> in place as to have it documented.

I successfully tested these on BCM6361 (6362-like) on top of the current mips-
for-linux-next, feel free to add my:

Tested-by: Florian Fainelli <florian@openwrt.org>

Thanks Jonas!
-- 
Florian
