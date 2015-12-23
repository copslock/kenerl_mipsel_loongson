Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Dec 2015 12:07:26 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:56601 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007719AbbLWLHYT37e6 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Dec 2015 12:07:24 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 0F8B0371; Wed, 23 Dec 2015 12:07:16 +0100 (CET)
Received: from localhost (81-67-231-93.rev.numericable.fr [81.67.231.93])
        by mail.free-electrons.com (Postfix) with ESMTPSA id AA8072CE;
        Wed, 23 Dec 2015 12:04:56 +0100 (CET)
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
Subject: Re: [PATCH v2 0/9] ARM: dts: Add compatible property to "partitions" node
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
        <20151222212350.GF30172@localhost>
Date:   Wed, 23 Dec 2015 12:04:57 +0100
In-Reply-To: <20151222212350.GF30172@localhost> (Olof Johansson's message of
        "Tue, 22 Dec 2015 13:23:50 -0800")
Message-ID: <87egedfmsm.fsf@free-electrons.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <gregory.clement@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50740
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

> Hi,
>
> On Mon, Dec 21, 2015 at 11:33:44AM +0100, Geert Uytterhoeven wrote:
>> 	Hi,
>> 
>> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
>> property to "partitions" node"), which is in v4.4-rc6, the "partitions"
>> subnode of an SPI FLASH device node must have a compatible property. The
>> partitions are no longer detected if it is not present.
>> 
>> However, several DTSes in -next have already been converted to the
>> "partitions" subnode without "compatible" property, introduced by
>> commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
>> dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
>> partitions in a special 'partitions' subnode"). Hence all of these are
>> now broken in -next, and will be broken in upstream during the merge
>> window.
>
> So, if I understand this correctly, the partitions format was added for v4.4,
> then this non-backwards compatible change was added in -rc6. But, there were
> also DT files that had the new-for-v4.4 partitions nodes in them that then
> stopped working in -rc6?

At least for the mvebu dts, the change was added for v4.5 not
v4.4. Currently it is only in the next branches (and also in your
arm-soc tree in next/dt).

>
> That sounds like a regression, so this should be picked up as fixes
> for v4.4.


It won't be a regression but a breakage of the bissectability between
the patch adding the partition subnode and the one using the compatible
"fixed-partitions".

If you really want avoiding this you could squash the patches, however
from my point of view it's not worth doing it.

>
> Please confirm that I've understood the setup correctly, and I'll apply the
> series directly to fixes.

I think it won't apply on v4.4 because the partition change was not made
at this moment.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
