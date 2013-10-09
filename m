Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 13:20:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43452 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6868557Ab3JILUiTIVpQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Oct 2013 13:20:38 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r99BKZ9D016795;
        Wed, 9 Oct 2013 13:20:35 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r99BKYD0016787;
        Wed, 9 Oct 2013 13:20:34 +0200
Date:   Wed, 9 Oct 2013 13:20:34 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: Break instructions, debuggers, FPU emu & tracing.
Message-ID: <20131009112034.GM1615@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38282
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

do_bp() is running notify_die() for certain break codes, then invokes
do_trap_or_bp() which is going to run notify_die() yet again.  So it
is possible that notify_die() gets invoked twice.

This has caused some issues for my current project me but I'm wondering
especially about the existing code base, what is the intent here, what
notifiers do debuggers or tracers actually expect to be run, in what order?

Another observation is that the die notifier can be a relativly busy
place because the kernel FP software is running it for every instruction
emulated in a branch delay slot which is bad in particular when a
distribution built for hard floating point is running on FPU-less hardware,
as in my case Debian on an Octeon.  The increasing number of die notifier
functions has been silently slowing down the kernel fp software over the
years.  Which nobody has looked at because the FPU emulator has been so
reliable that nobody ever looked at it.  I'm wondering, should we create
a fast path for the FPU emulator only by skipping the die notifier?

  Ralf
