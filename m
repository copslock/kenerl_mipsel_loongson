Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g477QnwJ003640
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 00:26:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g477QnUo003639
	for linux-mips-outgoing; Tue, 7 May 2002 00:26:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dtla2.teknuts.com (adsl-66-125-62-110.dsl.lsan03.pacbell.net [66.125.62.110])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g477QfwJ003636
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 00:26:44 -0700
Received: from sohotower ([208.187.134.77])
	(authenticated)
	by dtla2.teknuts.com (8.11.3/8.10.1) with ESMTP id g477S0E06807
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 00:28:00 -0700
From: "Robert Rusek" <robru@teknuts.com>
To: <linux-mips@oss.sgi.com>
Subject: kernel: EXT2-fs error ?
Date: Tue, 7 May 2002 00:29:27 -0700
Message-ID: <000001c1f598$efc65070$0a01a8c0@sohotower>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am running Kernel 2.4.17 on an SGI Indy.  I recently noticed that I
have been getting the following error sparatically.  What does this
mean?  The system boots up cleanly and then the fs gets corrupted
somehow.  Any help would be greatly appreciated.


May  6 04:02:17 catbert kernel: EXT2-fs error (device sd(8,1)):
ext2_check_page: bad entry in directory #110032: unaligned di
rectory entry - offset=0, inode=6226015, rec_len=95, name_len=95
May  6 04:02:17 catbert kernel: EXT2-fs error (device sd(8,1)):
ext2_check_page: bad entry in directory #110056: rec_len is s
maller than minimal - offset=0, inode=2551, rec_len=0, name_len=8
May  6 04:02:17 catbert kernel: EXT2-fs error (device sd(8,1)):
ext2_check_page: bad entry in directory #110071: rec_len is s
maller than minimal - offset=0, inode=0, rec_len=0, name_len=0
May  6 04:02:17 catbert kernel: EXT2-fs error (device sd(8,1)):
ext2_check_page: bad entry in directory #110081: rec_len is s
maller than minimal - offset=0, inode=547544874, rec_len=0, name_len=0


Thank you in advance,
Rob.
