Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 04:56:00 +0200 (CEST)
Received: from mail-la0-f41.google.com ([209.85.215.41]:53771 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822149AbaGaCzzk7W8q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2014 04:55:55 +0200
Received: by mail-la0-f41.google.com with SMTP id s18so1591980lam.28
        for <multiple recipients>; Wed, 30 Jul 2014 19:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=2xan4GtwugOEFn9cy2yz9hFarF0MEliPR08eoePG85s=;
        b=XYx4bFVK/N/L670Aj9Ck6zV7cK4mjAtlB8JeiMQ9c2TkJ7HHNjkC4lowZod2eg3AAb
         lY11W0agD7wf2fTYeDh9V4A1JW2aJApSMqVvbSRNhXAM7hDUFcCX22rRSe7lAOe6Gxi4
         w1BneFL80VVgSLG32sZweKwAUY7pg4N+A4F2f2U+6v5pb9H2MOR8cDLlgA3Np33XPpY6
         wgZI6o7dXE47VO2Psqe67kIGIbkpw/53uQOqfL8QCd9gELGl2XUI+3PH1NUd2DLSZRjH
         iWx1WgQW/HDJuN8gwn3FgJm8OthPVMO2k6Upg+mJNgRkEaWcPbb1qaQRuFiJcDdOvmqo
         pPvQ==
X-Received: by 10.112.84.75 with SMTP id w11mr8263742lby.24.1406775350037;
 Wed, 30 Jul 2014 19:55:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.200.39 with HTTP; Wed, 30 Jul 2014 19:55:29 -0700 (PDT)
From:   cee1 <fykcee1@gmail.com>
Date:   Thu, 31 Jul 2014 10:55:29 +0800
Message-ID: <CAGXxSxXGpRBJm+8sYfYXN4-20OYdmJ4FgBDnPknv9uMBN9zBsQ@mail.gmail.com>
Subject: Status about csum_partial optimization patches.
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        huacai chen <chenhuacai@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        markos.chandras@imgtec.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fykcee1@gmail.com
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

Hi all,

The csum_partial optimization patches have resided at patch-work for
quite a while:
1. http://patchwork.linux-mips.org/patch/6988/
2. http://patchwork.linux-mips.org/patch/7176/

Any comments about patch 1, can it be merged?

For patch 2, which is actually Loongson3 related and is modified from
ralf's patch: http://www.linux-mips.org/archives/linux-mips/2014-06/msg00023.html.
In patch 2, there are still two switches for Loongson 3A:
1. #define cpu_has_wsbh IS_ENABLED(CONFIG_CPU_LOONGSON3) in
cpu-feature-overrides.h
2. #if defined(_MIPS_ARCH_LOONGSON3A) in swab.h

It replaces the "#if defined(_MIPS_ARCH_LOONGSON3A)" with "#if
cpu_has_wsbh" in csum_partial.S, compared with ralf's original patch.
My question is using cpu_has_wsbh in macro is not suitable, hence it
is preferred to revert to the ralf's original patch?



-- 
Regards,

- cee1
