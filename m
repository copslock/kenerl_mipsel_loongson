From: James Hogan <james.hogan@imgtec.com>
Date: Mon, 8 Feb 2016 18:43:51 +0000
Subject: MIPS: Fix uapi include in exported asm/siginfo.h
Message-ID: <20160208184351.diHXp_rowdEF_VsEoLTFdB-lucNKlaU2lK1rAaBC3Fw@z>

commit 987e5b834467c9251ca584febda65ef8f66351a9 upstream.

Since commit 8cb48fe169dd ("MIPS: Provide correct siginfo_t.si_stime"),
MIPS' uapi/asm/siginfo.h has included uapi/asm-generic/siginfo.h
directly before defining MIPS' struct siginfo, in order to get the
necessary definitions needed for the siginfo struct without the generic
copy_siginfo() hitting compiler errors due to struct siginfo not yet
being defined.

Now that the generic copy_siginfo() is moved out to linux/signal.h we
can safely include asm-generic/siginfo.h before defining the MIPS
specific struct siginfo, which avoids the uapi/ include as well as
breakage due to generic copy_siginfo() being defined before struct
siginfo.

Reported-by: Christopher Ferris <cferris@google.com>
Fixes: 8cb48fe169dd ("MIPS: Provide correct siginfo_t.si_stime")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Petr Malat <oss@malat.biz>
Cc: linux-mips@linux-mips.org
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/include/uapi/asm/siginfo.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/include/uapi/asm/siginfo.h b/arch/mips/include/uapi/asm/siginfo.h
index 03ec109..e2b5337 100644
--- a/arch/mips/include/uapi/asm/siginfo.h
+++ b/arch/mips/include/uapi/asm/siginfo.h
@@ -28,7 +28,7 @@

 #define __ARCH_SIGSYS

-#include <uapi/asm-generic/siginfo.h>
+#include <asm-generic/siginfo.h>

 /* We can't use generic siginfo_t, because our si_code and si_errno are swapped */
 typedef struct siginfo {
@@ -118,6 +118,4 @@ typedef struct siginfo {
 #define SI_TIMER __SI_CODE(__SI_TIMER, -3) /* sent by timer expiration */
 #define SI_MESGQ __SI_CODE(__SI_MESGQ, -4) /* sent by real time mesq state change */

-#include <asm-generic/siginfo.h>
-
 #endif /* _UAPI_ASM_SIGINFO_H */
--
2.7.4
