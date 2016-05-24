Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 23:21:43 +0200 (CEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:58777 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27031225AbcEXVVlUgzs4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 23:21:41 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-130-131-nat.elisa-mobile.fi [85.76.130.131])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 89F7069EA4;
        Wed, 25 May 2016 00:21:40 +0300 (EEST)
Date:   Wed, 25 May 2016 00:21:39 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: THP broken on OCTEON?
Message-ID: <20160524212139.GC1253@raspberrypi.musicnaut.iki.fi>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <20160523152007.GB28729@linux-mips.org>
 <5743529A.4070506@gentoo.org>
 <20160523192219.GB24125@linux-mips.org>
 <57435CB4.5080609@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57435CB4.5080609@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Mon, May 23, 2016 at 03:40:36PM -0400, Joshua Kinard wrote:
> Might try some of those combinations and see if things improve on the Octeon?
> IP27 was equally affected by this, minus the bits about RAM and Impact Gfx.
> turning off THP, IP30 can run 64KB PAGE_SIZE without issue (compiles of
> packages is actually sped up quite significantly under >4KB PAGE_SIZE).

I think with 64KB page size, huge pages (512MB) are never allocated
unless you have insane amounts of memory? I tried today some builds
with 64KB pages on 4GB system and it was stable, but also AnonHugePages
stayed constantly at zero. But with 4KB pages it is frequently changing,
and crashes in minutes.

A.
