Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 16:37:38 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:58429 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903435Ab2FOOhb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 16:37:31 +0200
Received: by ggcs5 with SMTP id s5so2560604ggc.36
        for <multiple recipients>; Fri, 15 Jun 2012 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6HFyqvirA94e1OLUoheHDdhLQZ0Fv/Ti2bIlzc8sCZQ=;
        b=bBYxFUmQuqBPXlZL90Ps2GnokgSuiuPBaI622lkj63+qSMJoiURtoKlLlOfjZlome4
         QJWFhC/LRk1sAAD9G+2IsZ1c3BpaDz3Hbl1sLj8UjiyVnstcr+HhMAkqPnFd5UZGqdXg
         hdUbaNqiAtl9TYip4ajHipM2pLq8MjMNoJN63bjSTNutorUZI7huIaP/srFE3pG8lyx5
         +vnnlV+Dffsfv7GctkE/Zaj4BPMZT/5bjWDl4/e0ED+Jmkpvow1xMovqIKnWmlXf5onq
         zvF+zghUvCzgdaLrXhBbgcXTXtxJrbvDTEfL4/A6T67aachQBaapFL9waKmrD5bvOgDr
         fudQ==
Received: by 10.50.184.165 with SMTP id ev5mr2179999igc.51.1339771045491;
        Fri, 15 Jun 2012 07:37:25 -0700 (PDT)
Received: from mars ([159.226.43.42])
        by mx.google.com with ESMTPS id v17sm2332725igv.7.2012.06.15.07.37.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 07:37:25 -0700 (PDT)
Date:   Fri, 15 Jun 2012 22:37:18 +0800
From:   LIU Qi <liuqi82@gmail.com>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH 14/14] MIPS: Loongson: Add a Loongson 3 default config
 file.
Message-ID: <20120615143718.GD15800@gmail.com>
Reply-To: LIU Qi <liuqi82@gmail.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
 <1339747801-28691-15-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1339747801-28691-15-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33666
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

On Fri, Jun 15, 2012 at 04:10:01PM +0800, Huacai Chen wrote:
 > Signed-off-by: Huacai Chen <chenhc@lemote.com>
 > Signed-off-by: Hongliang Tao <taohl@lemote.com>
 > Signed-off-by: Hua Yan <yanh@lemote.com>
 > ---
 >  arch/mips/configs/loongson3_defconfig |  704 +++++++++++++++++++++++++++++++++
 >  1 files changed, 704 insertions(+), 0 deletions(-)
 >  create mode 100644 arch/mips/configs/loongson3_defconfig

It is better to generate the defconfig file using `make savedefconfig`.

LIU Qi
