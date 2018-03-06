Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2018 14:56:11 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:56972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994690AbeCFN4CxSbH- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Mar 2018 14:56:02 +0100
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com [209.85.161.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9AE92179F;
        Tue,  6 Mar 2018 13:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AE92179F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
Received: by mail-yw0-f169.google.com with SMTP id l200so6912167ywb.0;
        Tue, 06 Mar 2018 05:55:53 -0800 (PST)
X-Gm-Message-State: AElRT7G2RxFLFo70xyXyPCfXZY9HjzpcwEPkwBCPjHCBP2e+2JHtEvr8
        8bn62IQwU/p+7OLjYjj2Nz8voSRlsNMAE17OSg==
X-Google-Smtp-Source: AG47ELsNMMpvEO3htTsnWkOqQGcCSlO/3YMMkWBvtm49NjVgjISfl63EufM3+yc9285mbCc9E8JLLLj4MaDP5lUxGMk=
X-Received: by 10.129.165.69 with SMTP id c66mr11526609ywh.17.1520344552790;
 Tue, 06 Mar 2018 05:55:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:8007:0:0:0:0:0 with HTTP; Tue, 6 Mar 2018 05:55:32 -0800 (PST)
In-Reply-To: <20180306091932.GM4197@saruman>
References: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
 <20170918140241.24003-4-prasannatsmkumar@gmail.com> <20180306091932.GM4197@saruman>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Mar 2018 07:55:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJiNpnVC7X=viKZRjEJBe8ZEp0mJLDKhPYKugoxpiQJNQ@mail.gmail.com>
Message-ID: <CAL_JsqJiNpnVC7X=viKZRjEJBe8ZEp0mJLDKhPYKugoxpiQJNQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] crypto: jz4780-rng: Add RNG node to jz4780.dtsi
To:     James Hogan <jhogan@kernel.org>
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
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
X-archive-position: 62824
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

On Tue, Mar 6, 2018 at 3:32 AM, James Hogan <jhogan@kernel.org> wrote:
> On Mon, Sep 18, 2017 at 07:32:40PM +0530, PrasannaKumar Muralidharan wrote:
>> Add RNG node to jz4780 dtsi. This driver uses registers that are part of
>> the register set used by Ingenic CGU driver. Use regmap in RNG driver to
>> access its register. Create 'simple-bus' node, make CGU and RNG node as
>> child of it so that both the nodes are visible without changing CGU
>> driver code.

The goal should be to avoid changing the DT (because the h/w hasn't
changed), not avoid changing a driver.

>>
>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>
> Better late than never:
> Acked-by: James Hogan <jhogan@kernel.org>
>
> (I presume its okay for the reg ranges to overlap, ISTR that being an
> issue a few years ago, but maybe thats fixed now).

No, that should be avoided. It does work because we have existing
cases that have to be supported.

>
> Cheers
> James
