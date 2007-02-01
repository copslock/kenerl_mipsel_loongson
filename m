Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 10:02:17 +0000 (GMT)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:27863 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20038889AbXBAKCN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Feb 2007 10:02:13 +0000
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1HCYi6-000491-Pt; Thu, 01 Feb 2007 10:58:34 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 4.63)
	(envelope-from <giometti@enneenne.com>)
	id 1HCYie-0001ri-Gd; Thu, 01 Feb 2007 10:59:04 +0100
Date:	Thu, 1 Feb 2007 10:59:04 +0100
From:	Rodolfo Giometti <giometti@enneenne.com>
To:	Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk, linux-mips@linux-mips.org
Message-ID: <20070201095904.GE8882@enneenne.com>
References: <20070129230755.GA8705@enneenne.com> <20070130010055.GA15907@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070130010055.GA15907@linux-sh.org>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Advice on battery support [was: Advice on APM-EMU reunion]
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@enneenne.com
Precedence: bulk
X-list: linux-mips

On Tue, Jan 30, 2007 at 10:00:55AM +0900, Paul Mundt wrote:

> However, it has since been reposted:
> 
> http://article.gmane.org/gmane.linux.kernel/485833
> http://article.gmane.org/gmane.linux.kernel/485834
> http://article.gmane.org/gmane.linux.kernel/485835
> http://article.gmane.org/gmane.linux.kernel/485837
> 
> and merged back in to -mm. This is all post 2.6.20 stuff, though..

Ok, starting from these patches I'd like to add a "battery support" to
the kernel.

What I suppose to do is a new class with a proper methods useful to
collect several info on battery status, such as get_ac_line_status()
get_battery_status(), get_battery_flags(),
get_remaining_battery_life() and so on.

The output will be APM-like into file "/proc/apm" (one line per
battery, or just the "main"/first one?) so that existing applications
continue to work and under sysfs into "/sysfs/class/battery".

Is it sane? :)

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
