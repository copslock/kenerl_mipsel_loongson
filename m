Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2002 09:35:40 +0200 (CEST)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:49687 "HELO
	topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S1122978AbSICHfj>; Tue, 3 Sep 2002 09:35:39 +0200
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [80.63.7.146]) with SMTP; 3 Sep 2002 07:35:37 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id CBB21B471; Tue,  3 Sep 2002 16:35:28 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id QAA72123; Tue, 3 Sep 2002 16:35:28 +0900 (JST)
Date: Tue, 03 Sep 2002 16:37:11 +0900 (JST)
Message-Id: <20020903.163711.104027127.nemoto@toshiba-tops.co.jp>
To: werkt@csh.rit.edu
Cc: linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: root-nfs hang and error
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <Pine.SOL.4.31.0209021634320.24635-100000@fury.csh.rit.edu>
References: <Pine.SOL.4.31.0209021634320.24635-100000@fury.csh.rit.edu>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 2 Sep 2002 16:43:55 -0400 (EDT), George Gensure <werkt@csh.rit.edu> said:
werkt> When trying to mount an nfs to install to, I end up with about
werkt> a 5 minute hang (afterwards, though, all file transfer is
werkt> seamless).

It seems the mount is waiting for lockd.  On diskless install,
dbootstrap try to mount nfs partition without "nolock" option.  For
workaround, you can do "Execute a Shell" and type

 # mount -o nolock server:/path /target

instead of "Mount a Previously-Initialized Partition" on diskless
install.

Isn't this a bug of dbootstrap ?  Here is a patch.

diff -u boot-floppies.org/utilities/dbootstrap/partition_config.c boot-floppies/utilities/dbootstrap/partition_config.c
--- boot-floppies.org/utilities/dbootstrap/partition_config.c	Mon Sep  2 15:33:34 2002
+++ boot-floppies/utilities/dbootstrap/partition_config.c	Mon Sep  2 19:34:02 2002
@@ -862,6 +862,13 @@
     if(strcmp(type,"msdos")==0 && !is_filesystem_supported("vfat"))
        type="vfat";
     INFOMSG("Mounting %s partition %s on %s", type, partition->name, real_mount_point);
+#ifdef NFSROOT
+    if (!strncmp(type, "nfs", 4))
+      snprintf(prtbuf, sizeof(prtbuf),
+	       "mount -t nfs -o nolock,rsize=8192,wsize=8192 %s %s",
+	       partition->name, real_mount_point);
+    else
+#endif
     snprintf(prtbuf, sizeof(prtbuf), "mount -t %s %s %s", type, partition->name, real_mount_point);
     status = execlog(prtbuf, LOG_INFO);
   }
--- ---

---
Atsushi Nemoto
