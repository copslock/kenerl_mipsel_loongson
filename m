Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 19:29:32 +0200 (CEST)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:46065
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992241AbdJLR3W3q1p5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2017 19:29:22 +0200
Received: by mail-it0-x243.google.com with SMTP id n195so8224489itg.0;
        Thu, 12 Oct 2017 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eYdOxEt3+GjfX5eN2W1fd2BB7t0c8CEW3fq9MpRkUEc=;
        b=oe/A7fLmsboF0yoJIV+Y26EldmLUPXbC2plN80VuNtXBDtozgw7ol3K0a3NyFpXwy5
         tX4M7JyeiEtKC6CY6VB8QKn6PhZStMciZcefuZTPE8p2q7cyh4ENXEf9ucyz+cQXA048
         LIt0lkraQiBfARCtedrLfdWo8K5vkX/2OSyAz7L9ibhKDDjQI6KadEIo81J6PQ4iz6L4
         LcAO497AO4ilpT9RrmS4hWJ9WuVseiRic+Rf5uKXRo1hLAOkpPIIO0oExpN0Qt/iNyNZ
         /sqq0qFTcJh3dfP9iPpJbrA5U869OTrGNJo92okIfnEzZyY/38k0o8Xa6ghHRjI5jRLX
         LkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eYdOxEt3+GjfX5eN2W1fd2BB7t0c8CEW3fq9MpRkUEc=;
        b=b9/8NQLVnthEzpDC6RG9+nGe7yhZowyJ0vmykg+jQrCo3DEQQ/lrIpIK7QzE8dS35k
         nCSIjavS1v7CDmqYBjjWV2Ae9Kj5505Fy7LsT5qwTiAk+6sSi9Pq2wz0RO4tLZAd9yYS
         mknSomg7EcEXy1GufFBWMBvmNWJaKdCfIVyeO0nL6l8F2PJDSHLON8dpU4g1CbNJMBlD
         jC60qK10PZpFwwYT5tc03CUybVr5c4mqp7Jus35XcW4MohHrHfYifJqOXcStFgWeUu9G
         t+JAyXR8txG/guumwbxwoiCO7bvxmTybyHEPT25u7InuW/Il9TuOFGYZVGAkEMp4/GQn
         Rxkg==
X-Gm-Message-State: AMCzsaX+clgfEjWb+F+C8+81ba9dGEM+sygmiC9DaWZ6U26SBy2d8upq
        afZEpS4uefITios2hCIytD4b4DHqvqyN2rmOVR4=
X-Google-Smtp-Source: AOwi7QAQxws9UiozZTn8MGC+FZs3mvYyPj0AofN4UBjrfKyiG3wY72uWYmxt1xSwt3C4U+/+HXp1cMuYlYfjdDQtIbo=
X-Received: by 10.36.205.67 with SMTP id l64mr4037623itg.101.1507829356158;
 Thu, 12 Oct 2017 10:29:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.3.77 with HTTP; Thu, 12 Oct 2017 10:29:15 -0700 (PDT)
In-Reply-To: <20171012143011.GA30173@gondor.apana.org.au>
References: <20170918140241.24003-1-prasannatsmkumar@gmail.com> <20171012143011.GA30173@gondor.apana.org.au>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Thu, 12 Oct 2017 22:59:15 +0530
Message-ID: <CANc+2y5VzWx+kLBO+=aWHLE5OGAGvuB_eVAzJ52ZVy79ad9Nxg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] crypto: Add driver for JZ4780 PRNG
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S . Miller" <davem@davemloft.net>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        Mathieu Malaterre <malat@debian.org>, noloader@gmail.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60388
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

Hi Herbert,

On 12 October 2017 at 20:00, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Mon, Sep 18, 2017 at 07:32:37PM +0530, PrasannaKumar Muralidharan wrote:
>> This patch series adds support of pseudo random number generator found
>> in Ingenic's JZ4780 and X1000 SoC.
>>
>> Create cgublock node which has CGU and RNG node as its children. The
>> cgublock node uses "simple-bus" compatible which helps in exposing CGU
>> and RNG nodes without changing CGU driver. Add 'syscon' compatible in
>> CGU node in jz4780.dtsi. The jz4780-rng driver uses regmap exposed via
>> syscon interface to access the RNG registers. CGU driver is not
>> modified in this patch set as registers used by CGU driver and this
>> driver are different.
>>
>> PrasannaKumar Muralidharan (4):
>>   crypto: jz4780-rng: Add JZ4780 PRNG devicetree binding documentation
>>   crypto: jz4780-rng: Add Ingenic JZ4780 hardware PRNG driver
>>   crypto: jz4780-rng: Add RNG node to jz4780.dtsi
>>   crypto: jz4780-rng: Enable PRNG support in CI20 defconfig
>
> Please indicate which patches are intended to go through the crypto
> trees.

From https://patchwork.linux-mips.org/patch/17162/ I expect the same.
Either all patches go via crypto tree or via mips tree.
The dtsi changes is not yet acked by MIPS / JZ4780 maintainer. Let's
wait for it.

Thanks,
PrasannaKumar
