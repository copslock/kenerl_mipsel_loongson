Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5JEaad19818
	for linux-mips-outgoing; Tue, 19 Jun 2001 07:36:36 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5JEaZV19814
	for <linux-mips@oss.sgi.com>; Tue, 19 Jun 2001 07:36:35 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E4665909; Tue, 19 Jun 2001 16:36:33 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 9670A42F6; Tue, 19 Jun 2001 16:36:51 +0200 (CEST)
Date: Tue, 19 Jun 2001 16:36:51 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: Re: bitops.h ext2_ ops save/restore flags
Message-ID: <20010619163651.D10106@paradigm.rfc822.org>
References: <20010619162302.C10106@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010619162302.C10106@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Jun 19, 2001 at 04:23:02PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 19, 2001 at 04:23:02PM +0200, Florian Lohoff wrote:
> Hi,
> i am just staring at the bitops as it seems they are the culprit for
> the non working ext2 currently - While staring and comparing i found
> that the mips ext2_set_bit and co do an save_and_cli/restore_flags
> which is very obscure. I cant find any similar in other archs - I guess
> the above is due to a possible "atomic" requirement which ext2 doesnt
> seem to have (upper layer locking ?)

Another one - This only fixes the big endian case - the little
endian case still has the penalty of cli/restore on every bit set
as the ext2 macros get defined to the "atomic" ops defined there

I propose this patch


Index: include/asm-mips/bitops.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/bitops.h,v
retrieving revision 1.16
diff -u -r1.16 bitops.h
--- include/asm-mips/bitops.h	2001/06/14 05:33:12	1.16
+++ include/asm-mips/bitops.h	2001/06/19 14:32:51
@@ -887,8 +883,8 @@
 #else /* !(__MIPSEB__) */
 
 /* Native ext2 byte ordering, just collapse using defines. */
-#define ext2_set_bit(nr, addr) test_and_set_bit((nr), (addr))
-#define ext2_clear_bit(nr, addr) test_and_clear_bit((nr), (addr))
+#define ext2_set_bit(nr, addr) __test_and_set_bit((nr), (addr))
+#define ext2_clear_bit(nr, addr) __test_and_clear_bit((nr), (addr))
 #define ext2_test_bit(nr, addr) test_bit((nr), (addr))
 #define ext2_find_first_zero_bit(addr, size) find_first_zero_bit((addr), (size))
 #define ext2_find_next_zero_bit(addr, size, offset) \


Comments ?

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
