Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Aug 2016 19:59:21 +0200 (CEST)
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35261 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992238AbcH1R7OUrkeA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Aug 2016 19:59:14 +0200
Received: by mail-yb0-f193.google.com with SMTP id b33so2945315ybi.2;
        Sun, 28 Aug 2016 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6RS43UB0aCIbaBORfCFFDMtV8z7cieAtKBHFsO6L/uM=;
        b=N8Z/SEn3CKt9AYcl85NURbDweMIzGMyHFCuSNFd9O8XqM/t3vjvqkQMt+zTFbUPbqn
         3ZrIMynL/FCWGy+upHojxnDFEmyhHEozXPNhjQeX3tfJtN/Q0SC47qew0AOhecj+K2lf
         VbfEo/csvQunQTIxFqfpS+nTNdq7Zntx4eeuEZbgbOEn6bCOnoFYDeblUJ/Q5wSM18Pw
         C6h5Ech3222Qm6aStLdN2mWdYdez4pC/N8cyqj/C+j4j8U80Un4SRwgssa1z/W4iovkD
         y/aiRPScaH5EMYI2MD+Zwq6Dr8JFv0KmSZPC3WSXz6mpUtS6mgc/xp42G5Avbf3XvuQI
         JEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6RS43UB0aCIbaBORfCFFDMtV8z7cieAtKBHFsO6L/uM=;
        b=NKSP8URuorCAvxDP4eKsFzVcIJT5ZyJZDmqtd0tPmg2SLU/KC6pIClwiixoI0A6hTq
         wqFwaEYr4GwvmdJFptuk1hnIvT4KdjxL2SlkD6HE97t1uNor3k5EPKM4A11oGj10LgHJ
         qJQKlGLLiZOAcNyAqa3gq+MIq6hXvGRVJaaD/MoOwtNPEoH/B59vRkoM5KFDA+7AgnvC
         a8DBGExFcUtFOeYgajNaJlGNzstll8VRquwkpxU/SoTWVTkvOFuX0XauVz+lNJw/tWZD
         4Yvdxew7EreWOz0r/UVaToVZMmrGK4VjqV29IfiHf1YLwJWo2I0nXqxNpxeGrkIdErLN
         O9HA==
X-Gm-Message-State: AE9vXwOkJOtuFQvZwocOQ0sVn0YVqms0LXbaY1hATNzAr1G8vCn8L3FouSg/D5XxqLTawPr3zuZEJBoFc1SX5A==
X-Received: by 10.37.24.193 with SMTP id 184mr293156yby.4.1472407148482; Sun,
 28 Aug 2016 10:59:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.36.213 with HTTP; Sun, 28 Aug 2016 10:59:08 -0700 (PDT)
In-Reply-To: <7a3874e2-069e-7bdf-2289-3364ec2c8cc4@cogentembedded.com>
References: <1472321697-3094-1-git-send-email-prasannatsmkumar@gmail.com>
 <1472321697-3094-4-git-send-email-prasannatsmkumar@gmail.com> <7a3874e2-069e-7bdf-2289-3364ec2c8cc4@cogentembedded.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sun, 28 Aug 2016 23:29:08 +0530
Message-ID: <CANc+2y6vqXTrCyU3HRUi0YybWzyvmVbCsB2r+8U44786QQp1sA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hw_random: jz4780-rng: Add RNG node to jz4780.dtsi
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     mpm@selenic.com, Herbert Xu <herbert@gondor.apana.org.au>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        boris.brezillon@free-electrons.com, harvey.hunt@imgtec.com,
        prarit@redhat.com, Florian Fainelli <f.fainelli@gmail.com>,
        joshua.henderson@microchip.com, narmstrong@baylibre.com,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

>>         cgu: jz4780-cgu@10000000 {
>>                 compatible = "ingenic,jz4780-cgu";
>> -               reg = <0x10000000 0x100>;
>> +               reg = <0x10000000 0xD8>;
>
>
>    I think lower case is preferred here.

Sure, will change.
