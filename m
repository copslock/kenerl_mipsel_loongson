Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA71215 for <linux-archive@neteng.engr.sgi.com>; Sat, 8 May 1999 13:34:05 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA55609
	for linux-list;
	Sat, 8 May 1999 13:31:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA94770
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 8 May 1999 13:31:08 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup154-1-10.swipnet.se [130.244.154.10]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA02908
	for <linux@cthulhu.engr.sgi.com>; Sat, 8 May 1999 16:31:06 -0400 (EDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10gF0K-003LodC; Sat, 8 May 1999 23:51:28 +0200 (CEST)
Date: Sat, 8 May 1999 23:51:28 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: Charles Lepple <clepple@foo.tho.org>
Cc: Linux/SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: am-utils and NIS
Message-ID: <19990508235127.A643@thepuffingroup.com>
Mail-Followup-To: Charles Lepple <clepple@foo.tho.org>,
	Linux/SGI <linux@cthulhu.engr.sgi.com>
References: <371FE405.2F817623@foo.tho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <371FE405.2F817623@foo.tho.org>; from Charles Lepple on Fri, Apr 23, 1999 at 03:07:49AM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> gcc -shared -Wl,-soname -Wl,libamu.so.1 -o .libs/libamu.so.1.0.1
> misc_rpc.lo mount_fs.lo mtab.lo nfs_prot_xdr.lo util.lo wire.lo
> xdr_func.lo xutil.lo transputil.lo mtabutil.lo mountutil.lo umount_fs.lo
> collect2: ld terminated with signal 6 [Aborted]
> make[2]: *** [libamu.la] Error 1
> make[2]: Leaving directory
> `/usr/src/redhat/BUILD/am-utils-6.0a16/libamu'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/usr/src/redhat/BUILD/am-utils-6.0a16'
> make: *** [all-recursive-am] Error 2

I don't know if you've solved this problem, but I bet you're using binutils
2.9.1, install the old 2.8.1 and everything will (probably) work just fine.

I'm trying to get back to the cutting edge of my mailbox today :-)

- Ulf
