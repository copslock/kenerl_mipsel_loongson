Received:  by oss.sgi.com id <S305156AbPKYI6u>;
	Thu, 25 Nov 1999 00:58:50 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:32608 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305154AbPKYI60>;
	Thu, 25 Nov 1999 00:58:26 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA05868
	for <linuxmips@oss.sgi.com>; Thu, 25 Nov 1999 01:04:46 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA07068
	for linux-list;
	Wed, 24 Nov 1999 11:15:57 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA98409
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 Nov 1999 11:15:54 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from tower.ti.com (tower.ti.com [192.94.94.5]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA08952
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 Nov 1999 11:15:15 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from dlep4.itg.ti.com ([157.170.188.63])
	by tower.ti.com (8.9.3/8.9.3) with ESMTP id NAA04975;
	Wed, 24 Nov 1999 13:14:26 -0600 (CST)
Received: from jharrell_dt (IDENT:jharrell@ppp-isbas99-180.itg.ti.com [192.168.134.180])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with SMTP id NAA01564;
	Wed, 24 Nov 1999 13:14:09 -0600 (CST)
From:   Jeff Harrell <jharrell@ti.com>
Organization: Texas Instruments
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: kgdb support
Date:   Wed, 24 Nov 1999 12:00:56 -0700
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
Cc:     bbrown@ti.com, mhassler@ti.com, vwells@ti.com, kmcdonald@ti.com
MIME-Version: 1.0
Message-Id: <99112412134700.03259@jharrell_dt>
Content-Transfer-Encoding: 8bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

In the process of looking through the MIPS/Linux code base,  I noticed that the
kgdb interface seems to support the ZS85C30  (see the function rs_kgdb_hook) 
but do not see where the generic serial interface (i.e. /drivers/char/serial.c)
is supported.  Is the kgdb support provided through the file gdb-stub.c? Any
help would be greatly appreciated.

Thanks,
Jeff Harrell

 -- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell			Work:  (801) 984-0183
Broadband Access group/TI	
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
