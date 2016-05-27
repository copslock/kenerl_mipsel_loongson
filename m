Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2016 00:05:48 +0200 (CEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:37794 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27034308AbcE0WFqznjCc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 May 2016 00:05:46 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-130-131-nat.elisa-mobile.fi [85.76.130.131])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id C5BD91888FC;
        Sat, 28 May 2016 01:05:45 +0300 (EEST)
Date:   Sat, 28 May 2016 01:05:45 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: THP broken on OCTEON?
Message-ID: <20160527220545.GE8755@raspberrypi.musicnaut.iki.fi>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <20160525134152.GG23204@ak-desktop.emea.nsn-net.net>
 <57473996.7030705@gmail.com>
 <20160526192330.GA17985@raspberrypi.musicnaut.iki.fi>
 <5747750E.4090000@gmail.com>
 <20160527171417.GC8755@raspberrypi.musicnaut.iki.fi>
 <86b5dd89-b328-3cb7-0833-8d2fa8aa9f47@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86b5dd89-b328-3cb7-0833-8d2fa8aa9f47@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53680
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

On Fri, May 27, 2016 at 05:03:06PM -0400, Joshua Kinard wrote:
> If the binaries on the initramfs are built to any of the MIPS-I to MIPS-IV
> ISAs, I can test this on my IP27/Onyx2 system as well, though I'll have to
> build an IP27 kernel and just use the initramfs.

I built them using --with-arch=octeon+ so they won't work on other HW.

But there isn't any magic in my binaries. If you have a working 64-bit
Linux MIPS system (with GCC and make) you can easily try my test case:

- compile Linux 4.6 with THP (always enabled) and 4KB page size

	(preferably using GCC >= 4.9.3)

- boot with the new kernel & log in

- execute the following commands:

	curl -O http://www.cpan.org/src/5.0/perl-5.22.2.tar.gz
	tar xf perl-5.22.2.tar.gz
	cd perl-5.22.2
	sh Configure -de -Dprefix=/usr -Dcc=gcc && make && make test

If this passes without odd crashes or hangs (which I highly doubt),
please post the output of:

	grep thp /proc/vmstat

A.
