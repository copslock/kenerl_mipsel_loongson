Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Sep 2014 02:08:32 +0200 (CEST)
Received: from mail-vc0-f180.google.com ([209.85.220.180]:38916 "EHLO
        mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007851AbaIBAIaluuS0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Sep 2014 02:08:30 +0200
Received: by mail-vc0-f180.google.com with SMTP id lf12so6155547vcb.39
        for <linux-mips@linux-mips.org>; Mon, 01 Sep 2014 17:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+DIwY3/X8IGGtH4oE7ClnsgwOxa9cwo+pfW5OvgM/5M=;
        b=V1kaMpctKvl9DO/8UZrGSud1vKQvUKrmcJq6dcfHE+lAs0a9NT+ORkeLXKcxlpzgcX
         X+EFX3IgxNSWKy0mQaVHCKP7aVqprkUkTlxAR7H2QoP3mMlc85yhw8mklqZuB75oAUg2
         hQ3YFYXcCZckPJfnEoCA7iorPQHR8Ln6Wudp8H9C39Vt9lhOflUZAQGoGOvTLldGhbX2
         imaIQPxnem79TwfQLPWhYr+rNx7z5GCfswRpYDK3bM0b5zRyuR9v82ody5mGJfpTXbgG
         iETH/Vy/sPlao+hxmnEb9Inb5bKbtCJ6vo97LMdYeN9KnLb3+8pwODKb12OdKsxhhnUK
         iBKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+DIwY3/X8IGGtH4oE7ClnsgwOxa9cwo+pfW5OvgM/5M=;
        b=ky39JHfDzbebc+vFL/FGk8hMmmzz0CXat188Vu0iuIsn3E8S3QQY+TXuzpe0o2FXzq
         naE2G6hXOpokw/EvXSY4aTcqA4KPsBwMuqHVUCZufxQcRAflm215RMddqK2zow5c60Sh
         39mWY8G3yg8j+aOyeZ6J7YQo/sSlYCJzKdk+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+DIwY3/X8IGGtH4oE7ClnsgwOxa9cwo+pfW5OvgM/5M=;
        b=O5AjZtItViqTi3fv/ovN5ScgJkF7c4a+1d8jpuLlAGq+nrOax9STa9txPyagfQyhLn
         n66CphA+RbzLNloHRTJr5xFFiV0WkCX8sr+isOgbTp/+gxvAhKG3r5zsYjDjy1Rrj23L
         yTNGBmXxwMtjW37ZSLfW/l+xT9UVt4T7YV2WpVHLAF49DvGYSCZW/Ohy8uG2pxwqdUcv
         mi8Ih8vsrNgnAbX+FFxsxY0ne1x4beC7Ct6jssmBu6ItUxDUQVwa9fbXm2uO+HPXele8
         EJY0O+3u97CxrOt6+16QjBnOSknXhTZ6eC0gY3vKqg4kA9+drLTK9jb/71OLK2zkYyct
         DTBg==
X-Gm-Message-State: ALoCoQnuhLoA0Tj2r7UlIQs1RwkoNbPRqL6CzePDQzT5jGr8M+yvRmquksQqQhi4GwIRcg6IFpzi
MIME-Version: 1.0
X-Received: by 10.220.168.210 with SMTP id v18mr27814132vcy.3.1409616504614;
 Mon, 01 Sep 2014 17:08:24 -0700 (PDT)
Received: by 10.53.5.133 with HTTP; Mon, 1 Sep 2014 17:08:24 -0700 (PDT)
In-Reply-To: <3341001.1Jsp173xyM@wuerfel>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
        <6179185.bNbDBEC6tl@wuerfel>
        <CAL1qeaEEo6-LZz3Kex7oPUfz=Z56nvKoDnqu051rGhhi3ZFTDQ@mail.gmail.com>
        <3341001.1Jsp173xyM@wuerfel>
Date:   Mon, 1 Sep 2014 17:08:24 -0700
X-Google-Sender-Auth: DZTy1xrnZZmObEJmvlurMLp9GHA
Message-ID: <CAL1qeaHryi7noBMiHxJPybByuvVts23reuiiQbV9mCQj+Ngqjw@mail.gmail.com>
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
X-archive-position: 42364
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

On Mon, Sep 1, 2014 at 1:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 31 August 2014 11:54:04 Andrew Bresticker wrote:
>> On Sat, Aug 30, 2014 at 12:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Friday 29 August 2014 15:14:31 Andrew Bresticker wrote:
>> >> Define a generic MIPS_GIC_IRQ_BASE which is suitable for Malta and
>> >> the upcoming Danube board in <mach-generic/irq.h>.  Since Sead-3 is
>> >> different and uses a MIPS_GIC_IRQ_BASE equal to the CPU IRQ base (0),
>> >> define its MIPS_GIC_IRQ_BASE in <mach-sead3/irq.h>.
>> >>
>> >> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> >>
>> >
>> > Why do you actually have to hardwire an IRQ base? Can't you move
>> > to the linear irqdomain code for DT based MIPS systems yet?
>>
>> Neither Malta nor SEAD-3 use device-tree for interrupts yet, so they
>> still require a hard-coded IRQ base.  For boards using device-tree, I
>> stuck with a legacy IRQ domain as it allows most of the existing GIC
>> irqchip code to be reused.
>
> I see. Note that we now have irq_domain_add_simple(), which should
> do the right think in either case: use a legacy domain when a
> nonzero base is provided for the old boards, but use the simple
> domain when probed from DT without an irq base.
>
> This makes the latter case more memory efficient (it avoids
> allocating the irq descriptors for every possibly but unused
> IRQ number) and helps ensure that you don't accidentally rely
> on hardcoded IRQ numbers for the DT based machines, which would
> be considered a bug.

Ah, ok.  It looks like add_simple() is what I want then.
