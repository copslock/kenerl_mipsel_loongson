Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6JNvof29791
	for linux-mips-outgoing; Thu, 19 Jul 2001 16:57:50 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6JNvnV29788
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 16:57:49 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f6JMvRW18525;
	Thu, 19 Jul 2001 15:57:27 -0700
Message-ID: <3B57730E.338B7B10@mvista.com>
Date: Thu, 19 Jul 2001 16:53:50 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: PATCH: wrong number of kbytes reported in freeing initrd
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


... a pretty much self-explanatory patch.

Jun

diff -Nru linux/arch/mips/mm/init.c.orig linux/arch/mips/mm/init.c
--- linux/arch/mips/mm/init.c.orig      Tue Mar 27 14:03:35 2001
+++ linux/arch/mips/mm/init.c   Thu Jul 19 16:39:31 2001
@@ -332,13 +332,14 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
+       unsigned long start1 = start;
        for (; start < end; start += PAGE_SIZE) {
                ClearPageReserved(virt_to_page(start));
                set_page_count(virt_to_page(start), 1);
                free_page(start);
                totalram_pages++;
        }
-       printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+       printk ("Freeing initrd memory: %ldk freed\n", (end - start1) >> 10);
 }
 #endif
