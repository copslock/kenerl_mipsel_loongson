Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5JEMps19426
	for linux-mips-outgoing; Tue, 19 Jun 2001 07:22:51 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5JEMmV19423
	for <linux-mips@oss.sgi.com>; Tue, 19 Jun 2001 07:22:48 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 3563F902; Tue, 19 Jun 2001 16:22:45 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 000A242F6; Tue, 19 Jun 2001 16:23:02 +0200 (CEST)
Date: Tue, 19 Jun 2001 16:23:02 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: bitops.h ext2_ ops save/restore flags
Message-ID: <20010619162302.C10106@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,
i am just staring at the bitops as it seems they are the culprit for
the non working ext2 currently - While staring and comparing i found
that the mips ext2_set_bit and co do an save_and_cli/restore_flags
which is very obscure. I cant find any similar in other archs - I guess
the above is due to a possible "atomic" requirement which ext2 doesnt
seem to have (upper layer locking ?)

IMHO the patch cleans this:


Index: include/asm-mips/bitops.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/bitops.h,v
retrieving revision 1.16
diff -u -r1.16 bitops.h
--- include/asm-mips/bitops.h	2001/06/14 05:33:12	1.16
+++ include/asm-mips/bitops.h	2001/06/19 14:21:58
@@ -797,28 +797,24 @@
 #ifdef __MIPSEB__
 extern __inline__ int ext2_set_bit(int nr,void * addr)
 {
-	int		mask, retval, flags;
+	int		mask, retval;
 	unsigned char	*ADDR = (unsigned char *) addr;
 
 	mask = 1 << (nr & 0x07);
-	save_and_cli(flags);
 	retval = (mask & *ADDR) != 0;
 	*ADDR |= mask;
-	restore_flags(flags);
 	return retval;
 }
 
 extern __inline__ int ext2_clear_bit(int nr, void * addr)
 {
-	int		mask, retval, flags;
+	int		mask, retval;
 	unsigned char	*ADDR = (unsigned char *) addr;
 
 	ADDR += nr >> 3;
 	mask = 1 << (nr & 0x07);
-	save_and_cli(flags);
 	retval = (mask & *ADDR) != 0;
 	*ADDR &= ~mask;
-	restore_flags(flags);
 	return retval;
 }


Comments ?
 
Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
