Received:  by oss.sgi.com id <S553823AbQLKXg3>;
	Mon, 11 Dec 2000 15:36:29 -0800
Received: from hybrid-024-221-181-223.ca.sprintbbd.net ([24.221.181.223]:17648
        "EHLO hermes.mvista.com") by oss.sgi.com with ESMTP
	id <S553817AbQLKXgN>; Mon, 11 Dec 2000 15:36:13 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eBC0Y8S00995;
	Mon, 11 Dec 2000 16:34:08 -0800
Message-ID: <3A35D5FC.11372085@mvista.com>
Date:   Mon, 11 Dec 2000 23:38:36 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: Should /dev/kmem support above 0x80000000 area?
References: <3A3051C1.DCFC749B@mvista.com> <20001209003222.A10669@bacchus.dhis.org>
Content-Type: multipart/mixed;
 boundary="------------F2A825EFF85ED6D50B0B9820"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------F2A825EFF85ED6D50B0B9820
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:
> 
> Send me the patch and I'll comment.
> 
>   Ralf

Here is my patch.  I think it should be safe for mips64.  Please double check
it.

Jun
--------------F2A825EFF85ED6D50B0B9820
Content-Type: text/plain; charset=us-ascii;
 name="linux-mips-kmem-kseg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-mips-kmem-kseg.patch"

diff -Nru linux/drivers/char/mem.c.orig linux/drivers/char/mem.c
--- linux/drivers/char/mem.c.orig	Mon Dec 11 22:07:19 2000
+++ linux/drivers/char/mem.c	Mon Dec 11 22:38:11 2000
@@ -258,6 +258,14 @@
 		count -= read;
 	}
 
+#if defined(__mips__)
+        if (KSEGX(p)) {
+		if (copy_to_user(buf, (char*)p, count))
+			return -EFAULT;
+		return count+read;
+	}
+#endif
+
 	kbuf = (char *)__get_free_page(GFP_KERNEL);
 	if (!kbuf)
 		return -ENOMEM;
@@ -288,6 +296,12 @@
 			  size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
+
+#if defined(__mips__)
+        if (KSEGX(p)) {
+		return do_write_mem(file, (void*)p, p, buf, count, ppos);
+	}
+#endif
 
 	if (p >= (unsigned long) high_memory)
 		return 0;

--------------F2A825EFF85ED6D50B0B9820--
