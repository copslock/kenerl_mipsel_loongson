Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0B2rPD05670
	for linux-mips-outgoing; Thu, 10 Jan 2002 18:53:25 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0B2rLg05667;
	Thu, 10 Jan 2002 18:53:21 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0B1qEB22905;
	Thu, 10 Jan 2002 17:52:14 -0800
Message-ID: <3C3E458A.B2AEC3CA@mvista.com>
Date: Thu, 10 Jan 2002 17:53:14 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: [PATCH] disable interrupt for non-LLSC atomic set
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


The current MIPS_ATOMIC set code for no-LLSC case does a load and store with
interrupt open.  This is potentially dangerous as an interrupt could happen
in-between and cause the value changed inside the interrupt handler. 
Therefore the load/store is not atomic anymore.

Does the following patch look good to fix that?

http://linux.junsun.net/patches/oss.sgi.com/submitted/020110.disable-intr-for-nollsc-atomic-set.patch

Jun
