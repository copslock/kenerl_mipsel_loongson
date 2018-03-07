Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 21:25:57 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:52380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994730AbeCGUZjKB0n- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Mar 2018 21:25:39 +0100
Received: from mail-qk0-f176.google.com (mail-qk0-f176.google.com [209.85.220.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F9D2172D;
        Wed,  7 Mar 2018 20:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F9D2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
Received: by mail-qk0-f176.google.com with SMTP id o25so4227835qkl.7;
        Wed, 07 Mar 2018 12:25:32 -0800 (PST)
X-Gm-Message-State: AElRT7FsCLiVxkx/KbCEPxYH48LMEqfeber4JEN7cYH1RgCDRqalV1HK
        7ulwg06McbFq7p52Y128Hagsnh1Ng2kLYAOlvw==
X-Google-Smtp-Source: AG47ELtlm2AeL4C3LI/gUUupF7YwimrUYGspKFnOQtUVeQgE1KVOGNB7UEQWMyme/ov84v0HMA506fwQgTYrpNk/VrY=
X-Received: by 10.55.214.130 with SMTP id p2mr36145088qkl.304.1520454332003;
 Wed, 07 Mar 2018 12:25:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.178.131 with HTTP; Wed, 7 Mar 2018 12:25:11 -0800 (PST)
In-Reply-To: <CANc+2y63OnEkgXC43zDq3Fw34QxxTY3yz3Dag8fAE3muX7cpEw@mail.gmail.com>
References: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
 <20170918140241.24003-4-prasannatsmkumar@gmail.com> <20180306091932.GM4197@saruman>
 <CAL_JsqJiNpnVC7X=viKZRjEJBe8ZEp0mJLDKhPYKugoxpiQJNQ@mail.gmail.com> <CANc+2y63OnEkgXC43zDq3Fw34QxxTY3yz3Dag8fAE3muX7cpEw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 7 Mar 2018 14:25:11 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+8t2w-Vv47q-He_y=H5Sp0-SUASHQhv+wgYtBrOKeYfg@mail.gmail.com>
Message-ID: <CAL_Jsq+8t2w-Vv47q-He_y=H5Sp0-SUASHQhv+wgYtBrOKeYfg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] crypto: jz4780-rng: Add RNG node to jz4780.dtsi
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Miller <davem@davemloft.net>,
        Paul Cercueil <paul@crapouillou.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Mathieu Malaterre <malat@debian.org>, noloader@gmail.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh+dt@kernel.org
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

On Wed, Mar 7, 2018 at 8:54 AM, PrasannaKumar Muralidharan
<prasannatsmkumar@gmail.com> wrote:
> Hi Rob,
>
> On 6 March 2018 at 19:25, Rob Herring <robh+dt@kernel.org> wrote:
>> On Tue, Mar 6, 2018 at 3:32 AM, James Hogan <jhogan@kernel.org> wrote:
>>> On Mon, Sep 18, 2017 at 07:32:40PM +0530, PrasannaKumar Muralidharan wrote:
>>>> Add RNG node to jz4780 dtsi. This driver uses registers that are part of
>>>> the register set used by Ingenic CGU driver. Use regmap in RNG driver to
>>>> access its register. Create 'simple-bus' node, make CGU and RNG node as
>>>> child of it so that both the nodes are visible without changing CGU
>>>> driver code.
>>
>> The goal should be to avoid changing the DT (because the h/w hasn't
>> changed), not avoid changing a driver.
>
> Please have a look at the discussion happened at
> https://patchwork.linux-mips.org/patch/14094/. Looks like there is a
> difference in though process between you and mips folks. I am not an
> expert in DT so please suggest me the correct way to go about this.

Those comments are correct too.

Simply, there is no reason you have to add a rng node to add an RNG
driver. The driver that probes the existing node can register both
clocks and as an RNG provider.

Rob
