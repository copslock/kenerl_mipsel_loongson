Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49HYhX01884
	for linux-mips-outgoing; Wed, 9 May 2001 10:34:43 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49HYgF01881
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 10:34:42 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f49HYg030874;
	Wed, 9 May 2001 10:34:42 -0700
Message-ID: <3AF97FD0.7F382E49@mvista.com>
Date: Wed, 09 May 2001 10:35:12 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: lift the ioport_resource limit ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Currently IO_SPACE_LIMIT is 0xffff, which is probably borrowed from the legacy
i386 code.  Let us remove that limit, so that each machine does not have to
laboriously reset it. 

BTW, a prudent machine port should probably always reset it to a more sane
range - in any case having 0xffff default value does not make much sense.

Jun

diff -Nru linux/include/asm-mips/io.h.orig linux/include/asm-mips/io.h
--- linux/include/asm-mips/io.h.orig    Fri Feb  9 16:43:15 2001
+++ linux/include/asm-mips/io.h Wed May  9 10:26:44 2001
@@ -436,7 +436,7 @@
        __inslc((port),(addr),(count)) : \
        __insl((port),(addr),(count)))
 
-#define IO_SPACE_LIMIT 0xffff
+#define IO_SPACE_LIMIT 0xffffffff
 
 /*
  * The caches on some architectures aren't dma-coherent and have need to
