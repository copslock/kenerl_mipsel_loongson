Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5JBB9Z15869
	for linux-mips-outgoing; Tue, 19 Jun 2001 04:11:09 -0700
Received: from intranet.medialincs.com ([210.126.9.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5JBB7V15866
	for <linux-mips@oss.sgi.com>; Tue, 19 Jun 2001 04:11:08 -0700
Received: (from root@localhost)
          by intranet.medialincs.com (2.5 Build 2630 (Berkeley 8.8.6)/8.8.4)
	  id UAA02823 for linux-mips@oss.sgi.com; Tue, 19 Jun 2001 20:15:16 +0900
Date: Tue, 19 Jun 2001 20:15:16 +0900
Message-Id: <200106191115.UAA02823@intranet.medialincs.com>
From: =?EUC-KR?B?wba+58iv?=<joey@medialincs.com>
To: linux-mips@oss.sgi.com
Cc: 
Subject: system freeze when __sti() called 
MIME-Version: 1.0
X-Mailer: IntraWorks Mailer 1.0
X-Deliver-Express: no
X-Deliver-Reply: no
X-Deliver-AutoReply: no
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by oss.sgi.com id f5JBB8V15867
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello,
I porting on gt-64120 with R-4700 ..

after linux booting, ERL bit in STATUS register is setted 
so I can't enable interrupt.

I  tried to clear ERL bit but then system was down. 

I use redboot as bootloader. 

have any idea?
