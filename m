Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAREn4K18360
	for linux-mips-outgoing; Tue, 27 Nov 2001 06:49:04 -0800
Received: from oval.algor.co.uk (oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAREmno18354
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 06:48:52 -0800
Received: from algor.co.uk (angel.algor.co.uk [62.254.210.234])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id fARDmSZ23744;
	Tue, 27 Nov 2001 13:48:28 GMT
Message-ID: <3C0399AC.9C5D412C@algor.co.uk>
Date: Tue, 27 Nov 2001 13:48:28 +0000
From: Chris Dearman <chris@algor.co.uk>
Organization: Algorithmics Ltd
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: MIPS performance counters
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,
  A few days ago someone (sorry, I deleted the mail...) was asking about
support for MIPS performance counters.  Some time ago I ported Mikael
Pettersson's perfctr (http://www.csd.uu.se/~mikpe/linux/perfctr)
driver to 2.2.12 and used that to profile programs running on an
RM7000.  This driver has a reasonably generic interface and supports per
process profiling.
 Unless anyone can suggest a better starting point I'll have a look at
putting this into 2.4.14.

	Regards
		Chris
 
-- 
Algorithmics,The Fruit Farm,Ely Road,Chittering,CAMBS CB5 9PH,ENGLAND
P: +44 1223 706200    F: +44 1223 706250    W: http://www.algor.co.uk
