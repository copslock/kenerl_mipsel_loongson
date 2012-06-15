Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 15:10:47 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:58225 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903433Ab2FONKh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 15:10:37 +0200
Received: by yhjj52 with SMTP id j52so2619646yhj.36
        for <multiple recipients>; Fri, 15 Jun 2012 06:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=r+KWbKZjjpy5RPvmV0UsEN9EKn69bIL3GbUMesO3eyA=;
        b=sHoL0GENyAZHiy2vHGV5DAGYup56OE84Hx8gqyQBLP8Sy7726M4k2QM+eDPuPyMMR1
         1Te+bPU1aQa546/dMkAnfwKVzSfs+sxu6U24eyddQtUpW93vvDEBD93xlkJFFaiI/sNn
         cOFQBFutHL2huNac9ROUEG7YZHBypEaG4JVjZks4gnxTPehYsOEdKmt7s1imzPUWuG14
         U+s81Dbh5uB+lS+uFZlIeRtGfkOlwRrvPGYiIhhQ5+Km/uqpegoZPWgMpFMCAMhX9WaR
         YyyCrpGufxkJbeOcfxSzj1QZrzXLYhTsBbI3t4Mgrvxn3Gg4L2ENWymgXswbFz2rgOKC
         66mQ==
Received: by 10.50.208.106 with SMTP id md10mr1756873igc.54.1339765830963;
        Fri, 15 Jun 2012 06:10:30 -0700 (PDT)
Received: from mars ([159.226.43.42])
        by mx.google.com with ESMTPS id z3sm1198149igc.7.2012.06.15.06.10.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 06:10:30 -0700 (PDT)
Date:   Fri, 15 Jun 2012 21:10:23 +0800
From:   LIU Qi <liuqi82@gmail.com>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH 00/14] MIPS: Add Loongson-3 based machines support.
Message-ID: <20120615131023.GA14191@loongson.cn>
Reply-To: LIU Qi <liuqi@loongson.cn>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33662
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

On Fri, Jun 15, 2012 at 04:09:47PM +0800, Huacai Chen wrote:
 > This patchset is for git repository git://git.linux-mips.org/pub/scm/
 > ralf/linux. Loongson-3 is a multi-core MIPS family CPU, it is MIPS64R2
 > compatible and has the same IMP field (0x6300) as Loongson-2. These
 > patches make Linux kernel support Loongson-3 CPU and Loongson-3 based
 > computers (including Laptop, Mini-ITX, All-In-One PC, etc.)
 > 
 > Huacai Chen(14):
 >  MIPS: Loongson: Add basic Loongson 3 CPU support.
 >  MIPS: Loongson 3: Add Lemote-3A machtypes definition.
 >  MIPS: Loongson: Make Loongson 3 to use BCD format for RTC.
 >  MIPS: Loongson: Add UEFI-like firmware interface support.
 >  MIPS: Loongson 3: Add HT-linked PCI support.
 >  MIPS: Loongson 3: Add IRQ init and dispatch support.
 >  MIPS: Loongson 3: Add serial port support.
 >  MIPS: Loongson: Add swiotlb to support big memory (>4GB).
 >  ata: Use 32bit DMA in AHCI for Loongson 3.
 >  drm/radeon: Make radeon card usable for Loongson.
 >  ALSA: Make hda sound card usable for Loongson.
 >  MIPS: Loongson 3: Add Loongson-3 SMP support.
 >  MIPS: Loongson 3: Add CPU Hotplug support.
 >  MIPS: Loongson: Add a Loongson 3 default config file.
 > 
 > Signed-off-by: Huacai Chen <chenhc@lemote.com>
 > Signed-off-by: Hongliang Tao <taohl@lemote.com>
 > Signed-off-by: Hua Yan <yanh@lemote.com>

The compiled kernel with your patches just doesn't boot. I tested with
the Loongson3 laptop and mini-itx. Do they need the newer PMON version
with UEFI-like interface support to boot the system?

LIU Qi
