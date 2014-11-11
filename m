Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 08:48:02 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55388 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013342AbaKKHsAh96w4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Nov 2014 08:48:00 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAB7lxqg025874;
        Tue, 11 Nov 2014 08:47:59 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAB7lwms025873;
        Tue, 11 Nov 2014 08:47:58 +0100
Date:   Tue, 11 Nov 2014 08:47:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
Message-ID: <20141111074758.GF9302@linux-mips.org>
References: <5458272A.7050309@gentoo.org>
 <54582A91.8040401@gmail.com>
 <20141105160945.GB13785@linux-mips.org>
 <545C9D4D.4090501@gentoo.org>
 <545D0FC4.7020205@gmail.com>
 <545EB09C.40006@gentoo.org>
 <5460636A.5090401@gentoo.org>
 <20141110105106.GA4302@linux-mips.org>
 <20141110112039.GA7294@alpha.franken.de>
 <20141110213009.GA29367@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141110213009.GA29367@alpha.franken.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Nov 10, 2014 at 10:30:10PM +0100, Thomas Bogendoerfer wrote:

> looks like IP28 has more problems than HUGEPAGES... even without
> huge pages enabled it locks up during upgrading debian packages:-(
> My gut feeling is that there is another spot hitting the ll/sc errata
> stuff for this old R10k CPU.

You have the dreaded v2.6 CPU?

  Ralf
