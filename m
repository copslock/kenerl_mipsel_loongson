Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2E5RDt25537
	for linux-mips-outgoing; Wed, 13 Mar 2002 21:27:13 -0800
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2E5R9925533
	for <linux-mips@oss.sgi.com>; Wed, 13 Mar 2002 21:27:09 -0800
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Wed, 13 Mar 2002 21:28:16 -0800
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from mail-sj1-1.sj.broadcom.com (mail-sj1-1.sj.broadcom.com
 [10.16.128.231]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id VAA06989 for <linux-mips@oss.sgi.com>; Wed, 13 Mar 2002 21:28:37
 -0800 (PST)
Received: from broadcom.com (kwalker@dt-sj3-158 [10.21.64.158]) by
 mail-sj1-1.sj.broadcom.com (8.8.8/8.8.8/MS01) with ESMTP id VAA00169
 for <linux-mips@oss.sgi.com>; Wed, 13 Mar 2002 21:28:37 -0800 (PST)
Message-ID: <3C903505.36BE8BCC@broadcom.com>
Date: Wed, 13 Mar 2002 21:28:37 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: HIGHMEM bug
X-WSS-ID: 108EEB7A4083630-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

After several days of hunting, I found a bug in the MIPS highmem code. 
A comparison of arch/mips/mm/init.c to arch/i386/mm/init.c supports my
claim.

The PGD entry for the fixed mapping virtual addresses is never
allocated.  So what happens is that the fixed mapping pte's get stuffed
into the invalid_pte_table!  Then, subsequent accesses that ought to
fault might alias into these PTE's and get satisfied with somebody
else's physical page.

The following patch seems to help a great deal:

Index: arch/mips/mm/init.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/init.c,v
retrieving revision 1.38.2.4
diff -u -r1.38.2.4 init.c
--- arch/mips/mm/init.c 2002/02/06 18:29:15     1.38.2.4
+++ arch/mips/mm/init.c 2002/03/14 05:25:12
@@ -206,6 +206,12 @@
 
 #ifdef CONFIG_HIGHMEM
        /*
+        * Fixed mappings:
+        */
+       vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
+       fixrange_init(vaddr, 0, pgd_base);
+
+       /*
         * Permanent kmaps:
         */
        vaddr = PKMAP_BASE;
