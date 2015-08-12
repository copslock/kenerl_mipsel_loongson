Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 18:27:16 +0200 (CEST)
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33536 "EHLO
        mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012348AbbHLQ1MUxMSs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 18:27:12 +0200
Received: by igbpg9 with SMTP id pg9so115625630igb.0
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2015 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DAf5Wyqqr9wwC0032B3Xti7JQwnG50zAYorCgiezCxw=;
        b=fNqq66vzlXamCOKbyVLQiwBw46TDsIRz5zEHhCmCiHoivGOxZS8ZZ5v3yZ04RvCsNR
         CqkMM+BdkUgxgHwOKr2kBzGBic+TmJPByaXUShQLQLUcRJbrG3KPGAJ2Zdjof5CVZOuu
         MOkxl2JYXUJgvsJ9cg18W484ZrD8Jg/l0L5FHO4l59qee47HepbciemnmPsmuGD+sdmP
         knf8Df9Jo9UlypjCbi001sJsmVxoauaQCMQzSiZhmn06Xd3TlJO3uSSp8KTA0bBAeeef
         v8tSjwGpwm6uOgrc773vPBV6VesDObra9T/k/gnkbDW2ya/b1bS8Qb4oH8dbPXCJiD3b
         cNig==
X-Received: by 10.50.30.226 with SMTP id v2mr372197igh.11.1439396826690; Wed,
 12 Aug 2015 09:27:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.148.131 with HTTP; Wed, 12 Aug 2015 09:26:44 -0700 (PDT)
In-Reply-To: <1439363150-8661-32-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de> <1439363150-8661-32-git-send-email-hch@lst.de>
From:   Catalin Marinas <catalin.marinas@gmail.com>
Date:   Wed, 12 Aug 2015 17:26:44 +0100
Message-ID: <CAHkRjk6ykXd1=DLZ16dKiyrBXWmd80WC4gLyoN50JYigJG_-bQ@mail.gmail.com>
Subject: Re: [PATCH 31/31] dma-mapping-common: skip kmemleak checks for
 page-less SG entries
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, axboe@kernel.dk,
        Dan Williams <dan.j.williams@intel.com>, vgupta@synopsys.com,
        hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com,
        David Howells <dhowells@redhat.com>,
        Michal Simek <monstr@monstr.eu>,
        "x86@kernel.org" <x86@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        alex.williamson@redhat.com, grundler@parisc-linux.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-nvdimm@ml01.01.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <catalin.marinas@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: catalin.marinas@gmail.com
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

Christoph,

On 12 August 2015 at 08:05, Christoph Hellwig <hch@lst.de> wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/asm-generic/dma-mapping-common.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
> index 940d5ec..afc3eaf 100644
> --- a/include/asm-generic/dma-mapping-common.h
> +++ b/include/asm-generic/dma-mapping-common.h
> @@ -51,8 +51,10 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>         int i, ents;
>         struct scatterlist *s;
>
> -       for_each_sg(sg, s, nents, i)
> -               kmemcheck_mark_initialized(sg_virt(s), s->length);
> +       for_each_sg(sg, s, nents, i) {
> +               if (sg_has_page(s))
> +                       kmemcheck_mark_initialized(sg_virt(s), s->length);
> +       }

Just a nitpick for the subject, it should say "kmemcheck" rather than
"kmemleak" (different features ;)).

-- 
Catalin
