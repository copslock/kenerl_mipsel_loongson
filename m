Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2003 15:33:04 +0100 (BST)
Received: from webmail35.rediffmail.com ([IPv6:::ffff:203.199.83.246]:30117
	"HELO rediffmail.com") by linux-mips.org with SMTP
	id <S8225196AbTEAOdA>; Thu, 1 May 2003 15:33:00 +0100
Received: (qmail 1495 invoked by uid 510); 1 May 2003 14:32:41 -0000
Date: 1 May 2003 14:32:41 -0000
Message-ID: <20030501143241.1494.qmail@webmail35.rediffmail.com>
Received: from unknown (210.210.48.141) by rediffmail.com via HTTP; 01 may 2003 14:32:41 -0000
MIME-Version: 1.0
From: "ashish  anand" <ashish_ibm@rediffmail.com>
Reply-To: "ashish  anand" <ashish_ibm@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: running purely uncached ..
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <ashish_ibm@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashish_ibm@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,

I am back to mips plateform after a long gap.
in my kernel source tree i observed in arch/mips/mm/r4xx0.c 
though
there are other support routines for flush , invalidate and 
maintain
the cache consistency ..but there is no mention of running purely 
uncached using the old style code CONFIG_MIPS_UNCACHED or 
otherwise.

Best Regards,
Ashish
