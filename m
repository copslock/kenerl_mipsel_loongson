Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jan 2004 02:24:44 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:34031 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225597AbUAXCYn>;
	Sat, 24 Jan 2004 02:24:43 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0O2Oab00668;
	Fri, 23 Jan 2004 18:24:36 -0800
Date: Fri, 23 Jan 2004 18:24:36 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH 2.6] 32bit module support
Message-ID: <20040123182436.C27362@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I have not done extensive tests yet, but this patch appears to 
be working.  I'd appreciate people giving it a try and let me 
know how it goes.

There is one worrisome "FIXME" in that file, which is not clear
to me.  Ralf?

Jun

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="module-32bit.patch"

diff -Nru linux/arch/mips/kernel/module-elf32.c.orig linux/arch/mips/kernel/module-elf32.c
--- linux/arch/mips/kernel/module-elf32.c.orig	Fri Jul 25 15:49:23 2003
+++ linux/arch/mips/kernel/module-elf32.c	Fri Jan 23 17:58:42 2004
@@ -23,14 +23,11 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 
-struct mips_hi16 {
-	struct mips_hi16 *next;
+struct mips_hilo16 {
 	Elf32_Addr *addr;
 	Elf32_Addr value;
 };
 
-static struct mips_hi16 *mips_hi16_list;
-
 #if 0
 #define DEBUGP printk
 #else
@@ -78,6 +75,35 @@
 	return 0;
 }
 
+/*
+ * For the hi16, we should set ((AHL+S) - (short)(AHL+S)) >> 16
+ * For the lo16, we should set (AHL+S) & 0xffff
+ * where 
+ * 	AHL = (AHI << 16 ) + (short)ALO
+ * whereis
+ * 	AHI = *(hi16 instr loc) & 0xffff	// before reloc
+ * 	ALO = *(lo16 instr loc) & 0xffff	// before reloc
+ */
+#define	U32_TO_SHORT(x)	(((x & 0xffff) ^ 0x8000) - 0x8000)
+static void relocate_hilo16(struct mips_hilo16 *hi, struct mips_hilo16 *lo)
+{
+	u32 AHI, ALO, AHL_S, res_hi, res_lo;
+
+	AHI = *(hi->addr) & 0xffff;
+	ALO = *(lo->addr) & 0xffff;
+	AHL_S = (AHI << 16) + U32_TO_SHORT(ALO) + hi->value;
+
+	res_lo = AHL_S & 0xffff;
+	res_hi = (AHL_S >> 16) + ((res_lo & 0x8000)==0 ? 0 : 1);
+	res_hi &= 0xffff;
+
+	*hi->addr = (*hi->addr & ~0xffff) | res_hi;
+	*lo->addr = (*lo->addr & ~0xffff) | res_lo;
+}
+
+#undef KERN_ERR
+#define KERN_ERR
+
 int apply_relocate(Elf32_Shdr *sechdrs,
 		   const char *strtab,
 		   unsigned int symindex,
@@ -85,19 +111,20 @@
 		   struct module *me)
 {
 	unsigned int i;
-	Elf32_Rel *rel = (void *)sechdrs[relsec].sh_offset;
+	Elf32_Rel *rel = (void *)sechdrs[relsec].sh_addr;
 	Elf32_Sym *sym;
 	uint32_t *location;
 	Elf32_Addr v;
+	struct mips_hilo16 hi16, lo16;
 
 	DEBUGP("Applying relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
 		/* This is where to make the change */
-		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
 		/* This is the symbol it is referring to */
-		sym = (Elf32_Sym *)sechdrs[symindex].sh_offset
+		sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
 			+ ELF32_R_SYM(rel[i].r_info);
 		if (!sym->st_value) {
 			printk(KERN_WARNING "%s: Unknown symbol %s\n",
@@ -116,99 +143,52 @@
 			break;
 
 		case R_MIPS_26:
-			if (v % 4)
+			if (v % 4) {
 				printk(KERN_ERR
 				       "module %s: dangerous relocation\n",
 				       me->name);
 				return -ENOEXEC;
+			}
 			if ((v & 0xf0000000) !=
-			    (((unsigned long)location + 4) & 0xf0000000))
+			    (((unsigned long)location + 4) & 0xf0000000)) {
 				printk(KERN_ERR
 				       "module %s: relocation overflow\n",
 				       me->name);
 				return -ENOEXEC;
+			}
 			*location = (*location & ~0x03ffffff) |
 			            ((*location + (v >> 2)) & 0x03ffffff);
 			break;
 
-		case R_MIPS_HI16: {
-			struct mips_hi16 *n;
-
+		case R_MIPS_HI16: 
 			/*
 			 * We cannot relocate this one now because we don't
 			 * know the value of the carry we need to add.  Save
 			 * the information, and let LO16 do the actual
 			 * relocation.
 			 */
-			n = (struct mips_hi16 *) kmalloc(sizeof *n, GFP_KERNEL);
-			n->addr = location;
-			n->value = v;
-			n->next = mips_hi16_list;
-			mips_hi16_list = n;
+			hi16.addr = location;
+			hi16.value = v;
 			break;
-		}
-
-		case R_MIPS_LO16: {
-			unsigned long insnlo = *location;
-			Elf32_Addr val, vallo;
-
-			/* Sign extend the addend we extract from the lo insn.  */
-			vallo = ((insnlo & 0xffff) ^ 0x8000) - 0x8000;
-
-			if (mips_hi16_list != NULL) {
-				struct mips_hi16 *l;
-
-				l = mips_hi16_list;
-				while (l != NULL) {
-					struct mips_hi16 *next;
-					unsigned long insn;
-
-					/*
-					 * The value for the HI16 had best be
-					 * the same.
-					 */
-					printk(KERN_ERR "module %s: dangerous "
-					       "relocation\n", me->name);
-					return -ENOEXEC;
-
-					/*
-					 * Do the HI16 relocation.  Note that
-					 * we actually don't need to know
-					 * anything about the LO16 itself,
-					 * except where to find the low 16 bits
-					 * of the addend needed by the LO16.
-					 */
-					insn = *l->addr;
-					val = ((insn & 0xffff) << 16) + vallo;
-					val += v;
-
-					/*
-					 * Account for the sign extension that
-					 * will happen in the low bits.
-					 */
-					val = ((val >> 16) + ((val & 0x8000) !=
-					      0)) & 0xffff;
-
-					insn = (insn & ~0xffff) | val;
-					*l->addr = insn;
-
-					next = l->next;
-					kfree(l);
-					l = next;
-				}
-
-				mips_hi16_list = NULL;
-			}
 
+		case R_MIPS_LO16: 
 			/*
-			 * Ok, we're done with the HI16 relocs.  Now deal with
-			 * the LO16.
+			 * This lo16 entry must have the same value as
+			 * the preceeding or last hi16 entry.
 			 */
-			val = v + vallo;
-			insnlo = (insnlo & ~0xffff) | (val & 0xffff);
-			*location = insnlo;
+			if (v != hi16.value) {
+				printk(KERN_ERR "module %s: HI16/LO16 value mistmatch : %08x vs %08x\n", 
+						me->name,
+						hi16.value,
+						v); 
+				return -ENOEXEC;
+			}
+
+			lo16.addr = location;
+			lo16.value = v;
+
+			relocate_hilo16(&hi16, &lo16);
 			break;
-		}
 
 		default:
 			printk(KERN_ERR "module %s: Unknown relocation: %u\n",
@@ -225,6 +205,9 @@
 		       unsigned int relsec,
 		       struct module *me)
 {
+	if (sechdrs[relsec].sh_size == 0)
+		return 0;
+
 	printk(KERN_ERR "module %s: ADD RELOCATION unsupported\n",
 	       me->name);
 	return -ENOEXEC;

--BXVAT5kNtrzKuDFl--
