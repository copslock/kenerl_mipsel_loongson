Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 16:34:20 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:59024 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902243Ab2FOOeP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 16:34:15 +0200
Received: by ggcs5 with SMTP id s5so2556483ggc.36
        for <multiple recipients>; Fri, 15 Jun 2012 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sd/6jpH0uDG4Br5cl4Q1HoTVVMJJ6M5ifdE2hbP6e0E=;
        b=NwlFwwT7/jb+6QAi6TezlV8Cn2mVmEJY+lgyOzw3+dnfB2yow1mvMuwTn8wXYfSlzn
         yfLpagexYMunGK1YAKIS1ECE/B5mzPc6U/FriWzLzYIlTXK/pOOVbvgN8FmdEHiZk123
         IfbustG1p2PyVqObtJX8r3gj46Edd4iF7MgabjZXuiOR2P59VT2zO/q0KQ6qMfQkoHJW
         wg8GYHy9+45dViFnwWT+LZgEg71M9VJvWfVE40GvAsn9xyP0wRqjcUOU6B1z4rByej3B
         EtmtBT/5wZ/AdSukis6Dpix1N+eF2w6yQiDnYnfi+oVQsX6dDM1ippSNFiRDxDbXbV0Z
         GPpg==
Received: by 10.50.170.69 with SMTP id ak5mr2162865igc.47.1339770849369;
        Fri, 15 Jun 2012 07:34:09 -0700 (PDT)
Received: from mars ([159.226.43.42])
        by mx.google.com with ESMTPS id k4sm2297673igq.16.2012.06.15.07.34.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 07:34:08 -0700 (PDT)
Date:   Fri, 15 Jun 2012 22:34:02 +0800
From:   LIU Qi <liuqi82@gmail.com>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH 05/14] MIPS: Loongson 3: Add HT-linked PCI support.
Message-ID: <20120615143402.GC15800@gmail.com>
Reply-To: LIU Qi <liuqi82@gmail.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
 <1339747801-28691-6-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1339747801-28691-6-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33665
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

On Fri, Jun 15, 2012 at 04:09:52PM +0800, Huacai Chen wrote:
 > Loongson family machines use Hyper-Transport bus for inter-core
 > connection and device connection. The PCI bus is a subordinate
 > linked at HT1.
 > 
 > With UEFI-like firmware interface, We don't need PCI irq routing
 > fixup.
 > 
 > Signed-off-by: Huacai Chen <chenhc@lemote.com>
 > Signed-off-by: Hongliang Tao <taohl@lemote.com>
 > Signed-off-by: Hua Yan <yanh@lemote.com>
 > ---
 >  arch/mips/Kconfig                              |    9 ++
 >  arch/mips/include/asm/mach-loongson/loongson.h |    7 ++
 >  arch/mips/include/asm/mach-loongson/pci.h      |    5 +
 >  arch/mips/pci/Makefile                         |    1 +
 >  arch/mips/pci/fixup-loongson3.c                |   50 +++++++++++
 >  arch/mips/pci/ops-loongson3.c                  |  104 ++++++++++++++++++++++++
 >  6 files changed, 176 insertions(+), 0 deletions(-)
 >  create mode 100644 arch/mips/pci/fixup-loongson3.c
 >  create mode 100644 arch/mips/pci/ops-loongson3.c
Fix the following compiling warning please:

  CC      arch/mips/pci/fixup-loongson3.o
arch/mips/pci/fixup-loongson3.c: In function ¡®pcibios_map_irq¡¯:
arch/mips/pci/fixup-loongson3.c:42: warning: passing argument 1 of ¡®print_fixup_info¡¯ discards qualifiers from pointer target type
arch/mips/pci/fixup-loongson3.c:32: note: expected ¡®struct pci_dev *¡¯ but argument is of type ¡®const struct pci_dev *¡¯

LIU Qi
