Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6VKxxo11445
	for linux-mips-outgoing; Tue, 31 Jul 2001 13:59:59 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6VKxxV11442
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 13:59:59 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f6VKxrTv032688;
	Tue, 31 Jul 2001 13:59:53 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f6VKxrVD032684;
	Tue, 31 Jul 2001 13:59:53 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Tue, 31 Jul 2001 13:59:53 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: linux-mips@oss.sgi.com
cc: linux-mips-kernel@lists.sourceforge.net
Subject: sys_mips problems
Message-ID: <Pine.LNX.4.10.10107311357530.28897-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Since I was having problems with everything sefaulting due to the sys_mips
bug I tried the patch floating around. It fixed the segfault problem but
instead I get this error. Anyone knows why?

: error while loading shared libraries: libc.so.6: cannot stat shared
object: Error 14
