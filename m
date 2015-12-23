Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Dec 2015 12:10:46 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:56731 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007719AbbLWLKlL53n6 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Dec 2015 12:10:41 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id E124D3D7; Wed, 23 Dec 2015 12:10:34 +0100 (CET)
Received: from localhost (81-67-231-93.rev.numericable.fr [81.67.231.93])
        by mail.free-electrons.com (Postfix) with ESMTPSA id C357C321;
        Wed, 23 Dec 2015 12:07:11 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@free-electrons.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>, arm@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] ARM: mvebu: ix4-300d: Add compatible property to "partitions" node
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
        <1450694033-27717-2-git-send-email-geert+renesas@glider.be>
        <87zix3rbm7.fsf@free-electrons.com> <20151222212225.GE30172@localhost>
Date:   Wed, 23 Dec 2015 12:07:12 +0100
In-Reply-To: <20151222212225.GE30172@localhost> (Olof Johansson's message of
        "Tue, 22 Dec 2015 13:22:25 -0800")
Message-ID: <87a8p1fmov.fsf@free-electrons.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <gregory.clement@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50741
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
 
 On mar., déc. 22 2015, Olof Johansson <olof@lixom.net> wrote:

> On Mon, Dec 21, 2015 at 05:48:48PM +0100, Gregory CLEMENT wrote:
>> Hi Geert,
>>  
>>  On lun., d??c. 21 2015, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> 
>> > As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
>> > property to "partitions" node"), the "partitions" subnode of an SPI
>> > FLASH device node must have a compatible property. The partitions are no
>> > longer detected if it is not present.
>> >
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > Acked-by: Brian Norris <computersforpeace@gmail.com>
>> 
>> Applied on mvebu/dt (with the hope that it is still time to push it to
>> arm-soc)
>
> I think we should just take this directly, so feel free to drop it. I'll
> followup on 0/9.

OK I will drop it of my mvebu/dt and for-next branches.

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
