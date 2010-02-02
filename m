Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 04:03:22 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:62696 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492213Ab0BBDDR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2010 04:03:17 +0100
Received: by vws3 with SMTP id 3so1476799vws.36
        for <multiple recipients>; Mon, 01 Feb 2010 19:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=l4W8h5ShC7VA6adPo88oGViBOwtN9EtYREtzTc7jvKI=;
        b=LNxb/lhiHI93LjMN1BDtzEq8+iIbdOIn5pLZQPPQ25gx25TblMCVH2WXgcr1WjCtqe
         PZeV7LwHDlv5LbDTtF7vrrh1nKL5EJOjmahyeajYzIFSmsEDYvbCc40WxvMGCUR4r4XJ
         5cus+cbaJ5FD4tVRvWbeVm3VqxT6jJA8rLlgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BSVCy4auHc0PZYhHZaEZei3W9d+wJXXjXmJ4vl3ZuWLb+AcJsxyu9nvk8lXkHV/0yn
         VFhSnVRuvSDJunbpjWhye+c6yCfvE3bjSA9vfmPrEIcIUzJSGKVWHA0OlRV5CoHPMTFM
         XIxeKgio2HDC1R9W7IFi4pf9m8CYPYeCGM18M=
MIME-Version: 1.0
Received: by 10.220.122.88 with SMTP id k24mr6961893vcr.19.1265079790189; Mon, 
        01 Feb 2010 19:03:10 -0800 (PST)
In-Reply-To: <1265015455-32553-1-git-send-email-wuzhangjin@gmail.com>
References: <1265015455-32553-1-git-send-email-wuzhangjin@gmail.com>
Date:   Mon, 1 Feb 2010 21:03:10 -0600
Message-ID: <b2b2f2321002011903m7a090481m52d84a664beb5468@mail.gmail.com>
Subject: Re: [PATCH urgent] MIPS: Fixup of the r4k timer
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     ralf@linux-mips.org, David VomLehn <dvomlehn@cisco.com>,
        mbizon@freebox.fr, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Feb 1, 2010 at 3:10 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
>
> From: Wu Zhangjin <wuzhangjin@gmail.com>
>
> As reported by Maxime Bizon, the commit "MIPS: PowerTV: Fix support for
> timer interrupts with > 64 external IRQs" have broken the r4k timer
> since it didn't initialize the cp0_compare_irq_shift variable used in
> c0_compare_int_pending() on the architectures whose cpu_has_mips_r2 is
> false.
>
> This patch fixes it via initializing the cp0_compare_irq_shift as the
> cp0_compare_irq used in the old c0_compare_int_pending().
>
> Reported-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

When applied to 2.6.33-rc6, this patch fixes the problem on my
RM7035C-based system.

Tested-by: Shane McDonald <mcdonald.shane@gmail.com>
