Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 17:54:20 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:54717 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993024AbeE1PyOBWeUc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 May 2018 17:54:14 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 95AB3AE90;
        Mon, 28 May 2018 15:54:07 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Make elf2ecoff work on 64bit host machines
Date:   Mon, 28 May 2018 13:26:24 +0200
Message-Id: <20180528112625.25509-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.6
Return-Path: <tbogendoerfer@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbogendoerfer@suse.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Use fixed width integer types for ecoff structs to make elf2ecoff work
on 64bit host machines

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/boot/ecoff.h     | 58 +++++++++++++++++++++++-----------------------
 arch/mips/boot/elf2ecoff.c | 29 +++++++++++------------
 2 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/arch/mips/boot/ecoff.h b/arch/mips/boot/ecoff.h
index b3e73c22c345..9eb4167ef979 100644
--- a/arch/mips/boot/ecoff.h
+++ b/arch/mips/boot/ecoff.h
@@ -3,13 +3,13 @@
  * Some ECOFF definitions.
  */
 typedef struct filehdr {
-	unsigned short	f_magic;	/* magic number */
-	unsigned short	f_nscns;	/* number of sections */
-	long		f_timdat;	/* time & date stamp */
-	long		f_symptr;	/* file pointer to symbolic header */
-	long		f_nsyms;	/* sizeof(symbolic hdr) */
-	unsigned short	f_opthdr;	/* sizeof(optional hdr) */
-	unsigned short	f_flags;	/* flags */
+	uint16_t	f_magic;	/* magic number */
+	uint16_t	f_nscns;	/* number of sections */
+	int32_t		f_timdat;	/* time & date stamp */
+	int32_t		f_symptr;	/* file pointer to symbolic header */
+	int32_t		f_nsyms;	/* sizeof(symbolic hdr) */
+	uint16_t	f_opthdr;	/* sizeof(optional hdr) */
+	uint16_t	f_flags;	/* flags */
 } FILHDR;
 #define FILHSZ	sizeof(FILHDR)
 
@@ -18,32 +18,32 @@ typedef struct filehdr {
 
 typedef struct scnhdr {
 	char		s_name[8];	/* section name */
-	long		s_paddr;	/* physical address, aliased s_nlib */
-	long		s_vaddr;	/* virtual address */
-	long		s_size;		/* section size */
-	long		s_scnptr;	/* file ptr to raw data for section */
-	long		s_relptr;	/* file ptr to relocation */
-	long		s_lnnoptr;	/* file ptr to gp histogram */
-	unsigned short	s_nreloc;	/* number of relocation entries */
-	unsigned short	s_nlnno;	/* number of gp histogram entries */
-	long		s_flags;	/* flags */
+	int32_t		s_paddr;	/* physical address, aliased s_nlib */
+	int32_t		s_vaddr;	/* virtual address */
+	int32_t		s_size;		/* section size */
+	int32_t		s_scnptr;	/* file ptr to raw data for section */
+	int32_t		s_relptr;	/* file ptr to relocation */
+	int32_t		s_lnnoptr;	/* file ptr to gp histogram */
+	uint16_t	s_nreloc;	/* number of relocation entries */
+	uint16_t	s_nlnno;	/* number of gp histogram entries */
+	int32_t		s_flags;	/* flags */
 } SCNHDR;
 #define SCNHSZ		sizeof(SCNHDR)
-#define SCNROUND	((long)16)
+#define SCNROUND	((int32_t)16)
 
 typedef struct aouthdr {
-	short	magic;		/* see above				*/
-	short	vstamp;		/* version stamp			*/
-	long	tsize;		/* text size in bytes, padded to DW bdry*/
-	long	dsize;		/* initialized data "  "		*/
-	long	bsize;		/* uninitialized data "	  "		*/
-	long	entry;		/* entry pt.				*/
-	long	text_start;	/* base of text used for this file	*/
-	long	data_start;	/* base of data used for this file	*/
-	long	bss_start;	/* base of bss used for this file	*/
-	long	gprmask;	/* general purpose register mask	*/
-	long	cprmask[4];	/* co-processor register masks		*/
-	long	gp_value;	/* the gp value used for this object	*/
+	int16_t	magic;		/* see above				*/
+	int16_t	vstamp;		/* version stamp			*/
+	int32_t	tsize;		/* text size in bytes, padded to DW bdry*/
+	int32_t	dsize;		/* initialized data "  "		*/
+	int32_t	bsize;		/* uninitialized data "	  "		*/
+	int32_t	entry;		/* entry pt.				*/
+	int32_t	text_start;	/* base of text used for this file	*/
+	int32_t	data_start;	/* base of data used for this file	*/
+	int32_t	bss_start;	/* base of bss used for this file	*/
+	int32_t	gprmask;	/* general purpose register mask	*/
+	int32_t	cprmask[4];	/* co-processor register masks		*/
+	int32_t	gp_value;	/* the gp value used for this object	*/
 } AOUTHDR;
 #define AOUTHSZ sizeof(AOUTHDR)
 
diff --git a/arch/mips/boot/elf2ecoff.c b/arch/mips/boot/elf2ecoff.c
index 266c8137e859..8322282f93b0 100644
--- a/arch/mips/boot/elf2ecoff.c
+++ b/arch/mips/boot/elf2ecoff.c
@@ -55,8 +55,8 @@
 /* -------------------------------------------------------------------- */
 
 struct sect {
-	unsigned long vaddr;
-	unsigned long len;
+	uint32_t vaddr;
+	uint32_t len;
 };
 
 int *symTypeTable;
@@ -153,16 +153,16 @@ static char *saveRead(int file, off_t offset, off_t len, char *name)
 }
 
 #define swab16(x) \
-	((unsigned short)( \
-		(((unsigned short)(x) & (unsigned short)0x00ffU) << 8) | \
-		(((unsigned short)(x) & (unsigned short)0xff00U) >> 8) ))
+	((uint16_t)( \
+		(((uint16_t)(x) & (uint16_t)0x00ffU) << 8) | \
+		(((uint16_t)(x) & (uint16_t)0xff00U) >> 8) ))
 
 #define swab32(x) \
 	((unsigned int)( \
-		(((unsigned int)(x) & (unsigned int)0x000000ffUL) << 24) | \
-		(((unsigned int)(x) & (unsigned int)0x0000ff00UL) <<  8) | \
-		(((unsigned int)(x) & (unsigned int)0x00ff0000UL) >>  8) | \
-		(((unsigned int)(x) & (unsigned int)0xff000000UL) >> 24) ))
+		(((uint32_t)(x) & (uint32_t)0x000000ffUL) << 24) | \
+		(((uint32_t)(x) & (uint32_t)0x0000ff00UL) <<  8) | \
+		(((uint32_t)(x) & (uint32_t)0x00ff0000UL) >>  8) | \
+		(((uint32_t)(x) & (uint32_t)0xff000000UL) >> 24) ))
 
 static void convert_elf_hdr(Elf32_Ehdr * e)
 {
@@ -274,7 +274,7 @@ int main(int argc, char *argv[])
 	struct aouthdr eah;
 	struct scnhdr esecs[6];
 	int infile, outfile;
-	unsigned long cur_vma = ULONG_MAX;
+	uint32_t cur_vma = UINT32_MAX;
 	int addflag = 0;
 	int nosecs;
 
@@ -518,7 +518,7 @@ int main(int argc, char *argv[])
 
 		for (i = 0; i < nosecs; i++) {
 			printf
-			    ("Section %d: %s phys %lx  size %lx	 file offset %lx\n",
+			    ("Section %d: %s phys %x  size %x	 file offset %x\n",
 			     i, esecs[i].s_name, esecs[i].s_paddr,
 			     esecs[i].s_size, esecs[i].s_scnptr);
 		}
@@ -564,17 +564,16 @@ int main(int argc, char *argv[])
 		   the section can be loaded before copying. */
 		if (ph[i].p_type == PT_LOAD && ph[i].p_filesz) {
 			if (cur_vma != ph[i].p_vaddr) {
-				unsigned long gap =
-				    ph[i].p_vaddr - cur_vma;
+				uint32_t gap = ph[i].p_vaddr - cur_vma;
 				char obuf[1024];
 				if (gap > 65536) {
 					fprintf(stderr,
-						"Intersegment gap (%ld bytes) too large.\n",
+						"Intersegment gap (%d bytes) too large.\n",
 						gap);
 					exit(1);
 				}
 				fprintf(stderr,
-					"Warning: %ld byte intersegment gap.\n",
+					"Warning: %d byte intersegment gap.\n",
 					gap);
 				memset(obuf, 0, sizeof obuf);
 				while (gap) {
-- 
2.13.6
