Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2016 22:39:47 +0100 (CET)
Received: from kirsty.vergenet.net ([202.4.237.240]:54720 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009469AbcACVjoUyGcs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2016 22:39:44 +0100
Received: from penelope.kanocho.kobe.vergenet.net (58-6-44-103.dyn.iinet.net.au [58.6.44.103])
        by kirsty.vergenet.net (Postfix) with ESMTPSA id 2F50825AD89;
        Mon,  4 Jan 2016 08:39:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1451857179; bh=jSDoIx6tIOtUwpZxh+l7xsxiv50EC9yvkuuF+8Yajwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LnI0VwfW5P4vzPX6Qd3KM4hIuEFLMIbvFSfSd3yCYOQZQYCJK0Lie/3eQ2hapw4P6
         +lLOrduZHql5vXgs/NpsyChcDqpoC1T9764zuIvKdl+n3QvLUKEhFsD9aRXgOioyZq
         djpM5xFGgAePbRte81NyolalNrNSJiR1zQ5H03bM=
Received: by penelope.kanocho.kobe.vergenet.net (Postfix, from userid 7100)
        id DF82166ACB; Mon,  4 Jan 2016 08:39:38 +1100 (AEDT)
Date:   Mon, 4 Jan 2016 08:39:38 +1100
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "arm@kernel.org" <arm@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] ARM: dts: Add compatible property to "partitions"
 node
Message-ID: <20160103213938.GD22806@verge.net.au>
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
 <20151228050147.GE1066@verge.net.au>
 <CAMuHMdXt36GSDuoFVGBebJVN9OHPh=ze8u8KvQ0B+RcvT6xTYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXt36GSDuoFVGBebJVN9OHPh=ze8u8KvQ0B+RcvT6xTYQ@mail.gmail.com>
Organisation: Horms Solutions Ltd.
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
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

On Mon, Dec 28, 2015 at 11:15:30AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Dec 28, 2015 at 6:01 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Dec 21, 2015 at 11:33:44AM +0100, Geert Uytterhoeven wrote:
> >> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
> >> property to "partitions" node"), which is in v4.4-rc6, the "partitions"
> >> subnode of an SPI FLASH device node must have a compatible property. The
> >> partitions are no longer detected if it is not present.
> >>
> >> However, several DTSes in -next have already been converted to the
> >> "partitions" subnode without "compatible" property, introduced by
> >> commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
> >> dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
> >> partitions in a special 'partitions' subnode"). Hence all of these are
> >> now broken in -next, and will be broken in upstream during the merge
> >> window.
> >>
> >> This series fixes all users in next-20151221.
> >> Tested on r8a7791/koelsch.
> >>
> >> Changes since v1:
> >>   - Add Acked-by,
> >>   - Fix new users in -next (kirkwood, ci20).
> >>
> >> Most of these are in arm-soc/for-next. Exceptions are kirkwood (in
> >> mvebu/for-next), and ci20 (in mips/mips-for-linux-next).
> >>
> >> Given we're late in the v4.4-rc cycle, perhaps it's easiest if the
> >> arm-soc maintainers take all applicable patches directly, bypassing the
> >> mvebu and shmobile maintainers?
> >>
> >> Thanks for queuing for v4.5!
> >>
> >> Geert Uytterhoeven (9):
> >>   ARM: mvebu: ix4-300d: Add compatible property to "partitions" node
> >>   ARM: mvebu: kirkwood: Add compatible property to "partitions" node
> >>   ARM: shmobile: bockw dts: Add compatible property to "partitions" node
> >>   ARM: shmobile: lager dts: Add compatible property to "partitions" node
> >>   ARM: shmobile: koelsch dts: Add compatible property to "partitions"
> >>     node
> >>   ARM: shmobile: porter dts: Add compatible property to "partitions"
> >>     node
> >>   ARM: shmobile: gose dts: Add compatible property to "partitions" node
> >>   ARM: shmobile: silk dts: Add compatible property to "partitions" node
> >
> > Thanks, I have queued up the above "shmobile" patches for v4.6.
> 
> I'm afraid v4.6 is too late, leaving all SPI FLASHes broken in v4.5.

Thanks. I'll re-queue them up as fixes for v4.5.
