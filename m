Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0SEeRF08630
	for linux-mips-outgoing; Mon, 28 Jan 2002 06:40:27 -0800
Received: from river-bank.demon.co.uk (river-bank.demon.co.uk [193.237.18.135])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0SEeEP08600
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 06:40:14 -0800
Received: from river-bank.demon.co.uk(ratty.river-bank.demon.co.uk[192.168.0.4]) (4473 bytes) by river-bank.demon.co.uk
	via smtpd with P:smtp/R:bind_hosts/T:inet_zone_bind_smtp
	(sender: <phil@river-bank.demon.co.uk>) 
	id <m16VC1H-000SVDC@river-bank.demon.co.uk>
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 13:40:23 +0000 (GMT)
	(Smail-3.2.0.111 2000-Feb-17 #1 built 2001-Jan-12)
Message-ID: <3C5553E7.7DFDBB55@river-bank.demon.co.uk>
Date: Mon, 28 Jan 2002 13:36:39 +0000
From: Phil Thompson <phil@river-bank.demon.co.uk>
Organization: At Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: pgd_init() Patch
Content-Type: multipart/mixed;
 boundary="------------CBB8CDD6DA28F78586CD521A"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------CBB8CDD6DA28F78586CD521A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

While trying to understand the changes needed for discontiguous memory I
came across this...

In paging_init() there are two calls to pgd_init()...

        /* Initialize the entire pgd.  */
        pgd_init((unsigned long)swapper_pg_dir);
        pgd_init((unsigned long)swapper_pg_dir + PAGE_SIZE / 2);

...where the assumption seems to be that the PGD is one page and each
call initialises half of it. Most of the CPU implementations of
pgd_init() nearly do this because they initialise USER_PTRS_PER_PGD
entries. The problems with this are...

- pg-r3k.c and pg-r4k.S don't use USER_PTRS_PER_PGD and initialise a
page's worth each time. This means the second call to pgd_init()
initialises half a page's worth of memory after the end of
swapper_pg_dir.

- USER_PTRS_PER_PGD is defined as TASK_SIZE/PGDIR_SIZE. However,
because, TASK_SIZE is actually defined as one less that the maximum task
size there is a rounding error that means that USER_PTRS_PER_PGD works
out at 511 rather than 512. This means that entries 511 and 1023 of
swapper_pg_dir don't get initialised.

The corresponding mips64 code has only the first call to pgd_init() and
each implementation of pgd_init() initialises PTRS_PER_PGD entries,
where PTRS_PER_PGD is simple defined as 1024.

The attached patch applies the mips64 approach to the mips code.

Should USER_PTRS_PER_PGD be defined as (TASK_SIZE/PGDIR_SIZE) + 1?

Phil
--------------CBB8CDD6DA28F78586CD521A
Content-Type: text/plain; charset=us-ascii;
 name="mm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm.patch"

diff -ruN mm.orig/c-sb1.c mm/c-sb1.c
--- mm.orig/c-sb1.c	Wed Dec 12 16:25:01 2001
+++ mm/c-sb1.c	Mon Jan 28 12:37:20 2002
@@ -44,7 +44,7 @@
 	unsigned long *p = (unsigned long *) page;
 	int i;
 
-	for (i = 0; i < USER_PTRS_PER_PGD; i+=8) {
+	for (i = 0; i < PTRS_PER_PGD; i+=8) {
 		p[i + 0] = (unsigned long) invalid_pte_table;
 		p[i + 1] = (unsigned long) invalid_pte_table;
 		p[i + 2] = (unsigned long) invalid_pte_table;
diff -ruN mm.orig/init.c mm/init.c
--- mm.orig/init.c	Fri Jan 25 14:17:12 2002
+++ mm/init.c	Mon Jan 28 12:37:36 2002
@@ -152,7 +152,6 @@
 
 	/* Initialize the entire pgd.  */
 	pgd_init((unsigned long)swapper_pg_dir);
-	pgd_init((unsigned long)swapper_pg_dir + PAGE_SIZE / 2);
 
 	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 	low = max_low_pfn;
diff -ruN mm.orig/pg-mips32.c mm/pg-mips32.c
--- mm.orig/pg-mips32.c	Tue Oct 23 02:02:46 2001
+++ mm/pg-mips32.c	Mon Jan 28 12:37:56 2002
@@ -127,7 +127,7 @@
 	unsigned long *p = (unsigned long *) page;
 	int i;
 
-	for(i = 0; i < USER_PTRS_PER_PGD; i+=8) {
+	for(i = 0; i < PTRS_PER_PGD; i+=8) {
 		p[i + 0] = (unsigned long) invalid_pte_table;
 		p[i + 1] = (unsigned long) invalid_pte_table;
 		p[i + 2] = (unsigned long) invalid_pte_table;
diff -ruN mm.orig/pg-r5432.c mm/pg-r5432.c
--- mm.orig/pg-r5432.c	Tue Oct 23 02:02:46 2001
+++ mm/pg-r5432.c	Mon Jan 28 12:38:30 2002
@@ -104,7 +104,7 @@
 	unsigned long *p = (unsigned long *) page;
 	int i;
 
-	for(i = 0; i < USER_PTRS_PER_PGD; i+=8) {
+	for(i = 0; i < PTRS_PER_PGD; i+=8) {
 		p[i + 0] = (unsigned long) invalid_pte_table;
 		p[i + 1] = (unsigned long) invalid_pte_table;
 		p[i + 2] = (unsigned long) invalid_pte_table;
diff -ruN mm.orig/pg-rm7k.c mm/pg-rm7k.c
--- mm.orig/pg-rm7k.c	Tue Oct 23 02:02:46 2001
+++ mm/pg-rm7k.c	Mon Jan 28 12:38:38 2002
@@ -107,7 +107,7 @@
 	unsigned long *p = (unsigned long *) page;
 	int i;
 
-	for (i = 0; i < USER_PTRS_PER_PGD; i+=8) {
+	for (i = 0; i < PTRS_PER_PGD; i+=8) {
 		p[i + 0] = (unsigned long) invalid_pte_table;
 		p[i + 1] = (unsigned long) invalid_pte_table;
 		p[i + 2] = (unsigned long) invalid_pte_table;

--------------CBB8CDD6DA28F78586CD521A--
