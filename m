Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3KBaEA20550
	for linux-mips-outgoing; Fri, 20 Apr 2001 04:36:14 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3KBaCM20545
	for <linux-mips@oss.sgi.com>; Fri, 20 Apr 2001 04:36:13 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA22991
	for <linux-mips@oss.sgi.com>; Fri, 20 Apr 2001 04:36:17 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA17396
	for <linux-mips@oss.sgi.com>; Fri, 20 Apr 2001 04:36:15 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id NAA23386
	for <linux-mips@oss.sgi.com>; Fri, 20 Apr 2001 13:35:28 +0200 (MEST)
Message-ID: <3AE01EFF.850580E4@mips.com>
Date: Fri, 20 Apr 2001 13:35:27 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Problem with large IDE disk on a MIPS bigendian system.
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have noticed that a bigendian kernel can't quite handled IDE disk,
which is larger than 8GB and support LBA mode (logical addressing mode).

The IDE driver read some of the data incorrectly and therefore doesn't
recognize that the drive support LBA mode, and therefore assume that the
drive use CHS mode (physical addressing mode). The ATA spec tells large
drives to return C/H/S = 16383/16/63 independent of their size, which in
this case result in the IDE drive believe that the disk is only 8GB.

I looked a little bit on the MIPS specific IDE code (in
include/asm-mips/ide.h) and the way things are handled for bigendian
systems.
I have attached a patch below which should handle the IDE data
correctly. I also believe it's more in sync with the other bigendian
architectures.
Now I can see the full size of my 30GB disk, it is hard to find a
smaller disk these days :-)

/Carsten

Index: include/asm-mips/ide.h
===================================================================
RCS file: /home/repository/sw/linux-2.4.0/include/asm-mips/ide.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 ide.h
--- include/asm-mips/ide.h      2001/02/26 09:18:02     1.1.1.2
+++ include/asm-mips/ide.h      2001/04/20 09:57:59
@@ -14,6 +14,7 @@
 #ifdef __KERNEL__

 #include <linux/config.h>
+#include <asm/io.h>

 #ifndef MAX_HWIFS
 # ifdef CONFIG_BLK_DEV_IDEPCI
@@ -89,13 +90,21 @@
 typedef union {
        unsigned all                    : 8;    /* all of the bits
together */
        struct {
+#ifdef __MIPSEB__
+               unsigned bit7           : 1;    /* always 1 */
+               unsigned lba            : 1;    /* using LBA instead of
CHS */
+               unsigned bit5           : 1;    /* always 1 */
+               unsigned unit           : 1;    /* drive select number,
0 or 1 */
+               unsigned head           : 4;    /* always zeros here */
+#else
                unsigned head           : 4;    /* always zeros here */
                unsigned unit           : 1;    /* drive select number,
0 or 1 */
                unsigned bit5           : 1;    /* always 1 */
                unsigned lba            : 1;    /* using LBA instead of
CHS */
                unsigned bit7           : 1;    /* always 1 */
+#endif
        } b;
-       } select_t;
+} select_t;

 static __inline__ int ide_request_irq(unsigned int irq, void
(*handler)(int,void *, struct pt_regs *),
                        unsigned long flags, const char *device, void
*dev_id)
@@ -125,57 +134,99 @@
        ide_ops->ide_release_region(from, extent);
 }

+#undef  SUPPORT_SLOW_DATA_PORTS
+#define SUPPORT_SLOW_DATA_PORTS 0

-#if defined(CONFIG_SWAP_IO_SPACE) && defined(__MIPSEB__)
+#undef  SUPPORT_VLB_SYNC
+#define SUPPORT_VLB_SYNC 0

-#ifdef insl
-#undef insl
-#endif
-#ifdef outsl
-#undef outsl
-#endif
-#ifdef insw
-#undef insw
-#endif
-#ifdef outsw
-#undef outsw
-#endif
+#if defined(__MIPSEB__)

-#define insw(p,a,c)
\
-do {
\
-       unsigned short *ptr = (unsigned short *)(a);
\
-       unsigned int i = (c);
\
-       while (i--)
\
-               *ptr++ = inw(p);
\
-} while (0)
-#define insl(p,a,c)
\
-do {
\
-       unsigned long *ptr = (unsigned long *)(a);
\
-       unsigned int i = (c);
\
-       while (i--)
\
-               *ptr++ = inl(p);
\
-} while (0)
-#define outsw(p,a,c)
\
-do {
\
-       unsigned short *ptr = (unsigned short *)(a);
\
-       unsigned int i = (c);
\
-       while (i--)
\
-               outw(*ptr++, (p));
\
-} while (0)
-#define outsl(p,a,c) {
\
-       unsigned long *ptr = (unsigned long *)(a);
\
-       unsigned int i = (c);
\
-       while (i--)
\
-               outl(*ptr++, (p));
\
-} while (0)
+#define T_CHAR          (0x0000)        /* char:  don't touch  */
+#define T_SHORT         (0x4000)        /* short: 12 -> 21     */
+#define T_INT           (0x8000)        /* int:   1234 -> 4321 */
+#define T_TEXT          (0xc000)        /* text:  12 -> 21     */
+
+#define T_MASK_TYPE     (0xc000)
+#define T_MASK_COUNT    (0x3fff)
+
+#define D_CHAR(cnt)     (T_CHAR  | (cnt))
+#define D_SHORT(cnt)    (T_SHORT | (cnt))
+#define D_INT(cnt)      (T_INT   | (cnt))
+#define D_TEXT(cnt)     (T_TEXT  | (cnt))
+
+static u_short driveid_types[] = {
+       D_SHORT(10),    /* config - vendor2 */
+       D_TEXT(20),     /* serial_no */
+       D_SHORT(3),     /* buf_type - ecc_bytes */
+       D_TEXT(48),     /* fw_rev - model */
+       D_CHAR(2),      /* max_multsect - vendor3 */
+       D_SHORT(1),     /* dword_io */
+       D_CHAR(2),      /* vendor4 - capability */
+       D_SHORT(1),     /* reserved50 */
+       D_CHAR(4),      /* vendor5 - tDMA */
+       D_SHORT(4),     /* field_valid - cur_sectors */
+       D_INT(1),       /* cur_capacity */
+       D_CHAR(2),      /* multsect - multsect_valid */
+       D_INT(1),       /* lba_capacity */
+       D_SHORT(194)    /* dma_1word - reservedyy */
+};

-#endif /* defined(CONFIG_SWAP_IO_SPACE) && defined(__MIPSEB__)  */
+#define num_driveid_types
(sizeof(driveid_types)/sizeof(*driveid_types))

+static __inline__ void ide_fix_driveid(struct hd_driveid *id)
+{
+       u_char *p = (u_char *)id;
+       int i, j, cnt;
+       u_char t;
+
+       for (i = 0; i < num_driveid_types; i++) {
+               cnt = driveid_types[i] & T_MASK_COUNT;
+               switch (driveid_types[i] & T_MASK_TYPE) {
+               case T_CHAR:
+                       p += cnt;
+                       break;
+               case T_SHORT:
+                       for (j = 0; j < cnt; j++) {
+                               t = p[0];
+                               p[0] = p[1];
+                               p[1] = t;
+                               p += 2;
+                       }
+                       break;
+               case T_INT:
+                       for (j = 0; j < cnt; j++) {
+                               t = p[0];
+                               p[0] = p[3];
+                               p[3] = t;
+                               t = p[1];
+                               p[1] = p[2];
+                               p[2] = t;
+                               p += 4;
+                       }
+                       break;
+               case T_TEXT:
+                       for (j = 0; j < cnt; j += 2) {
+                               t = p[0];
+                               p[0] = p[1];
+                               p[1] = t;
+                               p += 2;
+                       }
+                       break;
+               };
+       }
+}
+
+#else /* defined(CONFIG_SWAP_IO_SPACE) && defined(__MIPSEB__)  */
+
+#define ide_fix_driveid(id)            do {} while (0)
+
+#endif
+
 /*
  * The following are not needed for the non-m68k ports
  */
 #define ide_ack_intr(hwif)             (1)
-#define ide_fix_driveid(id)            do {} while (0)
 #define ide_release_lock(lock)         do {} while (0)
 #define ide_get_lock(lock, hdlr, data) do {} while (0)




--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
