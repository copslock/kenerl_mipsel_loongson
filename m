Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Nov 2002 15:59:09 +0100 (MET)
Received: from webmail36.rediffmail.com ([IPv6:::ffff:203.199.83.248]:25220
	"HELO webmail36.rediffmail.com") by ralf.linux-mips.org with SMTP
	id <S868147AbSKZK6S>; Tue, 26 Nov 2002 11:58:18 +0100
Received: (qmail 16314 invoked by uid 510); 26 Nov 2002 11:02:45 -0000
Date: 26 Nov 2002 11:02:45 -0000
Message-ID: <20021126110245.16313.qmail@webmail36.rediffmail.com>
Received: from unknown (203.200.7.44) by rediffmail.com via HTTP; 26 nov 2002 11:02:45 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: quick question regarding CONFIG_MIPS_UNCACHED..
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,

In order to confirm a cache related problem , Is just setting
CONFIG_MIPS_UNCACHED is suficient..as so many places function
to operate on caches are  called directly while they should be
under "#ifdef CONFIG_MIPS_UNCACHED " if not technically then
atleast to make coding consistent.

secondly i am setting the uncached feature by,
change_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);

now, should the dump_tlb() show the page coherency attribute for 
each entries as "UNCACHED" in whole 4 gb address space..in my case 
for some entries the page coherency attribute is still showing 
"Cacheable, noncoherent, write-through, no write allocate".

Best Regards,
Atul
