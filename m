Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HMtPv01361
	for linux-mips-outgoing; Thu, 17 Jan 2002 14:55:25 -0800
Received: from hermes.mvista.com ([12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HMtNP01355
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 14:55:23 -0800
Received: from mvista.com (IDENT:ahennessy@penelope.mvista.com [10.0.0.122])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0HLrxB18791
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 13:53:59 -0800
Message-ID: <3C474909.4DF82E72@mvista.com>
Date: Thu, 17 Jan 2002 13:58:33 -0800
From: Alice Hennessy <ahennessy@mvista.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: malta 4kc and tlb-r4k.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I needed to add a BARRIER between :

set_entryhi(KSEG0+idx*0x2000);  and
 tlb_write_indexed();

in  local_flush_tlb_range()  (tlb-r4k.c), otherwise I get a bootup
failure:

Kernel panic: Caught Machine Check exception - probably caused by
multiple matching entries in the TLB.

Malta 5kc didn't have this problem.

Also,  the call
set_entryhi(KSEG0);
doesn't seem necessary.


Alice
