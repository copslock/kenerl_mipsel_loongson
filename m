Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 16:28:44 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:61352 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903424Ab2FOO2i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 16:28:38 +0200
Received: by ggcs5 with SMTP id s5so2549601ggc.36
        for <multiple recipients>; Fri, 15 Jun 2012 07:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gnfMKFK64IlMDFNoXV3AC2D80XsDCnuig1t4nOEEn9c=;
        b=XVgRQyUIeH/X48TClEHLWaqkvKg1C1M7c7/oTESc8mG0N9c2DDw1+19z0VZsVWwuUD
         qvvJS6+1HFnXv7SHSlKJJuWRAwFkw9DEs6asUpZfOwp8J3yviptCjAB4peBqOy1JjtK9
         /OuqYagzrewhmTO/neLoM1g6W731gunc5K+BRiJzbEu5UsPPgzoxaOv3du8tmJPES5Jf
         /V3WNPKNUZhXVdwibVkj2aWKzddV5Dvk6Q3RE7grv5zJhY2pSAW/9KlXrf2usFUsdtOl
         Lmv9MD8M+RRs0sfsGK+K0nxogdEEGuG56bJs5MOJ0rhshEnicXK74zLTF5N8TkCP1mFs
         6fMA==
Received: by 10.50.42.196 with SMTP id q4mr2160838igl.28.1339770511466;
        Fri, 15 Jun 2012 07:28:31 -0700 (PDT)
Received: from mars ([159.226.43.42])
        by mx.google.com with ESMTPS id ga6sm1375778igc.2.2012.06.15.07.28.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 07:28:31 -0700 (PDT)
Date:   Fri, 15 Jun 2012 22:28:24 +0800
From:   LIU Qi <liuqi82@gmail.com>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH 10/14] drm/radeon: Make radeon card usable for Loongson.
Message-ID: <20120615142824.GA15800@gmail.com>
Reply-To: LIU Qi <liuqi82@gmail.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
 <1339747801-28691-11-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1339747801-28691-11-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33663
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

On Fri, Jun 15, 2012 at 04:09:57PM +0800, Huacai Chen wrote:
 > 1, Use 32bit DMA as a workaround.
 > 2, Read vga bios offered by system firmware.
 > 3, Handle io prot correctly for MIPS.
 > 4, Don't use swiotlb on Loongson machines.
 > 
 > Signed-off-by: Huacai Chen <chenhc@lemote.com>
 > Signed-off-by: Hongliang Tao <taohl@lemote.com>
 > Signed-off-by: Hua Yan <yanh@lemote.com>
 > ---
 >  drivers/gpu/drm/drm_vm.c               |    2 +-
 >  drivers/gpu/drm/radeon/radeon_bios.c   |   32 ++++++++++++++++++++++++++++++++
 >  drivers/gpu/drm/radeon/radeon_device.c |    5 +++++
 >  drivers/gpu/drm/radeon/radeon_ttm.c    |    6 +++---
 >  drivers/gpu/drm/ttm/ttm_bo_util.c      |    2 +-
 >  include/drm/drm_sarea.h                |    2 ++
 >  6 files changed, 44 insertions(+), 5 deletions(-)

Fix the following compiling warnings, please:

  CC      drivers/gpu/drm/drm_vm.o
drivers/gpu/drm/drm_vm.c: In function ¡®drm_do_vm_dma_fault¡¯:
drivers/gpu/drm/drm_vm.c:309: warning: passing argument 1 of ¡®virt_to_phys¡¯ makes pointer from integer without a cast
/home/liuqi/workspace/linux.git/arch/mips/include/asm/io.h:117: note: expected ¡®const volatile void *¡¯ but argument is of type ¡®long unsigned
int¡¯

  CC      drivers/gpu/drm/radeon/radeon_ttm.o
In file included from drivers/gpu/drm/radeon/radeon_ttm.c:36:
include/drm/ttm/ttm_page_alloc.h:81: warning: ¡®struct device¡¯ declared inside parameter list
include/drm/ttm/ttm_page_alloc.h:81: warning: its scope is only this definition or declaration, which is probably not what you want
include/drm/ttm/ttm_page_alloc.h:82: warning: ¡®struct device¡¯ declared inside parameter list

LIU Qi
