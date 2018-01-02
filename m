Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 17:17:19 +0100 (CET)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:38261
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993096AbeABQRMjKJi1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 17:17:12 +0100
Received: by mail-io0-x241.google.com with SMTP id 87so45238342ior.5;
        Tue, 02 Jan 2018 08:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6N4GdDqzBxE6SE9OmJjkVUEkIcUo6+uKgcLDdsNptBk=;
        b=kk4N5k9ivBBz4qo63l8sScOolo6oqE2RnhpgumMXCtJLpbTFem85Dz7rrYGDPzXDk/
         G2aD5fA4PZXx9U6oZyeoMblJOTtP9PZR7Mu7UE8NU6SmEtREna6dkTMCWJQwOkwTlHaR
         EV+gmyUpCYjxX3T2RfMxovunhp/wicS7uSZEZAuCkkeZ9MdQ3wm8vFvwTwAdwlQc4Pb3
         92ZK+sBPsgdalZ+foCmpwnQdM4gVtPeKcxbauqAlfpL1yQkAgAETotjUaTJfUbmNdbe1
         MPkxIcpvawDO+ZDcjAIkmSewQzpBI68oabTxlS/tStj68W0jfQlKoHdsluIxnmrLf4oB
         9R8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6N4GdDqzBxE6SE9OmJjkVUEkIcUo6+uKgcLDdsNptBk=;
        b=cNTqgFV2DlqcCkzLQEmANEDRtXiVX7inNza5DxlYfPyDZls8qMkERDGXRLjRrYHnqN
         EZN+cZMFWD2MnzbIwLussHsQ+JYDn5vcU+q2vxE7XM8nV186XoFXmYAYZabP+UoiHoyQ
         fEHmsisL1QV1xflsi+RGDcFIlE7PJNRyOHzIL65kYt+ZxJUv3+ebTfFFQnteVBFzbWrR
         5bovSq8r5LvsbaabVeErFBo3O+0pEHRyjPF9eAPEitdInbtdeeWVppRkKcjbHqIi33xy
         SQOP67omafN6WEBY9ktzmc6dETI/bR90kJoMIhm5SnT0emW6MXwQIUPWmoRNcs36Sfcb
         E/mQ==
X-Gm-Message-State: AKGB3mLZGk9bs+ijfXDIsPT1CIyIv9qoIah6ugN+woVKs9MCh+qNWZzx
        wWkBcmCgqx/78ZGeWloWSff3eYx8LSJxhGA9tWM=
X-Google-Smtp-Source: ACJfBouCp7bVvtIVOK+JOfpxQX7sHrObhZoaAKFiifLtIO145b1lzSKLyMnhzUaN6bP073OKkkA2Q6cGn/7sXY9T1yQ=
X-Received: by 10.107.107.13 with SMTP id g13mr760306ioc.263.1514909826410;
 Tue, 02 Jan 2018 08:17:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.144.208 with HTTP; Tue, 2 Jan 2018 08:17:05 -0800 (PST)
In-Reply-To: <828981e5-c23c-8dc4-55e4-23b65b33908b@linaro.org>
References: <20171228212954.2922-1-malat@debian.org> <828981e5-c23c-8dc4-55e4-23b65b33908b@linaro.org>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Tue, 2 Jan 2018 21:47:05 +0530
Message-ID: <CANc+2y5cEoqEkqEr9b-APApd42HXQczFWJfGv+MWPNRdWpQr7Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add efuse driver for Ingenic JZ4780 SoC
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zubair.Kakakhel@mips.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61849
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

Hi Srinivas,

On 2 January 2018 at 17:31, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 28/12/17 21:29, Mathieu Malaterre wrote:
>>
>> This patchset bring support for read-only access to the JZ4780 efuse as
>> found
>> on MIPS Creator CI20.
>>
>> To keep the driver as simple as possible, it was not possible to re-use
>> most of
>> the nvmem core functionalities. This driver is not compatible with the
>> original
>
> Can you explain a bit more on not able to re-use nvmem core?
>
> If you are referring to adding nvmem cell entires in sysfs, This should
> probably go in to nvmem core, rather that in individual providers.
> This is one of the feature my todo list, will try to come up with some thing
> soon.

We could not find a way to expose different sized segments using nvmem
framework. Do you have any pointers for this?
We were not aware of the fact that nvmem does not expose individual
cell entries in sysfs.

Regards,
PrasannaKumar
