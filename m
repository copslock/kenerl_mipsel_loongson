Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Nov 2014 00:49:25 +0100 (CET)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:51414 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012622AbaKDXtXk70bu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Nov 2014 00:49:23 +0100
Received: by mail-pd0-f181.google.com with SMTP id y10so14674567pdj.12
        for <linux-mips@linux-mips.org>; Tue, 04 Nov 2014 15:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/99aDLPM9N1H9EzOGw5vxENJCv4cnI3rCD6e0vZeTi0=;
        b=amvMhH2m27PE9+oc1f907TgaUJidfBWmk79N1FowMDgC1wc3TYjlk/TjmXAuD+GMj5
         fC8OAZo4CjOGjThxsVaZMri0tf14qNtFnnUXVufSmlJgq+3zlffXX8VFhBpRNWo/ryDi
         G9oWzZfxGHMMiLiOiLz5jcefcKTySsw0KAEvjlQXdoVKtxBdsn67QWsqf5rZEwowji1L
         MoQnkhPreyzeXCZpViOVjMpipButKA4O8FP4MSsO/NddlMjp2YHTZV9A56Cz4SGu27wL
         3N1AYZFpvKP+pKsp3lb/FnlLiEkKSbIGF3g/xpbPBhDEvwiFVtObvbdIE/KF+0DtPfWg
         UP6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/99aDLPM9N1H9EzOGw5vxENJCv4cnI3rCD6e0vZeTi0=;
        b=RnReNXUStgnJTYPJJjWTLBxlHVoJDbTpJ5JtYT8OVhR9kZDBOmHrVGzhmqRVmqQ0kT
         j1S1elQDSlR0jVqTt1MSlKCzzKEITqAG6aGj7+q7kIEd/oIJFqFnHXaudRN3LwHGUD/D
         L5Cn7YJsJLydpC1IdGxmXBVdildDjvoTQODjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/99aDLPM9N1H9EzOGw5vxENJCv4cnI3rCD6e0vZeTi0=;
        b=g6TG4yhiaxH07OVuhN81VlXCaFdokxxdarIbOe2PJjpPSUwqqMSqodn9oPpPsERco1
         GCyi69JIZ4FRnie/9AWe2UL/upFUMeu63Wbg18kMO5gA/wHAuqM2aa1QGwZP79ZctDM+
         rjmiMGqlXyvoTon2kMmkGO8TIDLy77V5EzierPnXpXBSYZIKdO/wQ3CBM0MBOT19Cf34
         o1Z4DxlYd80GdG7f9sX7PS99iSobZCzdF1AA2K0bgdhJlRiCm9lOgUFPeBHPiqc01QTb
         fkQqtsZlGbn7A2KbN4cWiNFxudqzw506j6DHAm09F6sZMwyOc+6a84sDJtSHxSkqQ/Mr
         6FmA==
X-Gm-Message-State: ALoCoQnJHamVQ3Cw4FlGUTtCBbyQeUsnv+l83v4Phy98mYi1L4z2Usl2uZL70yoFvkUYn2fI7qAE
MIME-Version: 1.0
X-Received: by 10.68.255.133 with SMTP id aq5mr54264947pbd.0.1415144956970;
 Tue, 04 Nov 2014 15:49:16 -0800 (PST)
Received: by 10.70.118.170 with HTTP; Tue, 4 Nov 2014 15:49:16 -0800 (PST)
In-Reply-To: <20141029175142.GC26471@leverpostej>
References: <1414541562-10076-1-git-send-email-abrestic@chromium.org>
        <1414541562-10076-5-git-send-email-abrestic@chromium.org>
        <20141029175142.GC26471@leverpostej>
Date:   Tue, 4 Nov 2014 15:49:16 -0800
X-Google-Sender-Auth: 3ZIhdXobjDyVckOe5k3bldYwIYA
Message-ID: <CAL1qeaG0EpxdbV+QxAsdYgAWc19yWf8eLW0mfVxevQaJDxER6w@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] clocksource: mips-gic: Add device-tree support
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <Pawel.Moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43870
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

Hi Mark,

>> +static void __init gic_clocksource_of_init(struct device_node *node)
>> +{
>> +     if (of_property_read_u32(node, "clock-frequency", &gic_frequency)) {
>> +             pr_err("GIC frequency not specified.\n");
>> +             return;
>> +     }
>> +     gic_timer_irq = irq_of_parse_and_map(node, 0);
>> +     if (!gic_timer_irq) {
>> +             pr_err("GIC timer IRQ not specified.\n");
>> +             return;
>> +     }
>> +
>> +     __gic_clocksource_init();
>> +}
>> +CLOCKSOURCE_OF_DECLARE(mips_gic_timer, "mti,interaptiv-gic-timer",
>> +                    gic_clocksource_of_init);
>
> Your binding document expected the timer node under the GIC node, and it
> looks like this relies on GIC internals. Hwoever, this allows for people
> to put the timer node anywhere (and it turns out people are _really_ bad
> at putting things together as the binding author expected).
>
> It might be better if the GIC driver detected the sub node and probed
> the clocksource driver (or registered a platform device that the
> clocksource driver gets registered from). that could prevent some
> horrible issues with probe ordering and/or bad dts.

Probing the clocksource during probe of the irqchip doesn't work
because time-keeping isn't set up at the time.  Registering a platform
device for the timer pushes back GIC timer registration to later in
the boot process (assuming it now becomes a module_platform_driver)
and makes it rather non-parallel to how it's done in the non-DT case
(this could be changed, though IMO it's a lot of churn just to thwart
bad DT authors).

Probe ordering shouldn't be an issue because irqchips are probed
before clocksources.  Perhaps checking for the presence of GIC
(there's the global gic_present) and node->parent (to enforce the
parent-child relationship) would be sufficient?

Thanks,
Andrew
