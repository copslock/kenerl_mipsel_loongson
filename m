Received:  by oss.sgi.com id <S553778AbRBHLYc>;
	Thu, 8 Feb 2001 03:24:32 -0800
Received: from mail.sonytel.be ([193.74.243.200]:12705 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553775AbRBHLYV>;
	Thu, 8 Feb 2001 03:24:21 -0800
Received: from ginger.sonytel.be (ginger.sonytel.be [10.34.16.6])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id MAA08295
	for <linux-mips@oss.sgi.com>; Thu, 8 Feb 2001 12:24:18 +0100 (MET)
Received: (from tea@localhost)
	by ginger.sonytel.be (8.9.0/8.8.6) id MAA08717
	for linux-mips@oss.sgi.com; Thu, 8 Feb 2001 12:24:18 +0100 (MET)
Date:   Thu, 8 Feb 2001 12:24:18 +0100
From:   Tom Appermont <tea@sonycom.com>
To:     linux-mips@oss.sgi.com
Subject: booting from NFS
Message-ID: <20010208122418.D8548@ginger.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,

I'm having a problem booting from a mipsel base file system over
NFS. The kernel version is 2.4.1, on a ddb5074 development board.
There is probably nothing wrong with the base file system itself 
(got it from bolug.uni-bonn.de and it works fine for an older 
2.4.0-test1-ac21 kernel). The nfsd log shows that the mount 
succeeds, but blocks when the board tries to get ld-2.0.6.so. The 
output of the nfsd is attached below. Any help is greatly 
appreciated.


Greetz,

Tom


--
Feb  8 12:18:38 crane bootpd[576]: recvd pkt from IP addr 0.0.0.0
Feb  8 12:18:38 crane bootpd[576]: bootptab mtime: Wed Feb  7 16:02:03 2001
Feb  8 12:18:38 crane bootpd[576]: request from Ethernet address 00:20:18:39:26:E9
Feb  8 12:18:38 crane bootpd[576]: found 192.168.18.70 (linux-ddb)
Feb  8 12:18:38 crane bootpd[576]: bootfile="/usr/boot/mipsel"
Feb  8 12:18:38 crane bootpd[576]: vendor magic field is 99.130.83.99
Feb  8 12:18:38 crane bootpd[576]: request message length=364
Feb  8 12:18:38 crane bootpd[576]: extended reply, length=364, options=128
Feb  8 12:18:38 crane bootpd[576]: sending reply (with RFC1048 options)
Feb  8 12:18:38 crane bootpd[576]: setarp 192.168.18.70 - 00:20:18:39:26:E9
Feb  8 12:18:38 crane mountd[214]: NFS mount of /usr/boot/mipsel attempted from 192.168.18.70
Feb  8 12:18:38 crane mountd[214]: /usr/boot/mipsel has been mounted by 192.168.18.70
Feb  8 12:18:38 crane nfsd[212]: getattr [1 70/1/1 01:00:00 192.168.18.70 0.0]
Feb  8 12:18:38 crane nfsd[212]:        /usr/boot/mipsel
Feb  8 12:18:38 crane nfsd[212]: result: 0
Feb  8 12:18:38 crane nfsd[212]: statfs [1 70/1/1 01:00:00 192.168.18.70 0.0]
Feb  8 12:18:38 crane nfsd[212]:        /usr/boot/mipsel
Feb  8 12:18:38 crane nfsd[212]: result: 0
Feb  8 12:18:38 crane nfsd[212]: lookup [1 70/1/1 01:00:00 192.168.18.70 0.0]
Feb  8 12:18:38 crane nfsd[212]:        fh:/usr/boot/mipsel n:dev
Feb  8 12:18:38 crane nfsd[212]:        new_fh = /usr/boot/mipsel/dev
Feb  8 12:18:38 crane nfsd[212]: result: 0
Feb  8 12:18:38 crane nfsd[212]: lookup [1 70/1/1 01:00:00 192.168.18.70 0.0]
Feb  8 12:18:38 crane nfsd[212]:        fh:/usr/boot/mipsel/dev n:console
Feb  8 12:18:38 crane nfsd[212]:        new_fh = /usr/boot/mipsel/dev/console
Feb  8 12:18:38 crane nfsd[212]: result: 0
Feb  8 12:18:38 crane nfsd[212]: lookup [1 70/1/1 01:00:00 192.168.18.70 0.0]
Feb  8 12:18:38 crane nfsd[212]:        fh:/usr/boot/mipsel n:sbin
Feb  8 12:18:38 crane nfsd[212]:        new_fh = /usr/boot/mipsel/sbin
Feb  8 12:18:38 crane nfsd[212]: result: 0
Feb  8 12:18:38 crane nfsd[212]: lookup [1 70/1/1 01:00:00 192.168.18.70 0.0]
Feb  8 12:18:38 crane nfsd[212]:        fh:/usr/boot/mipsel/sbin n:init
Feb  8 12:18:38 crane nfsd[212]:        new_fh = /usr/boot/mipsel/sbin/init
Feb  8 12:18:38 crane nfsd[212]: result: 0
Feb  8 12:18:38 crane nfsd[212]: read [1 70/1/1 01:00:00 192.168.18.70 0.0]
Feb  8 12:18:38 crane nfsd[212]:        /usr/boot/mipsel/sbin/init: 4096 bytes at 0
Feb  8 12:18:38 crane nfsd[212]: result: 0
Feb  8 12:18:38 crane nfsd[212]: lookup [1 70/1/1 01:00:00 192.168.18.70 0.0]
Feb  8 12:18:38 crane nfsd[212]:        fh:/usr/boot/mipsel n:lib
Feb  8 12:18:38 crane nfsd[212]:        new_fh = /usr/boot/mipsel/lib
Feb  8 12:18:38 crane nfsd[212]: result: 0
Feb  8 12:18:38 crane nfsd[212]: lookup [1 70/1/1 01:00:00 192.168.18.70 0.0]
Feb  8 12:18:38 crane nfsd[212]:        fh:/usr/boot/mipsel/lib n:ld.so.1
Feb  8 12:18:38 crane nfsd[212]:        new_fh = /usr/boot/mipsel/lib/ld.so.1
Feb  8 12:18:38 crane nfsd[212]: result: 0
Feb  8 12:18:38 crane nfsd[212]: readlink [1 70/1/1 01:00:00 192.168.18.70 0.0]
Feb  8 12:18:38 crane nfsd[212]:        /usr/boot/mipsel/lib/ld.so.1
Feb  8 12:18:38 crane nfsd[212]:  ld-2.0.6.so
Feb  8 12:18:38 crane nfsd[212]: result: 0
Feb  8 12:18:38 crane nfsd[212]: lookup [1 70/1/1 01:00:00 192.168.18.70 0.0]
Feb  8 12:18:38 crane nfsd[212]:        fh:/usr/boot/mipsel/lib n:ld-2.0.6.so
Feb  8 12:18:38 crane nfsd[212]:        new_fh = /usr/boot/mipsel/lib/ld-2.0.6.so
Feb  8 12:18:38 crane nfsd[212]: result: 0
Feb  8 12:18:38 crane nfsd[212]: read [1 70/1/1 01:00:00 192.168.18.70 0.0]
Feb  8 12:18:38 crane nfsd[212]:        /usr/boot/mipsel/lib/ld-2.0.6.so: 4096 bytes at 0
Feb  8 12:18:38 crane nfsd[212]: result: 0
