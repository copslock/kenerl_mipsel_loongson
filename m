Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 19:54:43 +0100 (CET)
Received: from mail-qc0-f179.google.com ([209.85.216.179]:59115 "EHLO
        mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007226AbaKZSyllUJjN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 19:54:41 +0100
Received: by mail-qc0-f179.google.com with SMTP id c9so2481754qcz.38
        for <multiple recipients>; Wed, 26 Nov 2014 10:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hexsR2KF3M81gipg6QHYIBnRjW9GSvfguKQxnlm5huM=;
        b=n+aEa+h6AhweFCuXRHuDAhbKGZLfQvxSCCCBoAkvCzLNDDZFrTyRj3uNC5/+mpPzPL
         QSgRtERr2wLaTYZumlemE/Ih3QTZyCBrBD9FzhiAlmT1oTqlrbKBko7IFc2GfNRtsVOm
         A0iSE1ThxykfRRcWRN9Xk+EBj+1XzhDnetIpB2UUAJWgLT9tsxNU1ZC/z9Ab5t3vggR6
         QGV3U4gIgmpeUNdiLZrrpsuuY941sTMdBQE396/QbO0EC0XaQ5aCi7iJB2eA5q6KSdUL
         PAWVR6AivyFsR1LGSboxGvTEWJ75W9NGad7jGb31hCBtNDc6auDSND9ZRebfsZTVEzyj
         qeDw==
X-Received: by 10.140.102.169 with SMTP id w38mr47077016qge.95.1417028075916;
 Wed, 26 Nov 2014 10:54:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Wed, 26 Nov 2014 10:54:15 -0800 (PST)
In-Reply-To: <CAOiHx=k_4r=jtQdi0ABvfKAw0JtHY9Z46pVUfetDmKz4d0XoFQ@mail.gmail.com>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
 <1416796846-28149-7-git-send-email-cernekee@gmail.com> <CAOiHx=ntm7AO5BU2Ge0JDC5nDgXSZwQDm05s5VTM8mLqYmCZRw@mail.gmail.com>
 <CAJiQ=7CvpFWxDY1uad2bZz8MBG0Mvg2Jx8WBp6gHi-kD4TDvXA@mail.gmail.com>
 <CAOiHx=m+At9u=eepphG89kcusOKbBi1qqxT8k-Qyx-OMdMAJKw@mail.gmail.com> <CAOiHx=k_4r=jtQdi0ABvfKAw0JtHY9Z46pVUfetDmKz4d0XoFQ@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 26 Nov 2014 10:54:15 -0800
Message-ID: <CAJiQ=7DXQX8h-1+K4-NSWjFqmr8nDCU62KzcyKKXiuvLUSHpEg@mail.gmail.com>
Subject: Re: [PATCH V3 06/11] irqchip: bcm7120-l2: Change DT binding to allow
 non-contiguous IRQEN/IRQSTAT
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Brian Norris <computersforpeace@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Wed, Nov 26, 2014 at 2:25 AM, Jonas Gorski <jogo@openwrt.org> wrote:
> On Wed, Nov 26, 2014 at 10:45 AM, Jonas Gorski <jogo@openwrt.org> wrote:
>> As far as I can see, we have three distinct layouts here:
>>
>> a) An arbitrary number of 32-bit Mask/Status-pairs (3384/6838). No per
>> thread support (well, not sure about 60333).
>>
>> b) An arbitrary length (32 to 128 bit) Mask register, followed by a
>> same length Status register (63xx except 63381, 6818, 6828); repeated
>> for each thread.
>>
>> c) A single arbitrary length (currently only 128 bit) Status register,
>> followed by per thread same length Mask registers (63381).
>>
>> On a first glance this could translate to three distinct
>> drivers/compatible properties, where each expects different reg = <>;
>> contents.
>>
>> For a), it should be enough to expand the current 7120-l2 driver to
>> accept/use more than one 0x8 length register, which should simplify
>> the register map setup.
>>
>> For b) we could add a a new compatible name (maybe bcm6358-l2, because
>> that was AFAICT the first one with blocks) that will use the 8 to 32
>> byte length regs (one for each block). For now we could ignore the SMP
>> capability of it and make it a variant of the 7120-l2 driver, and when
>> we add SMP support, split it into a second different driver if we want
>> to avoid having all the spinlock for register accesses even for a).
>>
>> We could then even easily document/add the extra block registers /
>> interrrupts in documentation / the dtsi files before actually
>> supporting them, because we only have a fixed amount of regs/irqs to
>> expect in the !SMP case and can easily ignore the extra
>> registers/interrupts.
>>
>> For c) we could add a a third compatible name (bcm63381-l2), also with
>> its own setup routine. I would guess it doesn't matter if both
>> thread's irqstatus register pointers point to the same region.
>
> This split-up is especially tempting to me after I had a closer look
> at the current 7120-l2 driver, which already accepts more than one
> interrupt, but uses it in a different way. So even if we try to make
> it very flexible with only one compatible property,
>
>    reg = <irqstatus0 irqmask0 irqstatus1 irqmask1>;
>    interrupts = <irq0>, <irq1>;
>
> Could then mean either irq0 is for interrupts 0..31 (mask/status0) and
> irq1 for interrupts 32 .. 64 (mask/status1), or irq0 is for interrupts
> 0..31 on cpu0, and irq1 is for interrupts 0..31 on cpu1, and then
> would require an additional property to tell them apart, for which we
> then also could just use a different compatible name, and have (IMHO)
> a lot less headache.  (I wonder why we couldn't just have had more
> than one instance of 7120-l2 in the dts for the first case)

I don't think we've used this driver to implement the first case yet.

The initial use of the driver was for the BCM7xxx IRQ0 block, which is
wired up according to the ASCII art diagram in
Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
.  i.e. different sets of bits in a single irqstatus0/irqmask0 pair
map to different parent IRQs.  The bits handled by each parent IRQ are
indicated in the brcm,int-map-mask property.

And now on BCM3384, of course, we're seeing the output from two 32-bit
irqstatus/irqmask words ORed together into a single parent IRQ, for
periph_intc.  The other instances do have their own DT nodes.
