Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 09:36:12 +0100 (CET)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:43779 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006779AbbCCIgLVjLwg convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Mar 2015 09:36:11 +0100
Received: by igbhn18 with SMTP id hn18so24668858igb.2
        for <linux-mips@linux-mips.org>; Tue, 03 Mar 2015 00:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3tGrxSLFLPYICLVTDAdYZI7QAw+Q7djG2IF8UES06ec=;
        b=K4N9NNGf1k8esqvVjUC0skPOrrW2WeXUtknnS4nHp3dHz3+Z9tvScZJl1gku3F3yuW
         gyzUcsES/dyjlqJnfSCV3yE1QjpqbH2hBvq3O5Lr/4/e6naMw7AM2HSIGCH3Nn19hL3y
         0DvNdIS+1bHdbPga8Waip4zXEoqtkxTxzNxJNTibysjZDXrCV7RzSJ9XwpDcTFT4Fg/y
         CeVMNzI4UNmgpHdeGJ4vSM3/P9Rjpr6wUpCjVSuddGoZ2FgyzKy+Kqiw80KGH5Ve7fqs
         mD01XcLfZJwApP+rQHxDb4TvRWdsXW1sr7CjG5K5B++27gIhX8+bf6GBKCPAYOyZZ5jv
         pwZA==
MIME-Version: 1.0
X-Received: by 10.43.74.201 with SMTP id yx9mr212323icb.96.1425371765934; Tue,
 03 Mar 2015 00:36:05 -0800 (PST)
Received: by 10.107.134.207 with HTTP; Tue, 3 Mar 2015 00:36:05 -0800 (PST)
In-Reply-To: <CACna6rx+3TbNfLmT1Br-JjhDnTQLrFFtVzfmid=yOdBfcOwHoA@mail.gmail.com>
References: <CACna6rx+3TbNfLmT1Br-JjhDnTQLrFFtVzfmid=yOdBfcOwHoA@mail.gmail.com>
Date:   Tue, 3 Mar 2015 09:36:05 +0100
Message-ID: <CACna6rxYSmuzis9gR6c8nQP9zhafQ10NpSkB1ZAOZQdAOGSgcA@mail.gmail.com>
Subject: Re: Looking for an idea/workaround for using MIPS ioremap_nocache
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
X-archive-position: 46097
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

On 16 February 2015 at 08:35, Rafał Miłecki <zajec5@gmail.com> wrote:
> Once I've hit
> BUG_ON(in_interrupt());
> when hacking PCI drivers locally on MIPS board. I see the problem but
> don't know the solution.
>
> 1) I think "read" and "write" of struct pci_ops should be safe to call
> in IRQ handler
> 2) In drivers/bcma/driver_pci_host.c we use ioremap_nocache
>
> This causes a problem for boards with 2 PCI(e) cards. The base address
> for the 2nd card is
> #define BCMA_SOC_PCI1_CFG               0x44000000U
> which doesn't allow MIPS to use KSEG1.
>
> As the result forwardtrace looks like this:
> 1) ioremap_nocache
> 2) __ioremap_mode
> 3) __ioremap
> 4) get_vm_area
> 5) __get_vm_area_node
> And then we can hit BUG_ON(in_interrupt());
>
> Can you see any solution for this? Currently there isn't any mainline
> code triggering this problem, but it would be nice to have everything
> working anyway.
>
>
> As one of workarounds I was thinking about mapping whole space early.
> Unfortunately there are many possible registers (0xffff), few PCI
> functions (0x30000), many possible PCI devices (0xf80000). It's way to
> big space I guess to keep it mapped all the time.

Any idea/help about that?

-- 
Rafał
