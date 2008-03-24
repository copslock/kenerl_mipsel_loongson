Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2008 14:00:41 +0000 (GMT)
Received: from web38802.mail.mud.yahoo.com ([209.191.125.93]:17010 "HELO
	web38802.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20027156AbYCXOAj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Mar 2008 14:00:39 +0000
Received: (qmail 82702 invoked by uid 60001); 24 Mar 2008 14:00:16 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Et/Zpi+bUeZaxs8HG/OOzgkv+DrVVDWhb7pJL2X0Rcum4XOw4wQ3axG6/KwrXUixGKdJb2TaL2bNfoSSRtK1FKpsDBCmCWc3phlAC6L3amIQd4YQTt2jH0S/8KuplJ+6cUmWUL3G14SOaVL2v/8VOw0zEi8C5AYqmX1ewJ/f5/Y=;
X-YMail-OSG: V_Z0prMVM1l1d8NSGbuwhuBXKoIj61lrMeC0WGlodmqgzK2BOwcUwKhAC4_o.Lg6pIk_zSBcPtP20HWlnqrHxltU7UCQ6vbY3lrjH7ZHlbfJCCIKQEM-
Received: from [68.236.82.170] by web38802.mail.mud.yahoo.com via HTTP; Mon, 24 Mar 2008 07:00:15 PDT
Date:	Mon, 24 Mar 2008 07:00:15 -0700 (PDT)
From:	Larry Stefani <lstefani@yahoo.com>
Subject: SB1250 locking up in init on current 2.6.16 kernel
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <15031.81072.qm@web38802.mail.mud.yahoo.com>
Return-Path: <lstefani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lstefani@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

I've been trying to upgrade from 2.6.16.18 to
2.6.16.60, but am seeing a hard lockup right before
"INIT: version 2.78 booting" on my SB1250-based board.

I found a related discussion on the Debian mailing
list:

http://groups.google.com/group/linux.debian.bugs.dist/browse_thread/thread/b7159ee25106c7f9

However, after applying Thiemo's patch to mark pages
tainted by PIO IDE as dirty, the lockup still occurs.

I narrowed the file changes to

     arch/mips/mm/c-sb1.c
     arch/mips/mm/cache.c
     arch/mips/mm/init.c
     include/asm-mips/cache-flush.h
     include/asm-mips/page.h

between 2.6.16.27 and 2.6.16.29.  There was no
2.6.16.28 tarball posted on linux-mips.org, so I
basically brought .27 to .29 until I found the
offending files.

Is anyone running a 2.6.16 kernel (after 2.6.16.27) on
a SB1250-based board?

Thanks,
Larry Stefani
lstefani@yahoo.com


      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ
