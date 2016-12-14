Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2016 17:49:30 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:46412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990513AbcLNQtWd6qaB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Dec 2016 17:49:22 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 47A9E20414;
        Wed, 14 Dec 2016 16:49:20 +0000 (UTC)
Received: from mail-yb0-f178.google.com (mail-yb0-f178.google.com [209.85.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 221F92028D;
        Wed, 14 Dec 2016 16:49:19 +0000 (UTC)
Received: by mail-yb0-f178.google.com with SMTP id v132so20434548yba.0;
        Wed, 14 Dec 2016 08:49:19 -0800 (PST)
X-Gm-Message-State: AKaTC00L1OWEpWIqwmM5bjr/7NNHJRqXd8q2sUrBM6qrzxvUf3Up7ROvCSJTB7uYvC45SA0xJFO37nqRwUUong==
X-Received: by 10.129.93.87 with SMTP id r84mr108122556ywb.15.1481734158470;
 Wed, 14 Dec 2016 08:49:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.96.86 with HTTP; Wed, 14 Dec 2016 08:48:58 -0800 (PST)
In-Reply-To: <20161214163253.GA25341@nathan3500-linux-VM>
References: <1480693329-22265-1-git-send-email-nathan.sullivan@ni.com>
 <20161209211828.dykl2l4kmthqgq6e@rob-hp-laptop> <20161214163253.GA25341@nathan3500-linux-VM>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Dec 2016 10:48:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJPkVBbvTonOADsu-uaH0bxtNDBJ3OrzE=7vP5pc92H=Q@mail.gmail.com>
Message-ID: <CAL_JsqJPkVBbvTonOADsu-uaH0bxtNDBJ3OrzE=7vP5pc92H=Q@mail.gmail.com>
Subject: Re: [PATCH] MIPS: NI 169445 board support
To:     Nathan Sullivan <nathan.sullivan@ni.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Wed, Dec 14, 2016 at 10:32 AM, Nathan Sullivan
<nathan.sullivan@ni.com> wrote:
> On Fri, Dec 09, 2016 at 03:18:28PM -0600, Rob Herring wrote:
>> On Fri, Dec 02, 2016 at 09:42:09AM -0600, Nathan Sullivan wrote:
>> > Support the National Instruments 169445 board.
>> >
>> > Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
>> > ---
>> > "gpio: mmio: add support for NI 169445 NAND GPIO" and
>> > "devicetree: add vendor prefix for National Instruments" are required for the
>> > NAND on this board to work.

>> > +   ahb@0 {
>> > +           compatible = "simple-bus";
>> > +           #address-cells = <1>;
>> > +           #size-cells = <1>;
>> > +           ranges;
>>
>> If everything is under 0x1f3xxxxx, then add in the ranges here (and the
>> unit address).
>>
>
> I noticed that some systems call out their axi/ahb busses, some do not.  Would
> you prefer that I remove the bus entirely?

Definitely not. IMO, not having a bus node is an error.

Rob
