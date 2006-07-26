Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2006 01:33:01 +0100 (BST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:33048 "EHLO
	smtp2.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S8134012AbWGZAcu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Jul 2006 01:32:50 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by smtp2.caviumnetworks.com with NetIQ MailMarshal (v6,0,3,8)
	id <B44c6b8230000>; Tue, 25 Jul 2006 20:32:35 -0400
Received: from [192.168.16.29] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 25 Jul 2006 17:32:43 -0700
Message-ID: <44C6B829.8050508@caviumnetworks.com>
Date:	Tue, 25 Jul 2006 17:32:41 -0700
From:	Chad Reese <creese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20060629 Debian/1.7.8-1sarge7.1
X-Accept-Language: en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: 64bit kernel/N32 userspace - shmctl corrupts userspace memory
Content-Type: multipart/mixed;
 boundary="------------020004060209090703030702"
X-OriginalArrivalTime: 26 Jul 2006 00:32:43.0171 (UTC) FILETIME=[0225DF30:01C6B04B]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: creese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020004060209090703030702
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

If you're running a 64bit kernel with N32 userspace, shmctl will corrupt
memory in userspace. When copy_shmid_to_user() is called, it copies the
entire kernel shmid_ds into userspace. For a 64bit kernel, this is 88
bytes. In N32 userspace it is 76 bytes.

My hack to get around the problem is attached, but I expect someone here
will be able to come up with a better fix. shmid_ds contains a lot of
members that are marked unused. Are these really useless?

Chad


--------------020004060209090703030702
Content-Type: text/x-patch;
 name="shared_memory_shmctl_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="shared_memory_shmctl_fix.patch"

Index: linux/ipc/shm.c
===================================================================
RCS file: /repository/octsw/linux/kernel_2.6/linux/ipc/shm.c,v
retrieving revision 1.1.1.6
retrieving revision 1.2
diff -u -r1.1.1.6 -r1.2
--- linux/ipc/shm.c	7 Jun 2006 19:19:51 -0000	1.1.1.6
+++ linux/ipc/shm.c	22 Jul 2006 02:26:11 -0000	1.2
@@ -321,7 +321,11 @@
 		out.shm_lpid	= in->shm_lpid;
 		out.shm_nattch	= in->shm_nattch;
 
-		return copy_to_user(buf, &out, sizeof(out));
+		/* Use offsetof() instead of sizeof() since N32 userspace has a 
+		    different size including the unused fields. This just copies 
+		    what is used. The old method would corrupt data after the 
+		    structure */
+		return copy_to_user(buf, &out, offsetof(struct shmid_ds, shm_unused2));
 	    }
 	default:
 		return -EINVAL;

--------------020004060209090703030702--
