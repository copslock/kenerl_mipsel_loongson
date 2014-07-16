Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 18:19:38 +0200 (CEST)
Received: from mail-wi0-f170.google.com ([209.85.212.170]:47925 "EHLO
        mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861125AbaGPQTgM6Niz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 18:19:36 +0200
Received: by mail-wi0-f170.google.com with SMTP id f8so5143937wiw.3
        for <multiple recipients>; Wed, 16 Jul 2014 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4KZ+E2q5JA69EQqVSmtVA3LSgGFuTovTYk9WiutSq/Q=;
        b=vKEpvuwHGALIQxHGMGD0ww+432FEELr7TKX7g5VAKkc1IYG7MU8JiIc/XODdoBHFC3
         ozHDDwweigRy+jxQVSJL9rUuLtdkmbKu62NpE/fW8Uu1+sUviJo2RDYrQFV1IYjWoGOG
         Uo2RNHLrTDDaAccMpj4ayt4BwLjVmN2HWacpiIjlERPQmHUaUWhpm5858WesVhFzUQLn
         tc0Ww2oHRR3p5aXNwReoJhIZ/HbfCYqoUfvp2VPepcrQuv65DjeeObPqBXPaQk7QPEJN
         cVQZM2JY2V3wtnUWPEEXcEe3RmGEEnZ9cgWwqI3yyPV1reTr+kKz5Avtk2ug3IUkj5Q7
         EpkQ==
X-Received: by 10.194.186.178 with SMTP id fl18mr36456324wjc.83.1405527570792;
 Wed, 16 Jul 2014 09:19:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.26.4 with HTTP; Wed, 16 Jul 2014 09:18:50 -0700 (PDT)
In-Reply-To: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 16 Jul 2014 18:18:50 +0200
Message-ID: <CAOLZvyEs_+R+urf-rhvpfZ+ieqhgg6zXuOtLLPUqKSaeNTzpNg@mail.gmail.com>
Subject: Re: [PATCH 0/4] mips: Add cma support to mips
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, catalin.marinas@arm.com,
        will.deacon@arm.com, Thomas Gleixner <tglx@linutronix.de>,
        mingo@redhat.com, hpa@zytor.com, Arnd Bergmann <arnd@arndb.de>,
        gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
        mina86@mina86.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41223
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

Hi,

On Wed, Jul 16, 2014 at 5:51 PM, Zubair Lutfullah Kakakhel
<Zubair.Kakakhel@imgtec.com> wrote:
> Here we have 4 patches that add cma support to mips.
>
> Patch 1 adds dma-contiguous.h to asm-generic
> Patch 2 and 3 make arm64 and x86 use dma-contiguous from asm-generic
> Patch 4 adds cma to mips.

I've given this a try on mips32, I haven't dug into this error yet, maybe
you have an idea:

[...]
Alchemy clocktree installed
cma: CMA: reserved 32 MiB at 0a000000
[...]
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-platform: EHCI generic platform driver
ehci-platform ehci-platform.0: EHCI Host Controller
ehci-platform ehci-platform.0: new USB bus registered, assigned bus number 1
CPU 0 Unable to handle kernel paging request at virtual address
00000000, epc == 807669b0, ra == 8041a970
Oops[#1]:
CPU: 0 PID: 1 Comm: swapper Not tainted
3.16.0-rc4-db1xxx-00062-g6c7bf71-dirty #1
task: 8bc34000 ti: 8bc1e000 task.ti: 8bc1e000
$ 0   : 00000000 10003c00 00000000 8bc1fb90
$ 4   : 80974f9c 00000000 00000093 00000093
$ 8   : 00000007 808d0000 00000010 00000093
$12   : 5f6d6f72 00000000 00000000 746e6f63
$16   : 80974f9c 00000001 8bc34000 808e6220
$20   : 00000000 80974fa0 80974f9c 8bc76380
$24   : 00000010 804091cc
$28   : 8bc1e000 8bc1fb80 80970000 8041a970
Hi    : 00000000
Lo    : 3a699d00
epc   : 807669b0 __mutex_lock_slowpath+0x4c/0x108
    Not tainted
ra    : 8041a970 dma_alloc_from_contiguous+0xb8/0x1ec
Status: 10003c03        KERNEL EXL IE
Cause : 0080800c
BadVA : 00000000
PrId  : 800c8000 (Au1300)
Process swapper (pid: 1, threadinfo=8bc1e000, task=8bc34000, tls=00000000)
Stack : 8bc77010 80790000 808f0000 8bc76380 80974fa0 00000000 8bc1fbd8 00000013
          00000006 80974f90 00000001 00000000 808e6220 00000000
80790000 8041a970
          8b752c83 80790adc 80974f90 00000001 00000000 808932d5
8bc1fcb4 808932d3
          00000fff 00001000 8b752e8c 000000d0 8bc77010 808f0000
808f0000 8bc76380
          00000000 80111d58 ff0a0210 ffffffff 8b752c80 00000003
8b752c80 8bc1fcb0
          ...
Call Trace:
[<807669b0>] __mutex_lock_slowpath+0x4c/0x108
[<8041a970>] dma_alloc_from_contiguous+0xb8/0x1ec
[<80111d58>] mips_dma_alloc_coherent+0xa4/0x148
[<801c11f8>] dma_pool_alloc+0xe0/0x1bc
[<804c755c>] ehci_qh_alloc+0x44/0xd4
[<804c8044>] ehci_setup+0x158/0x448
[<804cadfc>] ehci_platform_reset+0x74/0xd8
[<804af588>] usb_add_hcd+0x26c/0x79c
[<804caca0>] ehci_platform_probe+0x2c4/0x3ac
[<80417480>] platform_drv_probe+0x24/0x60
[<80415d8c>] driver_probe_device+0xec/0x244
[<80415fc4>] __driver_attach+0x7c/0xb4
[<80414190>] bus_for_each_dev+0x64/0xc0
[<80414cd0>] bus_add_driver+0xdc/0x1f8
[<804168d8>] driver_register+0xac/0x114
[<80901c7c>] do_one_initcall+0x174/0x240
[<80901ecc>] kernel_init_freeable+0x184/0x250
[<80761edc>] kernel_init+0x10/0x100
[<80108d88>] ret_from_kernel_thread+0x14/0x1c
