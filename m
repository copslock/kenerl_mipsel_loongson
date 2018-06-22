From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 Jun 2018 16:33:57 +0200
Subject: time: Make sure jiffies_to_msecs() preserves non-zero time periods
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID: <20180622143357.Ps6g5L6ej7YG28BBD8YkYQO7vqpDlo9TRKqFKe3H05A@z>

From: Geert Uytterhoeven <geert@linux-m68k.org>

commit abcbcb80cd09cd40f2089d912764e315459b71f7 upstream.

For the common cases where 1000 is a multiple of HZ, or HZ is a multiple of
1000, jiffies_to_msecs() never returns zero when passed a non-zero time
period.

However, if HZ > 1000 and not an integer multiple of 1000 (e.g. 1024 or
1200, as used on alpha and DECstation), jiffies_to_msecs() may return zero
for small non-zero time periods.  This may break code that relies on
receiving back a non-zero value.

jiffies_to_usecs() does not need such a fix: one jiffy can only be less
than one µs if HZ > 1000000, and such large values of HZ are already
rejected at build time, twice:

  - include/linux/jiffies.h does #error if HZ >= 12288,
  - kernel/time/time.c has BUILD_BUG_ON(HZ > USEC_PER_SEC).

Broken since forever.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-alpha@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180622143357.7495-1-geert@linux-m68k.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/time.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -28,6 +28,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/kernel.h>
 #include <linux/timex.h>
 #include <linux/capability.h>
 #include <linux/timekeeper_internal.h>
@@ -314,9 +315,10 @@ unsigned int jiffies_to_msecs(const unsi
 	return (j + (HZ / MSEC_PER_SEC) - 1)/(HZ / MSEC_PER_SEC);
 #else
 # if BITS_PER_LONG == 32
-	return (HZ_TO_MSEC_MUL32 * j) >> HZ_TO_MSEC_SHR32;
+	return (HZ_TO_MSEC_MUL32 * j + (1ULL << HZ_TO_MSEC_SHR32) - 1) >>
+	       HZ_TO_MSEC_SHR32;
 # else
-	return (j * HZ_TO_MSEC_NUM) / HZ_TO_MSEC_DEN;
+	return DIV_ROUND_UP(j * HZ_TO_MSEC_NUM, HZ_TO_MSEC_DEN);
 # endif
 #endif
 }


Patches currently in stable-queue which might be from geert@linux-m68k.org are

queue-4.17/auxdisplay-fix-broken-menu.patch
queue-4.17/time-make-sure-jiffies_to_msecs-preserves-non-zero-time-periods.patch
queue-4.17/m68k-mm-adjust-vm-area-to-be-unmapped-by-gap-size-for-__iounmap.patch
queue-4.17/m68k-mac-fix-swim-memory-resource-end-address.patch
