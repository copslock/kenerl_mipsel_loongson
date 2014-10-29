Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 17:56:12 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:59272 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012156AbaJ2Q4CL6zbK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 17:56:02 +0100
Received: by mail-pa0-f52.google.com with SMTP id fa1so3525593pad.39
        for <linux-mips@linux-mips.org>; Wed, 29 Oct 2014 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=AyiYQmRh8EecBe6nx8lsM2c5sqxAUUUhozFoPQaCM/g=;
        b=hqwjbr1iahY6uMsemmftvN0QTVL+vIFFX5GptLI4/mVHCZ+NFqO56ByM7+RXm9DAzh
         JNzf8bfp9EMQa3Y2SuiFXBzSGRbzPwM2xubPtS0OWvwC6d8StOJmxcbbe7E1n5liTO8x
         ptZOcWaAfsEk46/fRgDck6PhmjLwXFN16mSpdaTcNsmdwWLIviSffX5EKhRmJKCRzc/O
         MRNO49hvxLNPY/iJ52h+idT2scGTAR97cAOueFoOho5P8kJbmHFS9nTO1gxd60J5tPp1
         JyTtaHsez3f/u0IOhxHbFx8sePYjRexJVP9wBSIide8nFI3fLTPQTMTkQ9g8CXRZcoZ1
         LfsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=AyiYQmRh8EecBe6nx8lsM2c5sqxAUUUhozFoPQaCM/g=;
        b=jI25kDoT/U7TYgD9rFPixP46yo/E434mGX1gsqMORuLuDxCFVwd2FecmksWiKpn6Kp
         C40gQTboS+4TS9IxYasGqrhWhhaOKnDPpyE93syMJkNZUVbvz/oUsptIiI2ZW0p4iaoJ
         UKhbfrJvUhVjwW4dcReCip+LXomtz5pJKxfvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AyiYQmRh8EecBe6nx8lsM2c5sqxAUUUhozFoPQaCM/g=;
        b=HJZRMXYkCHXfke4xI+9G5ru+ckn/9Xv0pJl8eI75QicNkwCpbfpUtZk7WccqrYSpTE
         vNdlvIZiua3dQOKG+q5K9m4xjPA9PzFTZsDu8C1UlBOowCdI2gyKly6P1INjGSKQ6Lk5
         RgzU9xHwQxNJuITpHNQ3imsisoowvD+9CChKcjGIGRL/xaJgxNET4/2/T8YiJJscO+KJ
         Ped+cXJ+sCVfDw9EIe/POJR6cChF2ZsjeLYnzVIbmaBCo5R5ORR7WuEtmwxs1oUEnvQ2
         n3Yl4gbYxmcGTz0KBcsaQAGXJomJpcQeWiMsWMbA8EzDvuxqLLQYp/k/x+YJPtsjfeCU
         Rhfg==
X-Gm-Message-State: ALoCoQnbH+4QwImWdhCdoxb7FFhofDAyOMo1FtOHspEdx15iHb1JGlZX52mMLlqcwDssoQoJMcP5
MIME-Version: 1.0
X-Received: by 10.70.51.195 with SMTP id m3mr11568704pdo.27.1414601756123;
 Wed, 29 Oct 2014 09:55:56 -0700 (PDT)
Received: by 10.70.118.170 with HTTP; Wed, 29 Oct 2014 09:55:56 -0700 (PDT)
In-Reply-To: <5450B1B1.5070301@imgtec.com>
References: <1414541562-10076-1-git-send-email-abrestic@chromium.org>
        <1414541562-10076-3-git-send-email-abrestic@chromium.org>
        <5450B1B1.5070301@imgtec.com>
Date:   Wed, 29 Oct 2014 09:55:56 -0700
X-Google-Sender-Auth: aie1nVPGjk_dC-h9SLT8YI0mBG8
Message-ID: <CAL1qeaFeoKFbea7eiiXaw87PYUWO1JmP5xxdLLpW2RrFCprtZg@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] of: Add binding document for MIPS GIC
From:   Andrew Bresticker <abrestic@chromium.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43707
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

Hi James,

On Wed, Oct 29, 2014 at 2:21 AM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi Andrew,
>
> On 29/10/14 00:12, Andrew Bresticker wrote:
>>  - changed compatible string to include CPU version
>
>> +Required properties:
>> +- compatible : Should be "mti,<cpu>-gic".  Supported variants:
>> +  - "mti,interaptiv-gic"
>
>> +Required properties for timer sub-node:
>> +- compatible : Should be "mti,<cpu>-gic-timer".  Supported variants:
>> +  - "mti,interaptiv-gic-timer"
>
> Erm, I'm a bit confused...
> Why do you include the core name in the compatible string?
>
> You seem to be suggesting that:
>
> 1) The GIC/timer drivers need to know what core they're running on.
>
> Is that really true?

They don't now, but it's possible that a future CPU has a newer
revision of the GIC which has some differences that need to be
accounted for in the driver.

> 2) It isn't possible to probe the core type.
>
> But the kernel already knows this, so what's wrong with using
> current_cpu_type() like everything else that needs to know?
>
> 3) Every new core should require a new compatible string to be added
> before the GIC will work. You don't even have a generic compatible
> string that DT can specify after the core specific one as a fallback.

Yes, adding a generic compatible string would be a good idea.

> Please lets not do this unless it's actually necessary (which AFAICT it
> really isn't).

The point of this was to future-proof these bindings and I though that
CPU type was the best way to indicate version in the compatible
string.  This is also how it's done for the ARM GIC and arch timers.
Perhaps the best thing to do is to require both a core-specific
("mti,interaptiv-gic") and generic ("mti,gic") compatible string and
just match on the generic one for now until there's a need to use the
core-specific one.  Thoughts?
