Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 00:07:18 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:47741 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013884AbaKQXHPaa9ti (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Nov 2014 00:07:15 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id C0E6528BDDD;
        Tue, 18 Nov 2014 00:05:49 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qc0-f180.google.com (mail-qc0-f180.google.com [209.85.216.180])
        by arrakis.dune.hu (Postfix) with ESMTPSA id A51A428BDEA;
        Tue, 18 Nov 2014 00:05:44 +0100 (CET)
Received: by mail-qc0-f180.google.com with SMTP id i8so6037210qcq.25
        for <multiple recipients>; Mon, 17 Nov 2014 15:07:08 -0800 (PST)
X-Received: by 10.140.93.49 with SMTP id c46mr9050838qge.58.1416265628921;
 Mon, 17 Nov 2014 15:07:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.95.79 with HTTP; Mon, 17 Nov 2014 15:06:48 -0800 (PST)
In-Reply-To: <CAJiQ=7B6Xwz2iqqH4vEG8WzPOzHj7NHsuGWqq49uy-E34RHp4A@mail.gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
 <2911624.UJRs5QOPN5@wuerfel> <CAJiQ=7BH8K=Q+JcWTKSfn6xAteOF4B6jahMu_qVd-FyZWD3pjA@mail.gmail.com>
 <3357597.nYlNZ6O0nJ@wuerfel> <CAJiQ=7B6Xwz2iqqH4vEG8WzPOzHj7NHsuGWqq49uy-E34RHp4A@mail.gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 18 Nov 2014 00:06:48 +0100
Message-ID: <CAOiHx=kutuOw4kTukm3FvSS-Fwah_yF2byDQFdpM9YQCn6x93g@mail.gmail.com>
Subject: Re: [PATCH V2 22/22] MIPS: Add multiplatform BMIPS target
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44256
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

On Mon, Nov 17, 2014 at 10:21 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
> Currently the bootloader is responsible for decompressing the image.
> On STB the bootloader typically loads a gzipped ELF file; on DSL/CM
> the bootloader unpacks a custom image format containing an
> LZMA-compressed kernel in some form.  So we would be
> double-compressing the same kernel in this scheme.

For the latter I use a patch[1] for mips head.S that detects if
there's a dtb appended to the vmlinux.bin, which would be trivial to
adapt to what the well-defined (b)mips interface expects. Of course
then there is no board detection at all, but I think that's an
acceptable trade off.


Jonas

[1] http://git.openwrt.org/?p=openwrt.git;a=blob;f=target/linux/brcm63xx/patches-3.14/366-MIPS-add-support-for-vmlinux.bin-appended-DTB.patch;h=344e78b5b41e03bff5f3d1f9cce1e8e2cb1a9368;hb=HEAD
