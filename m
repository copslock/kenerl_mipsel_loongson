Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2014 00:22:41 +0200 (CEST)
Received: from mail-vc0-f171.google.com ([209.85.220.171]:58535 "EHLO
        mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007855AbaIBWWiAdLE9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Sep 2014 00:22:38 +0200
Received: by mail-vc0-f171.google.com with SMTP id id10so7824951vcb.2
        for <linux-mips@linux-mips.org>; Tue, 02 Sep 2014 15:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2VCfFC4LwgHc62LDU26pYoNU4fdGd38qKXVjmN5iY/4=;
        b=JdNf/6Ltfu1pFQ2+x1LSQgVGsHyfHUXBFU2VPUBHaZ16SH4qIaT55YCmSFxS9x8iam
         09LpeT3xD8Qhb1c2WvKhbJ5v4UVIsza54lLp+srVkhTwtTICj2GovfMpaXoq4vaUm0bI
         EBv+Vu4H1G2l3WyFsR083/PdDEq36Hl/jSsx1x7VHHpgC6OH5hashe86XXBlBx9OKafq
         PY+ogBeYN4MDHnSAzVhJQTB3NoHwb6zHus6N8TKRtlZtt+VIhd6JoRxt4aAcKiezzklI
         zIKLXsca1AFtiv18+/NJV+NyUVTf++dfY/c5GfTofPmUm6alkDzJQL2JEqkyb0etELvt
         donQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2VCfFC4LwgHc62LDU26pYoNU4fdGd38qKXVjmN5iY/4=;
        b=JGiSiPmGO+Pz+ynYZTzbyeIu9nFr5rR9FnT+KyUQtAuGrxckCRLm55M9lGxk1qo2d5
         zpu9CeImhEDcGHfTbchu+rvL0f972g52f8u0b8Hey1P69Cmvgjd858jwbRr6pFia/nul
         6SRdxvjGz2AozhNITWPMxue1gLqbTWJwXZb9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2VCfFC4LwgHc62LDU26pYoNU4fdGd38qKXVjmN5iY/4=;
        b=hNvzaBedxZ6thj8qF2Dt1JANPO1KQ3frJ2zzVkAnpPjoySAl0O5obqCPMswpjKW+0H
         lxwiqKatStwqr1b5msCcqfWW6cDQ/xHqNIIQ/SpmrXy9natWLR3z5+7hXQJ+HEyrmeNQ
         7JdBrLybMU4PYiYH+cOuaiTJuDFSmWXR+W7xFhTs0W93nQ7IqSM6P9XmzwXJndlP79XB
         47tHpX+CtJL4KlRGJGCUgUY/kFy5K31I4U+DC7808dqTeLtGR/6svZAMYoGvVDGAx5GB
         1YZPCrlJUZfl5KYmlGjl/ZnnBCvvhX01a2vLLRXntwkWaCz+cVQiPe1J/+NQpEE4tEa7
         m+wQ==
X-Gm-Message-State: ALoCoQlT+uN7uONPIEFOeFZIpDAeh4nmrubneT96j3XDHAtw62Zg1I+upBKzz1urrDgMwdxBjlf2
MIME-Version: 1.0
X-Received: by 10.52.87.144 with SMTP id ay16mr2269282vdb.43.1409696551798;
 Tue, 02 Sep 2014 15:22:31 -0700 (PDT)
Received: by 10.52.51.194 with HTTP; Tue, 2 Sep 2014 15:22:31 -0700 (PDT)
In-Reply-To: <CAL1qeaHryi7noBMiHxJPybByuvVts23reuiiQbV9mCQj+Ngqjw@mail.gmail.com>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
        <6179185.bNbDBEC6tl@wuerfel>
        <CAL1qeaEEo6-LZz3Kex7oPUfz=Z56nvKoDnqu051rGhhi3ZFTDQ@mail.gmail.com>
        <3341001.1Jsp173xyM@wuerfel>
        <CAL1qeaHryi7noBMiHxJPybByuvVts23reuiiQbV9mCQj+Ngqjw@mail.gmail.com>
Date:   Tue, 2 Sep 2014 15:22:31 -0700
X-Google-Sender-Auth: KKLUbcHnmdW7RGZPnnvfbdDl6Zs
Message-ID: <CAL1qeaETzZ3EaC8RVXm3K4GLZbknk5iMUR1X2naaAboon4s6fQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] MIPS: GIC: Move MIPS_GIC_IRQ_BASE into platform irq.h
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
X-archive-position: 42371
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

On Mon, Sep 1, 2014 at 5:08 PM, Andrew Bresticker <abrestic@chromium.org> wrote:
> On Mon, Sep 1, 2014 at 1:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Sunday 31 August 2014 11:54:04 Andrew Bresticker wrote:
>>> On Sat, Aug 30, 2014 at 12:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> > On Friday 29 August 2014 15:14:31 Andrew Bresticker wrote:
>>> >> Define a generic MIPS_GIC_IRQ_BASE which is suitable for Malta and
>>> >> the upcoming Danube board in <mach-generic/irq.h>.  Since Sead-3 is
>>> >> different and uses a MIPS_GIC_IRQ_BASE equal to the CPU IRQ base (0),
>>> >> define its MIPS_GIC_IRQ_BASE in <mach-sead3/irq.h>.
>>> >>
>>> >> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>> >>
>>> >
>>> > Why do you actually have to hardwire an IRQ base? Can't you move
>>> > to the linear irqdomain code for DT based MIPS systems yet?
>>>
>>> Neither Malta nor SEAD-3 use device-tree for interrupts yet, so they
>>> still require a hard-coded IRQ base.  For boards using device-tree, I
>>> stuck with a legacy IRQ domain as it allows most of the existing GIC
>>> irqchip code to be reused.
>>
>> I see. Note that we now have irq_domain_add_simple(), which should
>> do the right think in either case: use a legacy domain when a
>> nonzero base is provided for the old boards, but use the simple
>> domain when probed from DT without an irq base.
>>
>> This makes the latter case more memory efficient (it avoids
>> allocating the irq descriptors for every possibly but unused
>> IRQ number) and helps ensure that you don't accidentally rely
>> on hardcoded IRQ numbers for the DT based machines, which would
>> be considered a bug.
>
> Ah, ok.  It looks like add_simple() is what I want then.

Actually, never mind.  To re-use the existing GIC irqchip code I want
a legacy IRQ domain.
