Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2016 17:08:07 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:52500 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009453AbcAKQIFmgL5O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jan 2016 17:08:05 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 7A65534C; Mon, 11 Jan 2016 17:07:58 +0100 (CET)
Received: from localhost (81-67-231-93.rev.numericable.fr [81.67.231.93])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 3995726C;
        Mon, 11 Jan 2016 17:07:58 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@free-electrons.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "arm\@kernel.org" <arm@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] ARM: dts: Add compatible property to "partitions" node
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
        <20151228050147.GE1066@verge.net.au>
        <CAMuHMdXt36GSDuoFVGBebJVN9OHPh=ze8u8KvQ0B+RcvT6xTYQ@mail.gmail.com>
        <20160103213938.GD22806@verge.net.au>
Date:   Mon, 11 Jan 2016 17:07:58 +0100
In-Reply-To: <20160103213938.GD22806@verge.net.au> (Simon Horman's message of
        "Mon, 4 Jan 2016 08:39:38 +1100")
Message-ID: <87lh7wyu8x.fsf@free-electrons.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <gregory.clement@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregory.clement@free-electrons.com
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

Hi Olof,
 
 On dim., janv. 03 2016, Simon Horman <horms@verge.net.au> wrote:

> On Mon, Dec 28, 2015 at 11:15:30AM +0100, Geert Uytterhoeven wrote:

>> >> Most of these are in arm-soc/for-next. Exceptions are kirkwood (in
>> >> mvebu/for-next), and ci20 (in mips/mips-for-linux-next).
>> >>
>> >> Given we're late in the v4.4-rc cycle, perhaps it's easiest if the
>> >> arm-soc maintainers take all applicable patches directly, bypassing the
>> >> mvebu and shmobile maintainers?
>> >>
>> >> Thanks for queuing for v4.5!
>> >>
>> >> Geert Uytterhoeven (9):
>> >>   ARM: mvebu: ix4-300d: Add compatible property to "partitions" node
>> >>   ARM: mvebu: kirkwood: Add compatible property to "partitions" node
>> >>   ARM: shmobile: bockw dts: Add compatible property to "partitions" node
>> >>   ARM: shmobile: lager dts: Add compatible property to "partitions" node
>> >>   ARM: shmobile: koelsch dts: Add compatible property to "partitions"
>> >>     node
>> >>   ARM: shmobile: porter dts: Add compatible property to "partitions"
>> >>     node
>> >>   ARM: shmobile: gose dts: Add compatible property to "partitions" node
>> >>   ARM: shmobile: silk dts: Add compatible property to "partitions" node
>> >
>> > Thanks, I have queued up the above "shmobile" patches for v4.6.
>> 
>> I'm afraid v4.6 is too late, leaving all SPI FLASHes broken in v4.5.
>
> Thanks. I'll re-queue them up as fixes for v4.5.

I thought you planned to directly apply them for v4.5 but I did not see
them in the for-next branch of arm-soc. So as Simon I will submit them
as fix for 4.5.

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
