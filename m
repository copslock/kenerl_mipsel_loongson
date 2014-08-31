Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Aug 2014 20:42:23 +0200 (CEST)
Received: from mail-vc0-f179.google.com ([209.85.220.179]:51236 "EHLO
        mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006919AbaHaSmUbGfn5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Aug 2014 20:42:20 +0200
Received: by mail-vc0-f179.google.com with SMTP id hy4so4643388vcb.10
        for <linux-mips@linux-mips.org>; Sun, 31 Aug 2014 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qUALOJT1ItY0PP9Rg8AKVG5ilskq2kXoLVphNyVSDTY=;
        b=HfLlXg2keoDVciFkVleGFQeWOZy5pmNvuh1hLxX+wufCvHmxe4ANd6+5tidilJk411
         i/n8s+drnvIlYZibmC699/oIF2jsashHJdyuxpFPSrVlupFXLb+xh9O2NYIW2aZ/K992
         CLjfn+S9OgsVpH5z7Z+lM++DOJIVie5sn26RRlAPaPolVDDm3w2fkwb++3Ko9NP3uyhc
         jnTQibpxR03Q6zZCSL7KbyKByYUUDn2C0PEnI/0LjUncB1PU2O1JW00ZXaSvwxMHXv3M
         mwecdGpskzlv2xvXAXVj9DojJfbZRs0xYBGzqCWfUBtXVc8caJPTq7h27DBSSkCxmdHh
         QR2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qUALOJT1ItY0PP9Rg8AKVG5ilskq2kXoLVphNyVSDTY=;
        b=dOcNeLwjb+8JUxgL6PxzA4nfj/Rq3rh519HfZwQ7fA5U9YeLhdKZUJP6VrWEucvcUG
         QkEv4xaLO8Xd6tDC78oyHwwSktiGeVEoq63C/kBO/5ltu3ePedIaCshHiLbCt28wLOGz
         +PnXGMe2hlbpXS853RWjSHgCl/V4wZ6zuS3Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qUALOJT1ItY0PP9Rg8AKVG5ilskq2kXoLVphNyVSDTY=;
        b=PDJbPRpWALKuwlsBtiDKGaSfeOmvbjx+nSrUxStmKHz14TY5DSHky0JKPri/uGtanL
         oPUb6rU95TYKes5udBn3tNo5eZ8TflME8vnFI83Ir+Thnb4Qi6cICzKIkGO6Xcmcje5S
         no7k3K5285rSaqXMrsz5bmAzRiTYB95jhhrg8XBWIUFH9ztXUCQrBQc8beGw1RwlSxZH
         /0/byM7uJhl/PC5nF0IBJzHBoipsrKwipxZXN86xJoEwkKMNtcgK4PO5MPGU489cYR77
         nALrsL2Hatsc4JlsimCNd74F+ZkDY6zIl4JY/6wawj2itNxmycAuhdekXl/dC4vFfIjp
         5E3w==
X-Gm-Message-State: ALoCoQlgqKubzil3mk0kIqT433effXkHUAxiBEU/YDkfUCnfRCzNbz8iTQhJQRJVEeYgfYSnYNLD
MIME-Version: 1.0
X-Received: by 10.52.245.66 with SMTP id xm2mr16860021vdc.36.1409510534698;
 Sun, 31 Aug 2014 11:42:14 -0700 (PDT)
Received: by 10.53.5.133 with HTTP; Sun, 31 Aug 2014 11:42:14 -0700 (PDT)
In-Reply-To: <15153439.zUXECAnL7k@wuerfel>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
        <1409350479-19108-6-git-send-email-abrestic@chromium.org>
        <15153439.zUXECAnL7k@wuerfel>
Date:   Sun, 31 Aug 2014 11:42:14 -0700
X-Google-Sender-Auth: 1uhxDrVvTNDKicdPwdNXftoJHic
Message-ID: <CAL1qeaFFrQJLMyNQtcwWtrYSJ4=_Yf0zuYWPtCPsUu-6OrvKdw@mail.gmail.com>
Subject: Re: [PATCH 05/12] MIPS: GIC: Add device-tree support
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Sat, Aug 30, 2014 at 12:54 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 29 August 2014 15:14:32 Andrew Bresticker wrote:
>> Add device-tree support for the MIPS GIC.  With DT, no per-platform
>> static device interrupt mapping is supplied and instead all device
>> interrupts are specified through the DT.  The GIC-to-CPU interrupts
>> must also be specified in the DT.
>>
>> Platforms using DT-based probing of the GIC need only supply the
>> GIC_NUM_INTRS and, if necessary, MIPS_GIC_IRQ_BASE values and
>> call of_irq_init() with an of_device_id table including the GIC.
>>
>> Currenlty only legacy and vecotred interrupt modes are supported.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>>  arch/mips/include/asm/gic.h |  15 ++++++
>>  arch/mips/kernel/irq-gic.c  | 122 +++++++++++++++++++++++++++++++++++++++++++-
>>
>
>
> Can you move this to drivers/irqchip and use the IRQCHIP_DECLARE()
> macro to define the entry point?

Sure.  I was planning on doing this later, but I don't see why it
couldn't be done now though.
