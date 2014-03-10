Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Mar 2014 14:55:11 +0100 (CET)
Received: from hall.aurel32.net ([195.154.112.97]:59580 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831270AbaCJNzIOimqf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Mar 2014 14:55:08 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1WN0fa-0000OK-HB; Mon, 10 Mar 2014 14:55:06 +0100
Date:   Mon, 10 Mar 2014 14:55:06 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 3/5] MIPS: Set page size to 16KB for malta SMP defconfigs
Message-ID: <20140310135506.GA28583@hall.aurel32.net>
References: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com>
 <1392904828-12969-4-git-send-email-markos.chandras@imgtec.com>
 <20140221173829.GI19285@linux-mips.org>
 <53148C5A.7020101@imgtec.com>
 <20140303222423.GA573@drone.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20140303222423.GA573@drone.musicnaut.iki.fi>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Tue, Mar 04, 2014 at 12:24:23AM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, Mar 03, 2014 at 02:06:18PM +0000, Markos Chandras wrote:
> > Are you referring to programs hard coding the page size to 4k instead of
> > using the getpagesize()? Well yes this could be a problem. But is that a
> > real problem? We are changing the default value so whoever has such an old
> > userland can easily switch to the 4k page size. It may also be a good
> > opportunity to expose such application and get the fixed properly :) But if
> > that's not acceptable, we can drop the patch. Paul what do you think?
> 
> Not so long ago there was an issue with Debian where Iceweasel or
> Spidermonkey failed on MIPS/Loongson because of its 8K page size (the
> userspace assumed 4K). You will get such issues as long as x86 dominates,
> it's not a matter of "old userland".

In Debian I am aware of the problem on at least all mozilla based
products (the problem is jemalloc) and GCL.

The problem is not that the page size is hardcoded to 4K, but that it is
detected at build time instead of run time. This is only a problem for
distributions where a package could be built on one machine and run on
another, but it should not affect people building such packages
themselves, or using the same set of machines.

The fact that the page size is not 4K is usually correctly handled, as
other architectures like alpha and itanium were using 8K or 16K pages.

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
