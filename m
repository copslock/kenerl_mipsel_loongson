Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 01:41:17 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:54517 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20021897AbYEGAlN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2008 01:41:13 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m470eHHi020411;
	Wed, 7 May 2008 02:40:17 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m470dxAf020402;
	Wed, 7 May 2008 01:40:00 +0100
Date:	Wed, 7 May 2008 01:39:59 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alessandro Zummo <a.zummo@towertech.it>,
	Jean Delvare <khali@linux-fr.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
cc:	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 0/4] RTC: Use class devices as a persistent clock
Message-ID: <Pine.LNX.4.55.0805062333390.16173@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello,

 While investigating why Linux on the MIPS64 Broadcom BCM91250A board (the
SWARM, based on the SiByte BCM1250A SOC) does not support an RTC device
anymore I discovered the "wiring" of code to access /dev/rtc to the RTC
device driver got removed with some changes that happened a while ago.  
The board uses the ST M41T81 I2C chip with a driver buried within the
architecture code.  There is a standard driver for this chip in our tree
already, which is called rtc-m41t80, and which as a part of the RTC driver
suite provides the necessary "wiring" to /dev/rtc.

 I decided to remove the platform driver as redundant and unportable -- it
groups together knowledge about the M41T81 and the BCM1250A onchip I2C
controller.  This revealed a couple of problems which this patch set
addresses.  I'd like to skip the discussion of hardware-specific bits
here, which I think are rather obvious and which I will cover with the
individual patches.

 My point here is whether we want to switch over to the RTC suite in
preference to legacy RTC drivers (like drivers/char/rtc.c) and perhaps
more importantly platform RTC drivers which are often buried in a mixture
of header files and arch C code for the purpose of timekeeping.  The API
in question are the read_persistent_clock() and update_persistent_clock()  
functions used mostly by the NTP support code.

 The notable gain is the removal of the additional burden from platform
code -- all that has be implemented is support for the RTC chip the
platform has.  I have added the rtc_read_persistent_clock() and
rtc_update_persistent_clock() functions to the RTC suite that can serve as
the implementation of the API and work the same (hardware implementation
permitting) regardless of the exact RTC chip used.  There is even support
for the ubiquitous derivatives of the MC146818 available as a class device
already.  Additionally, if there is more than one RTC chip in a given
system, the user can select which of the chips to use.

 The drawback is some implementations behind these functions may sleep,
for example because hardware is slow to access.  The current calling
context of update_persistent_clock() (which is the softirq) does not
permit the function to sleep.  To rectify I have moved the call into the
process context, but it now means the latency between getnstimeofday() and
the writeback into the RTC will be yet less predictable and potentially
higher.  This should not matter in practice, because the RTC generally
cannot guarantee suitable precision to be a reliable sub-second resolution
device for providing time while the NTP daemon is not running and one who
cares about timekeeping will run NTP during normal system operation anyway
which will correct any inaccuracy gathered from the RTC.  I am mentioning
it though as I think it should be noted.

 Individual patches follow, feedback is welcome.  All have been
successfully tested at the run time with a big-endian 64-bit MIPS
configuration, using the usual SMP vs non-SMP and PREEMPT vs non-PREEMPT
configurations, with spinlock, etc. debugging on; no checkpatch.pl nor
sparse problems either.  They have been successfully built for a 32-bit
x86 and Alpha configuration as well.

  Maciej
