Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Nov 2002 15:52:23 +0100 (MET)
Received: from webmail24.rediffmail.com ([IPv6:::ffff:203.199.83.146]:57985
	"HELO webmail24.rediffmail.com") by ralf.linux-mips.org with SMTP
	id <S868988AbSK0JIl>; Wed, 27 Nov 2002 10:08:41 +0100
Received: (qmail 27125 invoked by uid 510); 27 Nov 2002 09:11:14 -0000
Date: 27 Nov 2002 09:11:14 -0000
Message-ID: <20021127091114.27117.qmail@webmail24.rediffmail.com>
Received: from unknown (203.197.186.248) by rediffmail.com via HTTP; 27 nov 2002 09:11:14 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: a quick question regarding CONFIG_MIPS_UNCACHED..
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,

Is it sufficient to set "CONFIG_MIPS_UNCACHED" in order to track 
a
possible cache related problem otherwise hard to debug.
in so many places the functions to operate on caches are called
directly..don't they should be placed under
"#ifdef CONFIg_MIPS_UNCACHED" , if not technically then at least
for consistent coding.

secondly if once i have gone for UNCACHED operation then 
dump_tlb_all
should show the "page cheency attribute" for all entries as 
"UNCACHED" anywhere in whole address space..

in my case this attribute for some entries in TLB is still 
showing
"Cacheable, noncoherent, write-through, no write allocate" ..how 
this is possible..

following is the relevant code:--

#ifdef CONFIG_MIPS_UNCACHED
         change_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
#else
         change_cp0_config(CONF_CM_CMASK, 
CONF_CM_CACHABLE_NONCOHERENT);
#endif

Best Regards,
Atul
