From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sat, 27 Oct 2018 01:46:34 +0300
Subject: MIPS: OCTEON: fix out of bounds array access on CN68XX
Message-ID: <20181026224634.Uyio66vJpi6LkxkCzGt6Qu3pz0Hi8C0kPUHvWmp8Z9s@z>

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit c0fae7e2452b90c31edd2d25eb3baf0c76b400ca upstream.

The maximum number of interfaces is returned by
cvmx_helper_get_number_of_interfaces(), and the value is used to access
interface_port_count[]. When CN68XX support was added, we forgot
to increase the array size. Fix that.

Fixes: 2c8c3f0201333 ("MIPS: Octeon: Support additional interfaces on CN68XX")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20949/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # v4.3+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/cavium-octeon/executive/cvmx-helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -67,7 +67,7 @@ void (*cvmx_override_pko_queue_priority)
 void (*cvmx_override_ipd_port_setup) (int ipd_port);
 
 /* Port count per interface */
-static int interface_port_count[5];
+static int interface_port_count[9];
 
 /**
  * Return the number of interfaces the chip has. Each interface


Patches currently in stable-queue which might be from aaro.koskinen@iki.fi are

queue-4.14/mips-octeon-fix-out-of-bounds-array-access-on-cn68xx.patch
