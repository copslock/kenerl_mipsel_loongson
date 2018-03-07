Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 16:05:16 +0100 (CET)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:36952
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994720AbeCGPFJpFC3t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Mar 2018 16:05:09 +0100
Received: by mail-it0-x241.google.com with SMTP id k79so3762646ita.2;
        Wed, 07 Mar 2018 07:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/SCSLuUuAyqXFgffYIe+e9sz+bLNNpO+o05Ytp37WTE=;
        b=tEKt7plpwsi/kEcDb4yBzogYGmkJ11avUZQs74qHMAJTck5zucEGROk0496a8CgwD9
         YkMRDQeEfuLHb4QSPX0M3QoE2o1XdaAa52Ni9UNWk6hEWqgfkiXSeWA3fXxstIrvehYE
         MKErMqFJvTHcBN7FVTgR+8zL3FMw56rdN8cu8366cAj5qHAd0EOTPzYeW4WHvYKNOFOI
         EWu538MHC5OxSjUUjRxB3omaljFWhPgO/7bW/2leROAB8uUh6jVz/rCzKc4zj8nwpc6H
         a/gT9rEI0rtvboTLFnpa8NE7AXMxT4GaQIk1IFsJYOO2QrlykPkDForDvhj/zZxiZg2p
         ReGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/SCSLuUuAyqXFgffYIe+e9sz+bLNNpO+o05Ytp37WTE=;
        b=lLuXknt+n9iH8PfJz4RXOOgvAMXL48wq50n/I5Z0loH3A9TBAyezsWpMYN4MMSRBLi
         DocoHiXxsiAUBNo/Da19Mo0CMKHYwDzAdz5Z0TBvsoI+dmAKg3DYCU0Xk+GOR+4nvkBI
         ay6D4et5zBgRWWw4bgKvjMBeb0okMKPtEyWr3ODsgoqRCGw0Saqli+cBS0pS0ogarHEc
         /TriQXVicXxW7Y4ukCnUWabu73CjDxtqS4/XHnpmSCTtD9ESQ2WKt69oRwtCXIn3+okU
         yebZmEHbEWMo5czb6oI6AJ/q7SfA/ScatojpH/Us2uBSh5aZrVMakrIc+XFs6b7IlXGd
         78dQ==
X-Gm-Message-State: AElRT7HvFBK1ciXhH1jXocCdOvFSv2w0ezY1jO4WCg89OnwKrKPT/PnS
        ogSHSgTX+vKi2nHHGDwS+3V8tPRskgifucuitF8=
X-Google-Smtp-Source: AG47ELv88H4DzV5gtJ2zKIVGpdMpqbobLIpaJnWzLscBH+7m1gXnXTmlIKi1xXEVMkp80047jqEas26C//f6qPFGMaI=
X-Received: by 10.36.225.72 with SMTP id n69mr24706223ith.82.1520435101388;
 Wed, 07 Mar 2018 07:05:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.89.194 with HTTP; Wed, 7 Mar 2018 07:05:00 -0800 (PST)
In-Reply-To: <20180307143541.GN4197@saruman>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
 <20170927151527.25570-4-prasannatsmkumar@gmail.com> <20180306000832.GL4197@saruman>
 <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com> <20180307143541.GN4197@saruman>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 7 Mar 2018 20:35:00 +0530
Message-ID: <CANc+2y5wsvGWszu3pePYhs2wb1_AgPdjG+ugfOCzbZVfVHDMvw@mail.gmail.com>
Subject: Re: [RFC 3/4] MIPS: Ingenic: Initial X1000 SoC support
To:     James Hogan <jhogan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        sboyd@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Dominik Peklo <dom.peklo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62834
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

Hi James,

On 7 March 2018 at 20:05, James Hogan <jhogan@kernel.org> wrote:
> On Wed, Mar 07, 2018 at 07:14:49PM +0530, PrasannaKumar Muralidharan wrote:
>> > Does X1000 use a different PRID, or is it basically just a JZ4780 core
>> > with different SoC peripherals?
>>
>> Yes X1000 does have a different PRID (PRID = 0x2ed1024f). X1000 has
>
> Right, so thats 0x2e000000 | PRID_COMP_INGENIC_D1 | PRID_IMP_JZRISC |
> 0x4f, which cpu-probe.c already handles (apparently the D1 company code
> is used for JZ4770 & JZ4775 too).

Okay. Does this mean I need not modify get_board_mach_type() and
get_system_type()?

>> I used to get my code tested from Domink but I could not reach him for
>> quite some time. Before buying the development board myself I would
>> like to see if anyone can help me in testing. Do you have any contact
>> with Ingenic who can help in testing this?
>
> Not personally, but I'll ask around. Of course if nobody much cares
> about it in practice and nobody has the hardware, there may be little
> value in supporting it upstream.

Seems Jiaxun is interested in the board and is willing to help.

I have been told that Ingenic is focusing on IoT market and X1000 is
intended for IoT segment. I think that they would be selling several
100Ks of chip over the coming years. But I feel Ingenic spends time
only on maintaining their Linux port which is usually based on very
old kernel version.

> Cheers
> James

Thanks and regards,
PrasannaKumar
