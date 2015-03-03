Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 16:45:43 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:47278 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006898AbbCCPpm1rlO0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Mar 2015 16:45:42 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id B9B2028C085
        for <linux-mips@linux-mips.org>; Tue,  3 Mar 2015 16:45:25 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qa0-f52.google.com (mail-qa0-f52.google.com [209.85.216.52])
        by arrakis.dune.hu (Postfix) with ESMTPSA id A8BB12809CB
        for <linux-mips@linux-mips.org>; Tue,  3 Mar 2015 16:45:23 +0100 (CET)
Received: by mail-qa0-f52.google.com with SMTP id v10so28575004qac.11
        for <linux-mips@linux-mips.org>; Tue, 03 Mar 2015 07:45:37 -0800 (PST)
X-Received: by 10.55.21.220 with SMTP id 89mr12997578qkv.34.1425397537732;
 Tue, 03 Mar 2015 07:45:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.42.225 with HTTP; Tue, 3 Mar 2015 07:45:17 -0800 (PST)
In-Reply-To: <CACna6rx+3TbNfLmT1Br-JjhDnTQLrFFtVzfmid=yOdBfcOwHoA@mail.gmail.com>
References: <CACna6rx+3TbNfLmT1Br-JjhDnTQLrFFtVzfmid=yOdBfcOwHoA@mail.gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 3 Mar 2015 16:45:17 +0100
Message-ID: <CAOiHx=n3Xac0sAuLJ+cVz1zTR=iUCRGVDHq_O+MBBfJeTDHK2g@mail.gmail.com>
Subject: Re: Looking for an idea/workaround for using MIPS ioremap_nocache
 (__ioremap) in IRQ
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46099
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

On Mon, Feb 16, 2015 at 8:35 AM, Rafał Miłecki <zajec5@gmail.com> wrote:
> As one of workarounds I was thinking about mapping whole space early.
> Unfortunately there are many possible registers (0xffff), few PCI
> functions (0x30000), many possible PCI devices (0xf80000). It's way to
> big space I guess to keep it mapped all the time.

According to the code you only support dev numbers 0 and 1:

        if (dev >= 2 || !(bcma_pcie_read(pc, BCMA_CORE_PCI_DLLP_LSREG)
                          & BCMA_CORE_PCI_DLLP_LSREG_LINKUP))
                goto out;


so it should come out to 2 << BCMA_CORE_PCI_CFG_SLOT_SHIFT (=19), a one MiB map.

That doesn't seem too big to me, and should fit in one TLB slot for
mips. I have no idea about arm.


Jonas
