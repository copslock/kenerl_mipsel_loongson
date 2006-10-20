Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2006 17:55:17 +0100 (BST)
Received: from 209-100-st.zelcom.ru ([80.92.102.209]:7874 "EHLO
	mail.elvees.com") by ftp.linux-mips.org with ESMTP
	id S20038917AbWJTQzN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Oct 2006 17:55:13 +0100
Received: from (IP:80.92.102.210) (authenticated with CRAM-MD5 user mail-deepfire)
    by mail.elvees.com with ESMTP id k9KGtsk8004921
    for <linux-mips@linux-mips.org>; Fri, 20 Oct 2006 20:55:54 +0400 (MSD)
    (envelope-from deepfire@elvees.com)
Message-ID: <4538FF44.7050306@elvees.com>
Date:	Fri, 20 Oct 2006 20:54:28 +0400
From:	Samium Gromoff <deepfire@elvees.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH][TRIVIAL] Fix mips_counter_frequency references in docs/comments
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <deepfire@elvees.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deepfire@elvees.com
Precedence: bulk
X-list: linux-mips

Hunt down the remains of stale mips_counter_frequency references in docs/comments.

 Documentation/mips/time.README       |    8 ++++----
 arch/mips/mips-boards/generic/time.c |    2 +-
 arch/mips/mips-boards/sim/sim_time.c |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

Signed-off-by: Samium Gromoff <deepfire@elvees.com>

diff --git a/Documentation/mips/time.README b/Documentation/mips/time.README
index 69ddc5c..859e58a 100644
--- a/Documentation/mips/time.README
+++ b/Documentation/mips/time.README
@@ -63,7 +63,7 @@ the following functions or values:
   a) board_time_init - a function pointer.  Invoked at the beginnig of
      time_init().  It is optional.
        1. (optional) set up RTC routines
-       2. (optional) calibrate and set the mips_counter_frequency
+       2. (optional) calibrate and set the mips_hpt_frequency

   b) plat_timer_setup - a function pointer.  Invoked at the end of time_init()
        1. (optional) over-ride any decisions made in time_init()
@@ -72,7 +72,7 @@ the following functions or values:

   c) (optional) board-specific RTC routines.

-  d) (optional) mips_counter_frequency - It must be definied if the board
+  d) (optional) mips_hpt_frequency - It must be defined if the board
      is using CPU counter for timer interrupt or it is using fixed rate
      gettimeoffset().

@@ -104,7 +104,7 @@ Step 1: decide how you like to implement
      or use an exnternal timer?

      In order to use CPU counter register as the timer interrupt source, you
-     must know the counter speed (mips_counter_frequency).  It is usually the
+     must know the counter speed (mips_hpt_frequency).  It is usually the
      same as the CPU speed or an integral divisor of it.

   d) decide on whether you want to use high-level or low-level timer
@@ -122,7 +122,7 @@ Step 3: implement rtc routines, board_ti

   board_time_init() -
        a) (optional) set up RTC routines,
-        b) (optional) calibrate and set the mips_counter_frequency
+        b) (optional) calibrate and set the mips_hpt_frequency
            (only needed if you intended to use fixed_rate_gettimeoffset
             or use cpu counter as timer interrupt source)

diff --git a/arch/mips/mips-boards/generic/time.c b/arch/mips/mips-boards/generic/time.c
index 6f8a9fe..c079e2a 100644
--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -187,7 +187,7 @@ #endif /* CONFIG_MIPS_MT_SMTC */
 }

 /*
- * Estimate CPU frequency.  Sets mips_counter_frequency as a side-effect
+ * Estimate CPU frequency.  Sets mips_hpt_frequency as a side-effect
  */
 static unsigned int __init estimate_cpu_frequency(void)
 {
diff --git a/arch/mips/mips-boards/sim/sim_time.c b/arch/mips/mips-boards/sim/sim_time.c
index c566b9b..24a4ed0 100644
--- a/arch/mips/mips-boards/sim/sim_time.c
+++ b/arch/mips/mips-boards/sim/sim_time.c
@@ -102,7 +102,7 @@ #endif


 /*
- * Estimate CPU frequency.  Sets mips_counter_frequency as a side-effect
+ * Estimate CPU frequency.  Sets mips_hpt_frequency as a side-effect
  */
 static unsigned int __init estimate_cpu_frequency(void)
 {
