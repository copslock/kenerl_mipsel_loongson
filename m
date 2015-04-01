Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 12:00:15 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:38350 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008712AbbDAKAOWSCDf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Apr 2015 12:00:14 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1YdFRV-0002LJ-00; Wed, 01 Apr 2015 12:00:13 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 793EF5085ED; Wed,  1 Apr 2015 11:59:44 +0200 (CEST)
Date:   Wed, 1 Apr 2015 11:59:44 +0200
From:   Tom Bogendoerfer <tsbogend@alpha.franken.de>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: R10000: Split R10000 definitions from R12000
 and up
Message-ID: <20150401095944.GA27774@alpha.franken.de>
References: <54BFA0DF.8000104@gentoo.org>
 <20150331121757.GD28951@linux-mips.org>
 <551B75DA.10603@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551B75DA.10603@gentoo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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

On Wed, Apr 01, 2015 at 12:36:42AM -0400, Joshua Kinard wrote:
> also benefits from this as well.  I am not sure how old the IP30 R10000 CPU

ARCH: SGI-IP30
PROMLIB: ARC firmware Version 64 Revision 0
console [early0] enabled
CPU revision is: 00000927 (R10000)

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
