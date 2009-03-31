From: Kevin D. Kissell <kevink@paralogos.com>
Date: Tue, 31 Mar 2009 12:42:12 +0200
Subject: [PATCH] Bring SMTC up to date on set/clear/change_c0_## return value semantics
Message-ID: <20090331104212.04UVV-M_kcF0RwrW-Y9_oczcc6Rcrxeu2aQkm1pyRMs@z>


Signed-off-by: Kevin D. Kissell <kevink@paralogos.com>
---
 arch/mips/include/asm/mipsregs.h |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 526f327..1f79877 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1484,14 +1484,15 @@ static inline unsigned int					\
 set_c0_##name(unsigned int set)					\
 {								\
 	unsigned int res;					\
+	unsigned int new;					\
 	unsigned int omt;					\
 	unsigned long flags;					\
 								\
 	local_irq_save(flags);					\
 	omt = __dmt();						\
 	res = read_c0_##name();					\
-	res |= set;						\
-	write_c0_##name(res);					\
+	new = res | set;					\
+	write_c0_##name(new);					\
 	__emt(omt);						\
 	local_irq_restore(flags);				\
 								\
@@ -1502,14 +1503,15 @@ static inline unsigned int					\
 clear_c0_##name(unsigned int clear)				\
 {								\
 	unsigned int res;					\
+	unsigned int new;					\
 	unsigned int omt;					\
 	unsigned long flags;					\
 								\
 	local_irq_save(flags);					\
 	omt = __dmt();						\
 	res = read_c0_##name();					\
-	res &= ~clear;						\
-	write_c0_##name(res);					\
+	new = res & ~clear;					\
+	write_c0_##name(new);					\
 	__emt(omt);						\
 	local_irq_restore(flags);				\
 								\
@@ -1517,9 +1519,10 @@ clear_c0_##name(unsigned int clear)				\
 }								\
 								\
 static inline unsigned int					\
-change_c0_##name(unsigned int change, unsigned int new)		\
+change_c0_##name(unsigned int change, unsigned int newbits)	\
 {								\
 	unsigned int res;					\
+	unsigned int new;					\
 	unsigned int omt;					\
 	unsigned long flags;					\
 								\
@@ -1527,9 +1530,9 @@ change_c0_##name(unsigned int change, unsigned int new)		\
 								\
 	omt = __dmt();						\
 	res = read_c0_##name();					\
-	res &= ~change;						\
-	res |= (new & change);					\
-	write_c0_##name(res);					\
+	new = res & ~change;					\
+	new |= (newbits & change);				\
+	write_c0_##name(new);					\
 	__emt(omt);						\
 	local_irq_restore(flags);				\
 								\
-- 
1.5.3.3


--------------070001080009090005070202--
