Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 04:18:42 +0200 (CEST)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:36067
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990644AbdFCCSPNIw0u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 04:18:15 +0200
Received: by mail-pf0-x242.google.com with SMTP id n23so14318034pfb.3
        for <linux-mips@linux-mips.org>; Fri, 02 Jun 2017 19:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:subject
         :in-reply-to:message-id:mime-version;
        bh=1aWGcoOZjvtvkBGjgq0s9fsyJGD1I+MyHcHyBR4zWOg=;
        b=ouzdWtKCHwuUarin1yma/DVoPB2CsqaxVuv8VNhWX0rMvEacz5TvTDek/k+5NNLQ8o
         k2LKhrfUylho3AemXDq/mbERaYd+lZIGgxe1bzryL4JjJ9R+Ri4aSwYH2Cg3WrEw5vbd
         OUgiKaNBUv6PXSfyFEBJpSfGxbxIm8pF30rUv5byprJqtilSxhll8rutpX7ZE2gtZ1zH
         EL5AqqiUVKTR9OA4h7gSQM+BhzS+Xl1Rx5bKvIk5615//5LcgP73voxY2mF75sDaAp/x
         Z5hZxE11O6uvI6+Xf4RyTLk4ZJey6lsbvNAau96qRgROE6Yg7RRNcEB+A18N+lZ3n3QY
         ryAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc
         :cc:subject:in-reply-to:message-id:mime-version;
        bh=1aWGcoOZjvtvkBGjgq0s9fsyJGD1I+MyHcHyBR4zWOg=;
        b=drXQ78YBzYlJwr63MuUobbcGw9k3fjNRdNydvddKeE9Dq/ivu4lOgDyYT0ScVQ4BYV
         d3k0oiJo6A6zGmmiG1ca5g++BdGRiN+TaZe37kI+uVMwerQ1k3qkpk6hahV5E07X+Svb
         VEGAvg5WV+RrOKVc8BYfuDbPA+knmmrK1WItUyG4sJcCQo/b8dHIqvomz4Qmv5ikMKF6
         NrhF9/Cfs/1KNY9T5+tktqqDd2YpLzCGIMcAgqD9Ckvsb7dtLqL4jhfNDdtrk9EyWNGP
         ON+2Bq8gipzTfSHSRQiU08DhbsOKGoF4GLctO+QE9JPC8XC5jTLrbIQ9soQm7yDq2VlV
         8UOw==
X-Gm-Message-State: AODbwcAuGU5ZdsROrqZ95PkqKsaIJqj7SOgmLdANYt8VH6DHJW3FF2rn
        lyxwEkMm86nAv8oB
X-Received: by 10.98.75.157 with SMTP id d29mr9730772pfj.135.1496456289413;
        Fri, 02 Jun 2017 19:18:09 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id c23sm37202311pfh.131.2017.06.02.19.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Jun 2017 19:18:08 -0700 (PDT)
Date:   Fri, 02 Jun 2017 19:18:08 -0700 (PDT)
X-Google-Original-Date: Fri, 02 Jun 2017 19:17:15 PDT (-0700)
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     matt.redfearn@imgtec.com
CC:     monstr@monstr.eu
CC:     ralf@linux-mips.org
CC:     liqin.linux@gmail.com
CC:     lennox.wu@gmail.com
CC:     ysato@users.sourceforge.jp
CC:     dalias@libc.org
CC:     davem@davemloft.net
CC:     linux-mips@linux-mips.org
CC:     linux-sh@vger.kernel.org
CC:     sparclinux@vger.kernel.org
CC:     geert@linux-m68k.org
CC:     linux-kernel@vger.kernel.org
CC:     linux-arch@vger.kernel.org
Subject:     Re: [PATCH 4/7] mips: Use lib/{ashldi3,ashrdi3,cmpdi2,lshrdi3,ucmpdi2}.c
In-Reply-To: <a870bfb8-a1c8-220e-460c-baa03b3fd554@imgtec.com>
Message-ID: <mhng-fc1d65cf-1943-4c73-8fae-b13ee8349d2f@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@dabbelt.com
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

On Wed, 24 May 2017 02:01:39 PDT (-0700), matt.redfearn@imgtec.com wrote:
> Hi Palmer,
> This patch doesn't quite match the subject, since it only removes the
> mips specific implementation of __ucmpdi2. The following patch removes
> all of the intrinsics that you added to lib/ from arch/mips/lib. I've
> built & boot tested this on a MIPS pistachio platform.
> Note that this patch will require rebasing on linux-next, since it will
> conflict with other changes in arch/mips/Kconfig
>
> Thanks,
> Matt
>
> [PATCH] MIPS: Use generic libgcc intrinsics
>
> These routines in arch/mips/lib/ are functionally identical to those
> recently added to lib/ so remove them and select the generic ones.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
>   arch/mips/Kconfig       |  5 +++++
>   arch/mips/lib/Makefile  |  2 +-
>   arch/mips/lib/ashldi3.c | 29 -----------------------------
>   arch/mips/lib/ashrdi3.c | 31 -------------------------------
>   arch/mips/lib/cmpdi2.c  | 27 ---------------------------
>   arch/mips/lib/libgcc.h  | 25 -------------------------
>   arch/mips/lib/lshrdi3.c | 29 -----------------------------
>   arch/mips/lib/ucmpdi2.c | 21 ---------------------
>   8 files changed, 6 insertions(+), 163 deletions(-)
>   delete mode 100644 arch/mips/lib/ashldi3.c
>   delete mode 100644 arch/mips/lib/ashrdi3.c
>   delete mode 100644 arch/mips/lib/cmpdi2.c
>   delete mode 100644 arch/mips/lib/libgcc.h
>   delete mode 100644 arch/mips/lib/lshrdi3.c
>   delete mode 100644 arch/mips/lib/ucmpdi2.c

Sorry about that, I'll take your version and submit a v2.
