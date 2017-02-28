From: David Daney <david.daney@cavium.com>
Date: Tue, 28 Feb 2017 12:10:02 -0800
Subject: [PATCH] module: set __jump_table alignment to 8
Message-ID: <20170228201002.9IMv8cgyvtKiLdmN4ZlrvcdFs4eL4r2nPuOjKqqee2I@z>

For powerpc the __jump_table section in modules is not aligned, this
causes an OOPS when loading a module containing a __jump_table.

Fix by forcing __jump_table to 8, which is the same alignment used for
this section in the kernel proper.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 scripts/module-common.lds | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/module-common.lds b/scripts/module-common.lds
index 73a2c7d..53234e8 100644
--- a/scripts/module-common.lds
+++ b/scripts/module-common.lds
@@ -19,4 +19,6 @@ SECTIONS {
 
 	. = ALIGN(8);
 	.init_array		0 : { *(SORT(.init_array.*)) *(.init_array) }
+
+	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
 }
-- 
2.9.3


--------------2F06A5F2FED84D3DFBAD5183--
