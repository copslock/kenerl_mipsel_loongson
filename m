Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2GKwOe14826
	for linux-mips-outgoing; Fri, 16 Mar 2001 12:58:24 -0800
Received: from pobox.sibyte.com (pobox.sibyte.com [208.12.96.20])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2GKwOM14823
	for <linux-mips@oss.sgi.com>; Fri, 16 Mar 2001 12:58:24 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP id 0B5B7205FD
	for <linux-mips@oss.sgi.com>; Fri, 16 Mar 2001 12:58:18 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Fri, 16 Mar 2001 12:51:24 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP id 597831595F
	for <linux-mips@oss.sgi.com>; Fri, 16 Mar 2001 12:58:18 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 14731686D; Fri, 16 Mar 2001 13:00:51 -0800 (PST)
From: Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To: linux-mips@oss.sgi.com
Subject: mips64 pgd_current
Date: Fri, 16 Mar 2001 12:55:18 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <01031613005000.00780@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Doing some more code trolling here; am looking at the MP 
parts of the TLB refill code in the mips64 tree, and I'm a bit
confused.

It looks to me like pgd_current[] is indexed by CP0_CONTEXT
and the resulting pointer is supposed to be the base of the
page tables for that particular process.  This makes sense.

However, I see this in mmu_context.h:

#define TLBMISS_HANDLER_SETUP_PGD(pgd) \
	pgd_current[smp_processor_id()] = (unsigned long)(pgd)
#define TLBMISS_HANDLER_SETUP() \
	set_context((unsigned long) smp_processor_id() << (23 + 3)); \
	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
extern unsigned long pgd_current[];

so pgd_current[smp_processor_id()] is hard coded to be set to
swapper_pg_dir, which, insofar as I can tell, is not a per-cpu structure.  

It looks to me like this will end up with pgd_current[] being an
array of NR_CPUS pointers all of which point to the same pgd table.  

I know I must be misunderstanding this code.  Any suggestions as to what I'm
missing?

Thanks,
  Justin
