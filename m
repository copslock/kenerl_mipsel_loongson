Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2014 13:44:39 +0200 (CEST)
Received: from mail-la0-f43.google.com ([209.85.215.43]:43794 "EHLO
        mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834862AbaDOLofoROnN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Apr 2014 13:44:35 +0200
Received: by mail-la0-f43.google.com with SMTP id e16so6721176lan.2
        for <linux-mips@linux-mips.org>; Tue, 15 Apr 2014 04:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uzRtMOWFc9uHs9N1K8FHj2ZQvdFIxTUYw3R5Ofp9Qho=;
        b=XWqJoROCM0mIGb2kMNUkCwYNdpRceCIE6M3TU41tIFC5MjCwCNUp/sAr0177/Y0FNs
         jeTwhZ4ZcYrrH4WHh/EBKEnhzK0ZmIoE2PEwp8btwd2qmwj2nfKpSGYlrEVaWX+c+ZuL
         6R81f42ak4golOPCzIXHkkLV5qOqtQw6gydP+woUCciNZOCtTh94N9EbYnBUo1GFHxH7
         4Lqf16bwLnKr7pQyQh3230z/S9b7lbhwy33KRsRlk/ThCQlZI1KpUR9eUGqIAOUTgnI8
         VZbU9Lv14tOw8WiAZEU/bpxwPIWV9//VRxWeVkoPjf5n7u8lzTLzi3J9iata5RjcxPJo
         NGog==
MIME-Version: 1.0
X-Received: by 10.152.4.41 with SMTP id h9mr932852lah.43.1397562270165; Tue,
 15 Apr 2014 04:44:30 -0700 (PDT)
Received: by 10.152.198.166 with HTTP; Tue, 15 Apr 2014 04:44:30 -0700 (PDT)
In-Reply-To: <1397561816-9289-1-git-send-email-geert@linux-m68k.org>
References: <1397561816-9289-1-git-send-email-geert@linux-m68k.org>
Date:   Tue, 15 Apr 2014 13:44:30 +0200
X-Google-Sender-Auth: NSk1XDhfRi_r4cXuDNiz6IXYWA0
Message-ID: <CAMuHMdVTg2DAkvoSh=TkhFMs3WV-3FR0-VqfO6jd5c06aYTT6g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.15-rc1
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Tue, Apr 15, 2014 at 1:36 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v3.15-rc1[1] compared to v3.14[2].
>
> Summarized:
>   - build errors: +30/-3

> 30 regressions:

  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_ANDCOND' undeclared (first use in this function):  => 178:17,
100:16
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_AVPN' undeclared (first use in this function):  => 213:16, 99:16,
177:17
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_BULK_REMOVE' undeclared (first use in this function):  => 268:7
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_CEDE' undeclared (first use in this function):  => 272:7
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_CPPR' undeclared (first use in this function):  => 279:7
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_ENTER' undeclared (first use in this function):  => 262:7
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_EOI' undeclared (first use in this function):  => 280:7
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_EXACT' undeclared (first use in this function):  => 56:6
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_IPI' undeclared (first use in this function):  => 281:7
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_IPOLL' undeclared (first use in this function):  => 282:7
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_NOT_FOUND' undeclared (first use in this function):  => 211:8, 97:8
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_PARAMETER' undeclared (first use in this function):  => 155:10
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_PROTECT' undeclared (first use in this function):  => 266:7
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_PTEG_FULL' undeclared (first use in this function):  => 55:8
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_PUT_TCE' undeclared (first use in this function):  => 270:7
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_REMOVE' undeclared (first use in this function):  => 264:7
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_RTAS' undeclared (first use in this function):  => 287:7
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_SUCCESS' undeclared (first use in this function):  => 108:8, 229:8,
141:12, 75:8
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_TOO_HARD' undeclared (first use in this function):  => 246:12
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_XIRR' undeclared (first use in this function):  => 278:7
  + /scratch/kisskb/src/arch/powerpc/kvm/book3s_pr_papr.c: error:
'H_XIRR_X' undeclared (first use in this function):  => 283:7
  + /scratch/kisskb/src/include/linux/kvm_host.h: error: array
subscript is above array bounds [-Werror=array-bounds]:  => 436:19

powerpc-randconfig

  + /scratch/kisskb/src/drivers/cpufreq/powernv-cpufreq.c: error:
implicit declaration of function 'cpu_sibling_mask'
[-Werror=implicit-function-declaration]:  => 241:2

ppc64_defconfig

  + /scratch/kisskb/src/drivers/spi/spi-bfin5xx.c: error: implicit
declaration of function 'gpio_direction_output'
[-Werror=implicit-function-declaration]:  => 1102:4
  + /scratch/kisskb/src/drivers/spi/spi-bfin5xx.c: error: implicit
declaration of function 'gpio_free'
[-Werror=implicit-function-declaration]:  => 1130:3
  + /scratch/kisskb/src/drivers/spi/spi-bfin5xx.c: error: implicit
declaration of function 'gpio_request'
[-Werror=implicit-function-declaration]:  => 1097:4
  + /scratch/kisskb/src/drivers/spi/spi-bfin5xx.c: error: implicit
declaration of function 'gpio_set_value'
[-Werror=implicit-function-declaration]:  => 169:3

BF537-STAMP_defconfig

  + error: "__invalidate_icache_range" [drivers/misc/lkdtm.ko]
undefined!:  => N/A

xtensa-allmodconfig (fix available, IIRC)

  + error: "flush_icache_range" [drivers/misc/lkdtm.ko] undefined!:  => N/A

mips-allmodconfig (fix available, IIRC)

  + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  => N/A

x86_64-randconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvald
