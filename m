From: Nicholas Mc Guire <hofrat@osadl.org>
Date: Sat, 16 Jun 2018 09:06:33 +0200
Subject: MIPS: Octeon: add missing of_node_put()
Message-ID: <20180616070633.W4J9PDHjd6v76QFNW0KYrWyS8zxyrPh1yqbvcN6m-pA@z>

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit b1259519e618d479ede8a0db5474b3aff99f5056 ]

The call to of_find_node_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19558/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/cavium-octeon/octeon-platform.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -349,6 +349,7 @@ static int __init octeon_ehci_device_ini
 		return 0;
 
 	pd = of_find_device_by_node(ehci_node);
+	of_node_put(ehci_node);
 	if (!pd)
 		return 0;
 
@@ -411,6 +412,7 @@ static int __init octeon_ohci_device_ini
 		return 0;
 
 	pd = of_find_device_by_node(ohci_node);
+	of_node_put(ohci_node);
 	if (!pd)
 		return 0;
 


Patches currently in stable-queue which might be from hofrat@osadl.org are

queue-4.4/mips-octeon-add-missing-of_node_put.patch
