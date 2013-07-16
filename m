Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jul 2013 14:42:16 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44885 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833452Ab3GPMmMP-Hzx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Jul 2013 14:42:12 +0200
Received: from mail-vb0-x22b.google.com (mail-vb0-x22b.google.com [IPv6:2607:f8b0:400c:c02::22b])
        by mail.nanl.de (Postfix) with ESMTPSA id AE9E2402E1;
        Tue, 16 Jul 2013 12:41:47 +0000 (UTC)
Received: by mail-vb0-f43.google.com with SMTP id e12so418855vbg.16
        for <multiple recipients>; Tue, 16 Jul 2013 05:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Qd2KfSWC/0+OFIr/aR+aSIrL+vdrew/6RvRp3Yoftg4=;
        b=LJ2Z622tFFOyBVhOl2XErEd8Tx/37EfPGyB8f2tdZ8VjKlK7pdIhWloPLE0hFyKuih
         7I7TEhjxFrNnjLTd5h4xC4OPnKWMWgKqSXVYOSdPmajnOaZRlOOXcvObnQSb3jb56SL5
         ZI5opFCGrASOwdXwPsFZqlZvv0WX/rXAqdLkFIaD0Yb3DxzX1bEk+AKUgfuY6nATKKKr
         YDuMyQf1RCq2rbxmJ1UxSDwKCHyOTnuFnwergybPhwp+fa9QKgYeEPEef7Nki/ur01eR
         Kgle7QoIo3D6oxKpEQvP0iogh4HL8K9/qglRz1M1DoMnotG8JEfKnh+C6bzIhGob1ISc
         O4Lw==
X-Received: by 10.220.77.74 with SMTP id f10mr397720vck.1.1373978525510; Tue,
 16 Jul 2013 05:42:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.177.193 with HTTP; Tue, 16 Jul 2013 05:41:45 -0700 (PDT)
In-Reply-To: <CAGVrzcYsJrohQBoDG+TP6aXJcQ2b4Gb8JrLFnBM7uYTHycWF4Q@mail.gmail.com>
References: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
 <1372537073-27370-6-git-send-email-jogo@openwrt.org> <CAGVrzcYsJrohQBoDG+TP6aXJcQ2b4Gb8JrLFnBM7uYTHycWF4Q@mail.gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 16 Jul 2013 14:41:45 +0200
Message-ID: <CAOiHx==yKL_h4B1wHaoC4a5rbTetoxgVHf38AqtcqMdGQQ-GXQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] MIPS: bmips: merge CPU options into one option
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Tue, Jul 16, 2013 at 2:31 PM, Florian Fainelli <florian@openwrt.org> wrote:
> Hello Jonas,
>
> 2013/6/29 Jonas Gorski <jogo@openwrt.org>:
> [snip]
>
>> +config CPU_BMIPS
>> +       bool "Broadcom BMIPS"
>> +       depends on SYS_HAS_CPU_BMIPS
>> +       select CPU_MIPS32
>> +       select CPU_BMIPS3300 if SYS_HAS_CPU_BMIPS3300
>> +       select CPU_BMIPS4350 if SYS_HAS_CPU_BMIPS4350
>> +       select CPU_BMIPS4350 if SYS_HAS_CPU_BMIPS4380
>
> As you already made me notice privately, this should be:
>
> select CPU_BMIPS4380 if SYS_HAS_CPU_BMIPS4380

I'm currently preparing a V2 that will fix this, the missed squash
commit message in 6/10, and adds bcm47xx bmips selection (so that
Ralf's cputype patch won't break bcm47xx and bcm63xx anymore). I
marked the patches in patchwork accordingly.


Jonas
