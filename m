Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id EAA09646
	for <pstadt@stud.fh-heilbronn.de>; Thu, 29 Jul 1999 04:39:35 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA09460; Wed, 28 Jul 1999 19:36:13 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA91353
	for linux-list;
	Wed, 28 Jul 1999 19:29:25 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA15444
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 28 Jul 1999 19:29:23 -0700 (PDT)
	mail_from (thockin@cobaltnet.com)
Received: from mail.cobaltnet.com (firewall.cobaltmicro.com [209.133.34.37] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA03635
	for <linux@cthulhu.engr.sgi.com>; Wed, 28 Jul 1999 19:29:16 -0700 (PDT)
	mail_from (thockin@cobaltnet.com)
Received: from cobaltnet.com (freakshow.cobaltnet.com [10.9.24.15])
	by mail.cobaltnet.com (8.9.3/8.9.3) with ESMTP id SAA30133
	for <linux@cthulhu.engr.sgi.com>; Wed, 28 Jul 1999 18:17:00 -0700
Message-ID: <379FBBFE.FB8C1734@cobaltnet.com>
Date: Wed, 28 Jul 1999 19:27:10 -0700
From: Tim Hockin <thockin@cobaltnet.com>
Organization: Cobalt Networks
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: an ld problem?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

I'm trying to compile egcs-1.0.2-9 on a Cobalt (mipsel) box.  During the
libstdc++ build I we have the following:


compile string:
/home/src/redhat/BUILD/egcs-1.0.2/obj-mipsel-linux/gcc/xgcc
-B/home/src/redhat/BUILD/egcs-1.0.2/obj-mipsel-linux/gcc/ -O2
-fno-implicit-templates -Wl,-soname,libstdc++.so.2.8 -shared -o
libstdc++.so.2.8.0 `cat piclist` -lm

result:
collect2: ld terminated with signal 6 [Aborted], core dumped

I have traced it through ld to this point: (elf32-mips.c : line 1526)

                          asection *osec;

                          osec = sec->output_section;
                          indx = elf_section_data (osec)->dynindx;
                          if (indx == 0)
                            abort ();

where it aborts.  I am a bit bewildered.  Anyone have any ideas to
offer?  Help?

Tim
