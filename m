Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 16:22:41 +0100 (CET)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:44088
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994721AbeCGPWeMpmGt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Mar 2018 16:22:34 +0100
Received: by mail-io0-x242.google.com with SMTP id h23so3401552iob.11;
        Wed, 07 Mar 2018 07:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zq+YV7+P2udHEZFVKq29FJlS2rqEhpSzLstZLG/sOdI=;
        b=QMpf+XM9thViSaHkTfzIvUgst2sR1s1aERMJb0hylg3hnRbKpK193Bs6orYp2X5N1Y
         KQVFxBFK6UX0W/qHdV70m37ZAqUeK57PVb1cP0l26eGm1nZ3Tc4bffOSSqJWnepoyH4D
         mRP9u/uVRK9WKtKVZCEmhJEYjZDyrUI8h/o+HhjUjqrIlzurs13EgdK+pYFH7GYuwxL6
         B8g8pbKKisLSxk/JAm6YvDPbIlzxGQ2a/4NiP44lQf9k8cilQ6jS+cMX7UVtHupY93SW
         WsU+quOg0WphsUlY80ViRZ6HZy3wogAsFPAsDghJfH8OHojVKw62x+4bK0ptwn83/2gZ
         Jzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zq+YV7+P2udHEZFVKq29FJlS2rqEhpSzLstZLG/sOdI=;
        b=PLYh3IEZRmtKpbCkJEedJuiRhjX/suesLJ8mV4QjQ1U00nqvtQr3Lxg1P3TbMSZqpF
         EYGmt3Snzz6f8nJkXHG3EoMcsURm+WIepls4Y8PCAA4i1PdyvO2YfEunF9GJOt5bE9da
         7+JSl+Iu1IcGL6rzROoNS3J4+MRVaTUlVoV9EEUYyOs6pHhqIoclPeUYdxFTRyuxO6oI
         rNjRGJRkJMHSZuIgBzlHhoLMO2dL4NNLnqzZ8ctLfrS2GZjXIB+8zEfu20CKHof+BLPb
         8XrzI6rmWzxB0Lz+ocNAK7Hl0gBLg2Vwz6tXotpfnOxcL29eY7nNoIVvva9QGgD8BZL4
         u3EQ==
X-Gm-Message-State: APf1xPACviCEM/49m/NN4mVAiaXRMdBQ5SME+LHpnjaj2awomQgaYcAI
        ttDUCh5Y5lPOc7tgH4PS1EdhXH6FeQO59P1U2R0=
X-Google-Smtp-Source: AG47ELuiB4wZX5NVplUudPDRBjcJj+be2o4jZV1yGsG1AzpQ2A7N8G1WMBcxPCT1IxWxkD5bf8TZbWkLCd+gsnCIYBY=
X-Received: by 10.107.200.142 with SMTP id y136mr27953259iof.155.1520436148280;
 Wed, 07 Mar 2018 07:22:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.89.194 with HTTP; Wed, 7 Mar 2018 07:22:27 -0800 (PST)
In-Reply-To: <20180307151025.GP4197@saruman>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
 <20170927151527.25570-4-prasannatsmkumar@gmail.com> <20180306000832.GL4197@saruman>
 <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com>
 <20180307143541.GN4197@saruman> <CANc+2y5wsvGWszu3pePYhs2wb1_AgPdjG+ugfOCzbZVfVHDMvw@mail.gmail.com>
 <20180307151025.GP4197@saruman>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 7 Mar 2018 20:52:27 +0530
Message-ID: <CANc+2y6yNkgrJnM64D-JyL3jyWwk_Tes4MZfMw0NRmsf5v7=4w@mail.gmail.com>
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
X-archive-position: 62838
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

On 7 March 2018 at 20:40, James Hogan <jhogan@kernel.org> wrote:
> On Wed, Mar 07, 2018 at 08:35:00PM +0530, PrasannaKumar Muralidharan wrote:
>> On 7 March 2018 at 20:05, James Hogan <jhogan@kernel.org> wrote:
>> > On Wed, Mar 07, 2018 at 07:14:49PM +0530, PrasannaKumar Muralidharan wrote:
>> >> > Does X1000 use a different PRID, or is it basically just a JZ4780 core
>> >> > with different SoC peripherals?
>> >>
>> >> Yes X1000 does have a different PRID (PRID = 0x2ed1024f). X1000 has
>> >
>> > Right, so thats 0x2e000000 | PRID_COMP_INGENIC_D1 | PRID_IMP_JZRISC |
>> > 0x4f, which cpu-probe.c already handles (apparently the D1 company code
>> > is used for JZ4770 & JZ4775 too).
>>
>> Okay. Does this mean I need not modify get_board_mach_type() and
>> get_system_type()?
>
> You still need to modify them, otherwise it won't understand
> "ingenic,x1000" compatible string, and will call it a JZ4740 in
> /proc/cpuinfo.

Oh okay. Will make the changes.

>> >> I used to get my code tested from Domink but I could not reach him for
>> >> quite some time. Before buying the development board myself I would
>> >> like to see if anyone can help me in testing. Do you have any contact
>> >> with Ingenic who can help in testing this?
>> >
>> > Not personally, but I'll ask around. Of course if nobody much cares
>> > about it in practice and nobody has the hardware, there may be little
>> > value in supporting it upstream.
>>
>> Seems Jiaxun is interested in the board and is willing to help.
>
> Okay, cool.
>
> Cheers
> James
