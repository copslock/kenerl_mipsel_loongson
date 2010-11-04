Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2010 16:20:28 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:50160 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491871Ab0KDPU0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Nov 2010 16:20:26 +0100
Received: by gxk25 with SMTP id 25so1579543gxk.36
        for <multiple recipients>; Thu, 04 Nov 2010 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=mRkTiy6c6468jbBa7c6gDYHXozw/zp+y1mwe1qP7Ye4=;
        b=j3pPc7/82aKgGnlTcjONnXWpXXTC/z1kieWjJjokxHOh6QG/OKS9ugZLwzjP+v7XCx
         QPLX/TXhQeXmRK9L68uJP7s6+UdNJOROMB40aUOM9xadZ+uPqCuwCkIE2X5n4YGuZY/6
         +SVSnkXcmsJ2u5wPX2tjbwIjz33S4vRQS73w4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=gLCqZRXY7GGb+3GXyWz5pcqO/1LtDbBVRz92vajvCFPmUKb9P3YNKut2dHcFHJfNtS
         GV1w1MLYCoJljoZVa8/Z6IX1Wq99yABn+cJUkJCXp7ObsCKzwsVmqONFX3c/AhHCAEXt
         ncptvSBnpyVbwRwuVHy5KhUgZLMha1wQevCuw=
MIME-Version: 1.0
Received: by 10.216.175.18 with SMTP id y18mr896336wel.30.1288884019221; Thu,
 04 Nov 2010 08:20:19 -0700 (PDT)
Received: by 10.216.63.195 with HTTP; Thu, 4 Nov 2010 08:20:19 -0700 (PDT)
Date:   Thu, 4 Nov 2010 23:20:19 +0800
Message-ID: <AANLkTinnya458ReBBaJtVFg3OP-XQE5MkeVnFT8zUeMN@mail.gmail.com>
Subject: [BUG] The Perf support of MIPS is broken for the upstream changes
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Deng Cheng

Just took a try to add the Perf support for Loongson but failed for
the skeleton of the Perf Support of MIPS was broken.

After some investigation, I have found several important changes have
been applied for the upstream Perf event, which has broken the Perf
support of MIPS.

Here lists several important changes:

1. e360adbe29241a0194e10e20595360dd7b98a2b3: irq_work: Add generic
hardirq context callbacks

    This commit has added "generic hardirq context
    callbacks": irq_work, which are designed particularly for NMI code that
    needs to interact with the rest of the system.

    Like ARM, MIPS performance counters do not raise NMI upon overflow,
    instead, they emit regular interrupts, so, simply remove the empty
    set_perf_event_pending() in perf_event.h and call irq_work_run() instead of
    perf_event_do_pend() is needed.

2. a4eaf7f14675cb512d69f0c928055e73d0c6d252: perf: Rework the PMU methods

   This has replaced the pmu::{enable,disable,start,stop,unthrottle} with
    pmu::{add,del,start,stop}, which has made the current implementation
    of Perf for MIPS completely broken, so, we also need to make related
    changes.

3. b0a873ebbf87bf38bf70b5e39a7cadc96099fa13: perf: Register PMU implementations

  The weak hw_perf_event_init() function is replaced by a new member:
event_init()
  of struct pmu().

You can track more upstream changes via the following command:

$ git log {kernel/perf_event.c,include/linux/perf_event.h}

Of course, at first, you may need to clone/pull a latest mainline kernel.

Regards,
Wu Zhangjin
