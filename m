Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 10:39:29 +0200 (CEST)
Received: from mail-we0-f176.google.com ([74.125.82.176]:41062 "EHLO
        mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817540AbaGQIj1KGlkF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 10:39:27 +0200
Received: by mail-we0-f176.google.com with SMTP id q58so2094989wes.35
        for <multiple recipients>; Thu, 17 Jul 2014 01:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Sdl52+Y6RqCk2QGs+kgscah7vvv+LaCmnNAM8RS2aQg=;
        b=aqHPh1L/xNr78hbzOaOfG/ZkC1ucDvJd74PKgkvYzKjZim2f1a3+4CVKs/c2x9tW9D
         Hj1u2qi3a50Juz1HTWekPtGLXlymGgozz1OumfHGG49WFzX2oxGBLVRfUGQ6jXtyqFO5
         zhNiYaLPVDXfQdWsysrJnLbpnZ5lkBIdxzICWqcnPv35kevIDPW3Jh0YfUcIB+by57J4
         9ctzcTZ/Y3t0uqr6Cj7Jv7LcwZRT5N//aV+PKRRYTaqSOTv9PfWnd/7f6aS78vTo+Hcv
         bHXAz0cAl1Ku7qeQq2RFrZZJdGTu7nhJp0s7ouIdogQFm/y5C1kgl7kZwX5uIT1ySP7e
         PPBg==
X-Received: by 10.194.71.81 with SMTP id s17mr41971143wju.18.1405586360371;
 Thu, 17 Jul 2014 01:39:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.26.4 with HTTP; Thu, 17 Jul 2014 01:38:40 -0700 (PDT)
In-Reply-To: <CAOLZvyEs_+R+urf-rhvpfZ+ieqhgg6zXuOtLLPUqKSaeNTzpNg@mail.gmail.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com> <CAOLZvyEs_+R+urf-rhvpfZ+ieqhgg6zXuOtLLPUqKSaeNTzpNg@mail.gmail.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Thu, 17 Jul 2014 10:38:40 +0200
Message-ID: <CAOLZvyFjkuCzUkbb3SpJ25gKQoZ-Ken9Ri1YEckxdM6ETNyuSg@mail.gmail.com>
Subject: Re: [PATCH 0/4] mips: Add cma support to mips
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>, mina86@mina86.com,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Wed, Jul 16, 2014 at 6:18 PM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
> Hi,
>
> On Wed, Jul 16, 2014 at 5:51 PM, Zubair Lutfullah Kakakhel
> <Zubair.Kakakhel@imgtec.com> wrote:
>> Here we have 4 patches that add cma support to mips.
>>
>> Patch 1 adds dma-contiguous.h to asm-generic
>> Patch 2 and 3 make arm64 and x86 use dma-contiguous from asm-generic
>> Patch 4 adds cma to mips.
>
> I've given this a try on mips32, I haven't dug into this error yet, maybe
> you have an idea:
[ oops snipped ]

Nevermind.   Did a full recompile, the oops is gone.  Works fine now,
framebuffer driver and others are very happy.

Thanks!
        Manuel
