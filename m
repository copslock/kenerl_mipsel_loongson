Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0988tv20664
	for linux-mips-outgoing; Wed, 9 Jan 2002 00:08:55 -0800
Received: from crack-ext.ab.videon.ca (crack-ext.ab.videon.ca [206.75.216.33])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0988pg20661
	for <linux-mips@oss.sgi.com>; Wed, 9 Jan 2002 00:08:51 -0800
Received: (qmail 16931 invoked from network); 9 Jan 2002 07:08:48 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.82.81.190]) (envelope-sender <jgg@debian.org>)
          by crack-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <linux-mips@oss.sgi.com>; 9 Jan 2002 07:08:48 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16OCqt-0003qe-00
	for <linux-mips@oss.sgi.com>; Wed, 09 Jan 2002 00:08:47 -0700
Date: Wed, 9 Jan 2002 00:08:47 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
To: linux-mips@oss.sgi.com
Subject: Q about ST0_UX
Message-ID: <Pine.LNX.3.96.1020109000346.9606F-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi All,

I just noticed that in setup.c there is this little bit:

        s = read_32bit_cp0_register(CP0_STATUS);
        s &= ~(ST0_CU1|ST0_CU2|ST0_CU3|ST0_KX|ST0_SX|ST0_FR);
        s |= ST0_CU0;
        write_32bit_cp0_register(CP0_STATUS, s);

And it doesn't mask off ST0_UX - is this an oversight? With my RM7K the
kernel is called with ST0_UX set, and since it doesn't clear it the XTLB
handler is called - which faults things..

So, would this patch be appropriate in general:

--- setup.c     2001/12/02 11:34:38     1.96
+++ setup.c     2002/01/09 08:05:43
@@ -558,7 +558,7 @@
 
        /* Disable coprocessors and set FPU for 16 FPRs */
        s = read_32bit_cp0_register(CP0_STATUS);
-       s &= ~(ST0_CU1|ST0_CU2|ST0_CU3|ST0_KX|ST0_SX|ST0_FR);
+       s &= ~(ST0_CU1|ST0_CU2|ST0_CU3|ST0_UX|ST0_KX|ST0_SX|ST0_FR);
        s |= ST0_CU0;
        write_32bit_cp0_register(CP0_STATUS, s);

or is it better to make the xtlb handler work in the 32 bit case?

Thanks,
Jason
