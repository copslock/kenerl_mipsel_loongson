Received:  by oss.sgi.com id <S42313AbQFUJYN>;
	Wed, 21 Jun 2000 02:24:13 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:35411 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42305AbQFUJXz>; Wed, 21 Jun 2000 02:23:55 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id CAA08701
	for <linux-mips@oss.sgi.com>; Wed, 21 Jun 2000 02:29:05 -0700 (PDT)
	mail_from (spock@mgnet.de)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA38258
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 21 Jun 2000 02:23:19 -0700 (PDT)
	mail_from (spock@mgnet.de)
Received: from obelix.hrz.tu-chemnitz.de (obelix.hrz.tu-chemnitz.de [134.109.132.55]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA01868
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jun 2000 02:23:18 -0700 (PDT)
	mail_from (spock@mgnet.de)
Received: from sunnyboy.informatik.tu-chemnitz.de by obelix.hrz.tu-chemnitz.de 
          with Local SMTP (PP); Wed, 21 Jun 2000 11:22:36 +0200
Received: from scotty.mgnet.de (sulu.csn.tu-chemnitz.de [134.109.96.105]) 
          by sunnyboy.informatik.tu-chemnitz.de (8.8.8/8.8.8) with SMTP 
          id LAA24789 for <linux@cthulhu.engr.sgi.com>;
          Wed, 21 Jun 2000 11:22:30 +0200 (MET DST)
Received: (qmail 31603 invoked from network); 21 Jun 2000 09:22:29 -0000
Received: from spock.mgnet.de (HELO scotty.mgnet.de) (192.168.1.4) 
          by scotty.mgnet.de with SMTP; 21 Jun 2000 09:22:29 -0000
Date:   Wed, 21 Jun 2000 11:23:43 +0200
From:   Klaus Naumann <spock@mgnet.de>
To:     Linux Debian MIPS <debian-mips@lists.debian.org>,
        Linux MIPS cthulhu <linux@cthulhu.engr.sgi.com>,
        Linux MIPS <linux-mips@fnet.fr>,
        MIPS vger <linux-mips@vger.rutgers.edu>
Subject: Problems with multiple harddisks on my Indigo2
Message-ID: <20000621112343.A19912@spock>
Reply-To: spock@mgnet.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 0.8.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi all

While trying to build a 2nd harddisk into my Indigo2
I experienced the following problems.
The bus is terminated correctly and with 2 m external
cable to my scsi case it also shouldn't be to long.
When I try to copy data from a harddisk to the other
I get weired I/O erros after some time of heavy I/O.
On the console I get something like:
cp: /mnt/redhat/kernel23/linux/arch/sparc/lib/COPYING.LIB: Input/output error

And dmesg shows:
attempt to access beyond end of device
08:03: rw=0, want=959546428, limit=1888830
attempt to access beyond end of device
08:03: rw=0, want=958585434, limit=1888830
attempt to access beyond end of device
08:03: rw=0, want=959546428, limit=1888830
attempt to access beyond end of device
08:03: rw=0, want=958585434, limit=1888830
attempt to access beyond end of device
08:03: rw=0, want=941858675, limit=1888830


Ususally the system is pretty unstable after these messages.

Also I'm getting a message
sc1,2,0: cmd=0x12 timeout after 2 sec.  Resetting SCSI bus
every time I restart my Indigo2 on the serial console -
does anyone know what that means and if it's a problem ?

Further more it happens that after heavy I/O a simple "sync"
needs more than one minute.

Has anyone seen the same or equal problems in any way
and/ was able to resolve these ?

	TIA, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
