Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 17:57:07 +0100 (CET)
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33940 "EHLO
        mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012181AbaJ2Q5AR-1f5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 17:57:00 +0100
Received: by mail-pd0-f179.google.com with SMTP id g10so3319945pdj.38
        for <linux-mips@linux-mips.org>; Wed, 29 Oct 2014 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vxvgwHr6Kyfbpp8/fI2YB1/AbzdJdrLYDUQ8gZFJzAE=;
        b=al26jcOTZCHN3yoMonPy1T7Fway98cv5Nm2qPPjnSwiJjz825A70885Z7kgk30A+YF
         K3QOe1fvpyyzkdMd8OA6OoGy2LAkd3NkndoFjv+p8fV3IKEZ/AHa5q+VMvyk4fjyt/6t
         urzZRMX9azz5YB2TjtaZRmtHFEQYAP8z7ue64hYnUvLHQIjQPX8jfsPnNgxz3VmXqe1Z
         Cpouy02vEy1RbPaq7+a1xf+YA+1pTZFHWf0+dEax5HsfREEqTmMvp/5tqXBnnBIdEtn3
         Y0AeoU0OyYqrf9ceHMaX4V0XtBN5f6Bmb4/DJpZijf/gTtr+Zg8INunwtaZPcfQ7smJR
         Ftig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vxvgwHr6Kyfbpp8/fI2YB1/AbzdJdrLYDUQ8gZFJzAE=;
        b=iTH+U9fJrXLMMFtKMmV+q6IBkS4n7/zfmCt5SB3TbNTlbNPom+BiMMf+pwPrNto3Jh
         cxsVEFWjSGZueAc4Z/+Q3nyHn3axFNu4b3HRL+TU9wbZUFXYjmORT2SBeLY8+AFrCXiJ
         BKjX4s3h7p2Nrlpi+zJhC2+tw1JIUp2V71KAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vxvgwHr6Kyfbpp8/fI2YB1/AbzdJdrLYDUQ8gZFJzAE=;
        b=K2VFTTsdnA1/Ld7Lnf9/mCU8fmhNm7KS0R/qYaOrafhozKdrC8qYoaQLnzdH337yfh
         zUHK5XWjSXEjLqDHZDIr1AfvPVk1mgvLzqtNiZHnZcJupTm/faTQQT6nklrfrXliFDT2
         B+t1XZJqfGPsNt6uvJC2Pk9zHq04ZnWMKsKbxRP+OmDaiCsopLLKdiIk1tHt95c+eF8u
         FUwcoMiP6ddCP+LhcyEGx3O34C7xC9GylAwZUVhCy1QJJUR3QTOHtrm9KMxHzNu1zJ/r
         Oc9SXYrBPTFYwdjr2MyMs7GTmX9tWgKI99mR0977iU2L1enmN7IR29Fag/RXq2W77ZFG
         va1Q==
X-Gm-Message-State: ALoCoQkwrstpiXRxQRIUK5+Cx92PAtVDPQ1qhb0ejURFll4/0HVUPLMgR/mKRnPUa7cfekRJelxZ
MIME-Version: 1.0
X-Received: by 10.67.23.164 with SMTP id ib4mr11859048pad.50.1414601814296;
 Wed, 29 Oct 2014 09:56:54 -0700 (PDT)
Received: by 10.70.118.170 with HTTP; Wed, 29 Oct 2014 09:56:54 -0700 (PDT)
In-Reply-To: <5450C915.9030600@imgtec.com>
References: <1414541562-10076-1-git-send-email-abrestic@chromium.org>
        <1414541562-10076-3-git-send-email-abrestic@chromium.org>
        <5450C915.9030600@imgtec.com>
Date:   Wed, 29 Oct 2014 09:56:54 -0700
X-Google-Sender-Auth: nf0vOtmAyBuo1dvklz0N-NDiFZk
Message-ID: <CAL1qeaGm1Ma=B-gJV2ovnLNYFooq6bv12rODq4d8cGtKLeNy-g@mail.gmail.com>
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
X-archive-position: 43709
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

On Wed, Oct 29, 2014 at 4:01 AM, Qais Yousef <qais.yousef@imgtec.com> wrote:
> On 10/29/2014 12:12 AM, Andrew Bresticker wrote:
>>
>> +- mti,available-cpu-vectors : Specifies the list of CPU interrupt vectors
>> +  to which the GIC may route interrupts.  May contain up to 6 entries,
>> one
>> +  for each of the CPU's hardware interrupt vectors.  Valid values are 2 -
>> 7.
>> +  This property is ignored if the CPU is started in EIC mode.
>> +
>
>
> Wouldn't it be better to have this in the reversed sense ie:
> mti,nonavailable-cpu-vectors? I think the assumption that by default they're
> all available unless something else is connected to them which is unlikely
> in most cases. It can be made optional property then.
>
> I don't have a strong opinion about it though.

Actually, I think I like the reversed sense as well.  Perhaps
"mti,reserved-cpu-vectors"?
