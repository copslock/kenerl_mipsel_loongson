From: Paul Burton <paul.burton@mips.com>
Date: Tue, 21 Aug 2018 12:12:59 -0700
Subject: MIPS: lib: Provide MIPS64r6 __multi3() for GCC < 7
Message-ID: <20180821191259.MYeQ6QX052dEyjR_XGRZPLtEZLdperIDA050IsvXeV4@z>

From: Paul Burton <paul.burton@mips.com>

commit 690d9163bf4b8563a2682e619f938e6a0443947f upstream.

Some versions of GCC suboptimally generate calls to the __multi3()
intrinsic for MIPS64r6 builds, resulting in link failures due to the
missing function:

    LD      vmlinux.o
    MODPOST vmlinux.o
  kernel/bpf/verifier.o: In function `kmalloc_array':
  include/linux/slab.h:631: undefined reference to `__multi3'
  fs/select.o: In function `kmalloc_array':
  include/linux/slab.h:631: undefined reference to `__multi3'
  ...

We already have a workaround for this in which we provide the
instrinsic, but we do so selectively for GCC 7 only. Unfortunately the
issue occurs with older GCC versions too - it has been observed with
both GCC 5.4.0 & GCC 6.4.0.

MIPSr6 support was introduced in GCC 5, so all major GCC versions prior
to GCC 8 are affected and we extend our workaround accordingly to all
MIPS64r6 builds using GCC versions older than GCC 8.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Fixes: ebabcf17bcd7 ("MIPS: Implement __multi3 for GCC7 MIPS64r6 builds")
Patchwork: https://patchwork.linux-mips.org/patch/20297/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/multi3.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/lib/multi3.c
+++ b/arch/mips/lib/multi3.c
@@ -4,12 +4,12 @@
 #include "libgcc.h"
 
 /*
- * GCC 7 suboptimally generates __multi3 calls for mips64r6, so for that
- * specific case only we'll implement it here.
+ * GCC 7 & older can suboptimally generate __multi3 calls for mips64r6, so for
+ * that specific case only we implement that intrinsic here.
  *
  * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82981
  */
-#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPSR6) && (__GNUC__ == 7)
+#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPSR6) && (__GNUC__ < 8)
 
 /* multiply 64-bit values, low 64-bits returned */
 static inline long long notrace dmulu(long long a, long long b)


Patches currently in stable-queue which might be from paul.burton@mips.com are

queue-4.9/mips-lib-provide-mips64r6-__multi3-for-gcc-7.patch
queue-4.9/mips-correct-the-64-bit-dsp-accumulator-register-size.patch
queue-4.9/revert-mips-bcm47xx-enable-74k-core-externalsync-for-pcie-erratum.patch
