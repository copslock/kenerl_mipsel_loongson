Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2007 19:32:45 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:62731 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20032580AbXJXSch (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Oct 2007 19:32:37 +0100
Received: (qmail 23114 invoked by uid 1000); 24 Oct 2007 20:31:35 +0200
Date:	Wed, 24 Oct 2007 20:31:35 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: 2.6.24-rc1: au1xxx and clocksource
Message-ID: <20071024183135.GA23096@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi everyone,

> So time to check how your favorite platform is doing and fix what broke!

I let it loose on my Au1200, but unfortunately the new time code is b0rked
ina way I don't understand.

Following call chain:

start_kernel()
 time_init()
  init_mips_clocksource()
  mips_clockevent_init()
   clockevents_register_device()
    clockevents_do_notify()
     notifier_call_chain():

      It dies here, line 69, in kernel/notifier.c:
      ret = nb->notifier_call(nb, val, v);

Maybe my debug method is faulty (homebrew putstring() with au1200 uart
 banging) but the last debug output is before this line.

Any ideas?

Thanks,
	Manuel Lauss
