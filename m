Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4LC4AB07513
	for linux-mips-outgoing; Mon, 21 May 2001 05:04:10 -0700
Received: from intranet.medialincs.com ([210.126.9.6])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4LC48F07506
	for <linux-mips@oss.sgi.com>; Mon, 21 May 2001 05:04:09 -0700
Received: (from root@localhost)
          by intranet.medialincs.com (2.5 Build 2630 (Berkeley 8.8.6)/8.8.4)
	  id VAA12651 for linux-mips@oss.sgi.com; Mon, 21 May 2001 21:07:29 +0900
Date: Mon, 21 May 2001 21:07:29 +0900
Message-Id: <200105211207.VAA12651@intranet.medialincs.com>
From: =?EUC-KR?B?wba+58iv?=<joey@medialincs.com>
To: linux-mips@oss.sgi.com
Cc: 
Subject: udp, tcp checksum error?
MIME-Version: 1.0
X-Mailer: IntraWorks Mailer 1.0
X-Deliver-Express: no
X-Deliver-Reply: no
X-Deliver-AutoReply: no
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by oss.sgi.com id f4LC49F07507
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello.
I'm booting up by nfs-root.

nfs server is RH-7.0 and kernel 2.4.4 , this machine's nfs is good working

but when target mips machine connect to host by UDP, 
wrong checksum UDP packet  is discarded.

i use mips big endian toolchains(20010303), kernel sorce is CVS update version.

I thinks include/asm-mips/checksum.h logic is different from i386's

anyone have idea this problem?

thanx.
