Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g16LVHZ32567
	for linux-mips-outgoing; Wed, 6 Feb 2002 13:31:17 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g16LVEA32554
	for <linux-mips@oss.sgi.com>; Wed, 6 Feb 2002 13:31:14 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id DEB56125C8; Wed,  6 Feb 2002 13:31:13 -0800 (PST)
Date: Wed, 6 Feb 2002 13:31:13 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: GNU C Library <libc-alpha@sources.redhat.com>
Cc: linux-mips@oss.sgi.com
Subject: PATCH: Fix <ldsodefs.h> for Linux/mips
Message-ID: <20020206133113.A29718@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

We have been using the wrong <ldsodefs.h> for Linux/mips. Here is a
patch.


H.J.
----
2002-02-06  H.J. Lu  <hjl@gnu.org>

	* sysdeps/mips/elf/ldsodefs.h: Make sure the right <ldsodefs.h>
	is included.

--- sysdeps/mips/elf/ldsodefs.h.mips	Sat Jul  7 16:46:05 2001
+++ sysdeps/mips/elf/ldsodefs.h	Wed Feb  6 13:25:17 2002
@@ -22,4 +22,4 @@
 
 #define DL_RO_DYN_SECTION 1
 
-#include <sysdeps/generic/ldsodefs.h>
+#include_next <ldsodefs.h>
