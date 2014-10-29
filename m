Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 18:08:18 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:42976 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012115AbaJ2RIRC0onc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 18:08:17 +0100
Received: by mail-pa0-f50.google.com with SMTP id eu11so3522232pac.23
        for <linux-mips@linux-mips.org>; Wed, 29 Oct 2014 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zxTV/FEtwBprU9o2O77Dj7VfORGR/kz+lnpiT6BVttU=;
        b=UDZLZOE/VrzG4crqAeFaK3fVC6ygXfAu/92P8FJM+upbp18Ob0Z5jkL1Vmuk9rN/F9
         ApBAT2tKCMmfL/Yc9W6UAQJtwlYF7exWBCSINzNGxQ7Ccq/ooYB0KKTTagCUKWhdjSaq
         wT/qqxRb5i5b8rgKrkG5DgRh71HiqDySg1jWmYYc6OgGR6s22NUpQmcF6PXv/t1kEoyU
         NO35VUu64yai6dOIrYaeFt8+TIuyPRl91lBYUnLnVyp9MjglS23PuTweRdfkNOTLzh0g
         TSL+lA9anamF/LdrmJTDyuajQOp4riz8VIA6MkvNcGMJC6oJy0QEsrRvU0XXwg/J/LQn
         w2og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zxTV/FEtwBprU9o2O77Dj7VfORGR/kz+lnpiT6BVttU=;
        b=j6gwL/mfRkJLQRX5BMkgXjpkA44YFLnmSeng8UTpsrbFRyDbQdFfZm8k/sLG6H+swD
         1Jv4OEox9dWr1OR6CUBMujsJydCJDkjjn1knxXZxlGjy6J2pHjSegP4W9lhNGMyVy2Bx
         aa586bijSbNOkdTRS8WOA0zbbwXFOv/9nL5Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zxTV/FEtwBprU9o2O77Dj7VfORGR/kz+lnpiT6BVttU=;
        b=YuXgimjPq+uJc3fz0QQyPVLW6jxEw/FLqLnvYgu1vUnFVGAlBra3Xpfn/pmaUm6Z+z
         RTiomNfytigAbvUvTCtcshzFq+0hpuLeCfQDzfpk+iw9rNuCFcA8qYS1UG1Jx5A+Kg6P
         Zylx4i1J19p0lwr3IwNiFlPGK9qwV36igLfO4SwUYKFVp0SRl37MJPPiZtXsUqxmL85M
         oylHw+0NwkAyQ7MDq97dOOSuzFcTmTMElsI8uAGjHFd2SHoTmkdOYJQdS4/6pGBaUSPM
         reFpxCaIeU9QXheDdff3kQiLvEHexOcwOebs301yQuymFI/WPloVpWAkpy+nyq9MMKqp
         xdLg==
X-Gm-Message-State: ALoCoQnK/BLhvyKNWdFP4R8Js0C5ZsgHpdz2/SVSTEDRe8z9+/cp1q2aidhkLX3Qivk9RCrifju/
MIME-Version: 1.0
X-Received: by 10.67.29.177 with SMTP id jx17mr11734877pad.56.1414602490573;
 Wed, 29 Oct 2014 10:08:10 -0700 (PDT)
Received: by 10.70.118.170 with HTTP; Wed, 29 Oct 2014 10:08:10 -0700 (PDT)
In-Reply-To: <5450CAF9.3040902@imgtec.com>
References: <1414541562-10076-1-git-send-email-abrestic@chromium.org>
        <1414541562-10076-3-git-send-email-abrestic@chromium.org>
        <5450CAF9.3040902@imgtec.com>
Date:   Wed, 29 Oct 2014 10:08:10 -0700
X-Google-Sender-Auth: qvWeHwdp6N0IT_Kjuo74TkzRE4E
Message-ID: <CAL1qeaHEE43n6V-y6XECicPaoEAfTBpyfg8bYJZK0e-pSMAJjw@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] of: Add binding document for MIPS GIC
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Qais Yousef <qais.yousef@imgtec.com>
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
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43711
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

On Wed, Oct 29, 2014 at 4:09 AM, Qais Yousef <qais.yousef@imgtec.com> wrote:
> On 10/29/2014 12:12 AM, Andrew Bresticker wrote:
>>
>> +- reg : Base address and length of the GIC registers.
>>
>
> Also except for sead3, the base address should be properly reported by the
> hardware. The size is fixed (for a specific version of GIC at least - which
> is also reported by the hardware). So it would be nice to make this
> optional.

Even though this is usually probable, I'd prefer to leave this as
required, or at least "optional, but recommended".  I don't have a
very strong opinion on it though, but perhaps the device-tree folks
do?
