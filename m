Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Sep 2004 21:54:15 +0100 (BST)
Received: from 64-60-250-34.cust.telepacific.net ([IPv6:::ffff:64.60.250.34]:19008
	"EHLO panta-1.pantasys.com") by linux-mips.org with ESMTP
	id <S8225196AbUIIUyL>; Thu, 9 Sep 2004 21:54:11 +0100
Received: from [10.1.40.165] ([10.1.40.1]) by panta-1.pantasys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 9 Sep 2004 13:47:17 -0700
Message-ID: <4140C2E5.6050006@pantasys.com>
Date: Thu, 09 Sep 2004 13:53:57 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Subject: [PATCH 2.6] make nfsroot compile
Content-Type: multipart/mixed;
 boundary="------------020201010202050109090506"
X-OriginalArrivalTime: 09 Sep 2004 20:47:17.0359 (UTC) FILETIME=[3195BFF0:01C496AE]
Return-Path: <peter@pantasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@pantasys.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020201010202050109090506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ralf,

I needed to merge this fix in from Linus's tree to make things work with 
a NFS root. Now I can boot up broadcom's 1250 :-D

peter

Signed-off-by: Peter Buckingham <peter@pantasys.com>

--------------020201010202050109090506
Content-Type: text/plain;
 name="p"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p"

Index: fs/nfs/nfsroot.c
===================================================================
RCS file: /home/cvs/linux/fs/nfs/nfsroot.c,v
retrieving revision 1.30
diff -u -r1.30 nfsroot.c
--- fs/nfs/nfsroot.c	24 Aug 2004 15:10:14 -0000	1.30
+++ fs/nfs/nfsroot.c	9 Sep 2004 20:53:56 -0000
@@ -495,8 +495,10 @@
 	if (status < 0)
 		printk(KERN_ERR "Root-NFS: Server returned error %d "
 				"while mounting %s\n", status, nfs_path);
-	else
-		nfs_copy_fh(nfs_data.root, fh);
+	else {
+		nfs_data.root.size=fh.size;
+		memcpy(nfs_data.root.data, fh.data, fh.size);
+	}
 
 	return status;
 }

--------------020201010202050109090506--
