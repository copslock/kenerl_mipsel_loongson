Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Nov 2002 15:57:33 +0100 (MET)
Received: from webmail33.rediffmail.com ([IPv6:::ffff:203.199.83.245]:30125
	"HELO mailweb33.rediffmail.com") by ralf.linux-mips.org with SMTP
	id <S868827AbSKZMcw>; Tue, 26 Nov 2002 13:32:52 +0100
Received: (qmail 4511 invoked by uid 510); 26 Nov 2002 12:37:50 -0000
Date: 26 Nov 2002 12:37:50 -0000
Message-ID: <20021126123750.4510.qmail@mailweb33.rediffmail.com>
Received: from unknown (203.200.7.44) by rediffmail.com via HTTP; 26 nov 2002 12:37:50 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: quick question for CONFIG_MIPS_UNCACHED...
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,
In order to confirm a cache problem is it sufficient to set
"CONFIG_MIPS_UNCACHED" , as in so many places functions to
operate on cache are called directly while they should under
"#ifdef CONFIg_MIPS_UNCACHED" if not technically then atleast
for consistent coding practice.

I am setting uncached opertion by,
change_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
now should the dump_tlb_all() show the "page coherency 
atributes"
for all entries "UNCACHED" anywhere in 4GB space..is it true ?
why in my case for some entries it is still showing "Cacheable, 
noncoherent, write-through, no write allocate" ?

Best Regards,
Atul
