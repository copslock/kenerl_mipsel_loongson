Received:  by oss.sgi.com id <S554213AbRBBDXU>;
	Thu, 1 Feb 2001 19:23:20 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:63481 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S554203AbRBBDXF>;
	Thu, 1 Feb 2001 19:23:05 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f123JgI27051;
	Thu, 1 Feb 2001 19:19:42 -0800
Message-ID: <3A7A27D5.C27E3AA5@mvista.com>
Date:   Thu, 01 Feb 2001 19:21:57 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: NFS problem - nfs_refresh_inode: inode number mismatch 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I use nfs root fs to boot my MIPS box.  However, after several reboots, I
sometimes get the following error message.  Most of the time it seems
harmless, but sometime it seems that /proc may not get mounted.  Does anybody
have an idea?

...
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 10.23.3.2, my address is 10.23.3.17
kmem_create: Forcing size word alignment - nfs_fh
Looking up port of RPC 100003/2 on 10.23.3.2
Looking up port of RPC 100005/2 on 10.23.3.2
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 100k freed
nfs_refresh_inode: inode number mismatch
expected (0x305/0x1d265), got (0x305/0xd0d6)
nfs_refresh_inode: inode number mismatch
expected (0x305/0xd0d6), got (0x305/0x1d265)
...

Jun
