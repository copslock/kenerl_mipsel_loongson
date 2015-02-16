Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Feb 2015 08:35:30 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:59749 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009840AbbBPHf2Xzc9n convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Feb 2015 08:35:28 +0100
Received: by mail-lb0-f182.google.com with SMTP id f15so24592245lbj.13
        for <linux-mips@linux-mips.org>; Sun, 15 Feb 2015 23:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cIq+TLac34/qqn24SfJytreSnVuM7v2GXXzyNqiQ7gs=;
        b=pzfvt9lN+KdjKtzKhWR6ODX4lDdVcI+bnxZB36N/Q6ECfVjMnefzWZZjcgGclSABP1
         JR48TZJnDnMgp7VNvGh21v6npQWAybb9RyV/5wmYBP1Vxs7Hhdf1+Tm84hjHkRdBGS7w
         GAdCNMHNvFkpShYaDnR7yB6LK/2FiKFe8AGMnYok7Z+IDhMMjg+OcNYELE2nz+yWbk5m
         pPMSdDuvBnwKzAdEnGFuBEKdypdzKzH6CD0IBlHMf2dCkCCr7vFfgulFMqWzyH9z3BC9
         EYb9svB9fSSZ7/VTAKlmBjkIMqKyfFiwwfMFb5pqKRdReUzgunuBhwlSzGBg3tmsQPBy
         98uw==
MIME-Version: 1.0
X-Received: by 10.152.20.129 with SMTP id n1mr19903603lae.120.1424072123137;
 Sun, 15 Feb 2015 23:35:23 -0800 (PST)
Received: by 10.25.145.131 with HTTP; Sun, 15 Feb 2015 23:35:23 -0800 (PST)
Date:   Mon, 16 Feb 2015 08:35:23 +0100
Message-ID: <CACna6rx+3TbNfLmT1Br-JjhDnTQLrFFtVzfmid=yOdBfcOwHoA@mail.gmail.com>
Subject: Looking for an idea/workaround for using MIPS ioremap_nocache
 (__ioremap) in IRQ
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

Once I've hit
BUG_ON(in_interrupt());
when hacking PCI drivers locally on MIPS board. I see the problem but
don't know the solution.

1) I think "read" and "write" of struct pci_ops should be safe to call
in IRQ handler
2) In drivers/bcma/driver_pci_host.c we use ioremap_nocache

This causes a problem for boards with 2 PCI(e) cards. The base address
for the 2nd card is
#define BCMA_SOC_PCI1_CFG               0x44000000U
which doesn't allow MIPS to use KSEG1.

As the result forwardtrace looks like this:
1) ioremap_nocache
2) __ioremap_mode
3) __ioremap
4) get_vm_area
5) __get_vm_area_node
And then we can hit BUG_ON(in_interrupt());

Can you see any solution for this? Currently there isn't any mainline
code triggering this problem, but it would be nice to have everything
working anyway.


As one of workarounds I was thinking about mapping whole space early.
Unfortunately there are many possible registers (0xffff), few PCI
functions (0x30000), many possible PCI devices (0xf80000). It's way to
big space I guess to keep it mapped all the time.

-- 
Rafał
