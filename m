Received:  by oss.sgi.com id <S305160AbQANSIX>;
	Fri, 14 Jan 2000 10:08:23 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:1059 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305155AbQANSIM>;
	Fri, 14 Jan 2000 10:08:12 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA26396; Fri, 14 Jan 2000 10:05:19 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA46828
	for linux-list;
	Fri, 14 Jan 2000 10:04:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA26829
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 14 Jan 2000 10:04:40 -0800 (PST)
	mail_from (adisaacs@mr-happy.com)
Received: from brainguy.tc.mtu.edu (brainguy.tc.mtu.edu [141.219.5.85]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA09172
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 10:03:50 -0800 (PST)
	mail_from (adisaacs@mr-happy.com)
Received: from crow.mr-happy.com (crow.mr-happy.com [172.19.3.81])
	by brainguy.tc.mtu.edu (8.8.8/8.8.7/mtumailer-1.2) with ESMTP id NAA18942
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 13:03:33 -0500 (EST)
Received: (from adisaacs@localhost)
	by crow.mr-happy.com (8.9.1b+Sun/HappyClient) id NAA09377
	for linux@cthulhu.engr.sgi.com; Fri, 14 Jan 2000 13:03:32 -0500 (EST)
Date:   Fri, 14 Jan 2000 13:03:32 -0500
From:   Andy Isaacson <adisaacs@mr-happy.com>
To:     linux@cthulhu.engr.sgi.com
Subject: linux on vw540 with 1.0006 PROM
Message-ID: <20000114130332.A9356@mr-happy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.mr-happy.com/~adisaacs/pgp.txt
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

OK, I know this is probably an exercise in futility (given SGI's
apparent lack of interest in seeing Linux on these machines) but I'm
trying my darndest to get linux up on a couple of 540's.  I finally
did get the kernel loaded after working around a PROM bug that causes
arclx.exe to lock up on boot.

I've enclosed the patch below.  You can get a binary from
http://www.lcse.umn.edu/~adi/visws/

Also there are the kernel config files I used.  Apparently something
in 2.2.12 breaks on the visws, so I'm using
2.2.10+visws.2210.28jul99.patch .

The machine is up now, but it seems to have some "issues"; mostly I've
noticed problems with device drivers (loading floppy.o locked up the
machine once; mounting a CD-ROM locked it up for a good 5 seconds,
etc).  I haven't really pounded on the machine yet, though.

diff -ur arcboot-21jul99/arclib/arc.c arcboot-13jan2000/arclib/arc.c
--- arcboot-21jul99/arclib/arc.c	Thu Jul  8 06:18:37 1999
+++ arcboot-13jan2000/arclib/arc.c	Thu Jan 13 22:40:24 2000
@@ -177,11 +177,18 @@
     return FVector->Close(FileID);
 }
 
 LONG
 ArcRead(ULONG FileID, VOID *Buffer, ULONG N, ULONG *Count)
 {
-    return FVector->Read(FileID, Buffer, N, Count);
+    /* XXX adi on our 540's with firmware version 1.006, passing a NULL
+     * to Read blows up.  Thus this workaround.
+     */
+    LONG retval;
+    ULONG mycount;
+    retval = FVector->Read(FileID, Buffer, N, &mycount);
+    if(Count)
+	*Count = mycount;
+    return retval;
 }
 
 
diff -ur arcboot-21jul99/loadlx/arclx.c arcboot-13jan2000/loadlx/arclx.c
--- arcboot-21jul99/loadlx/arclx.c	Wed Jul 21 09:26:54 1999
+++ arcboot-13jan2000/loadlx/arclx.c	Thu Jan 13 20:45:15 2000
@@ -321,7 +322,7 @@
 _start(LONG argc, CHAR *argv[], CHAR *envp[])
 {
     /* Print identification */
-    printf(ANSI_CLEAR "\nARC Linux unified loader, 21jul99\n\n");
+    printf(ANSI_CLEAR "\nARC Linux unified loader, 13jan2000\n\n");
 
     InitMalloc();
 
diff -ur arcboot-21jul99/loadlx/io.c arcboot-13jan2000/loadlx/io.c
--- arcboot-21jul99/loadlx/io.c	Wed Jul 21 09:47:53 1999
+++ arcboot-13jan2000/loadlx/io.c	Thu Jan 13 21:26:03 2000
@@ -289,6 +289,8 @@
 	LONG status;
 	ULONG nb = strlen(partition) + strlen(filename);
 	CHAR *path = (CHAR *)malloc(nb);
+
+	printf("arc_file_open\n");
 	if (path == NULL) {
 		Fatal("Malloc of %d for %s and %s failed\n",
 						nb, partition, filename);
@@ -318,6 +320,7 @@
 	if (status != ESUCCESS) {
 		Fatal("Read of 0x%x bytes at 0x%x failed\n", nb, off);
 	}
+	printf("ARC read finished\n");
 }
 
 
@@ -329,10 +332,13 @@
     ino_t file_inode;
     errcode_t status;
 
+    printf("file_open: %s %s\n", partition, filename);
     initialize_ext2_error_table();
 
+    printf("calling ext2open...\n");
     status = ext2fs_open(partition, 0, 0, 0, arc_io_manager, &fs);
     if (status != 0) {
+	printf("ext2open failed, trying arc_file_open\n");
         /* Maybe ARC can read it directly (FAT floppy, etc) */
         return arc_file_open(partition, filename);
     }

-- 
Andy Isaacson  http://web.mr-happy.com/~adisaacs/   Fight Spam, join CAUCE:
adi@acm.org adisaacs@mr-happy.com isaacson@cs.umn.edu   www.cauce.org
