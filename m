Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TGnWnC023626
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 09:49:32 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TGnWCf023625
	for linux-mips-outgoing; Wed, 29 May 2002 09:49:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TGnQnC023622
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 09:49:26 -0700
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Wed, 29 May 2002 09:50:26 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from ldt-sj3-022.sj.broadcom.com (ldt-sj3-022 [10.21.64.22])
 by mail-sj1-5.sj.broadcom.com (8.12.2/8.12.2) with ESMTP id
 g4TGor1S029298 for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 09:50:53
 -0700 (PDT)
Received: (from carlson@localhost) by ldt-sj3-022.sj.broadcom.com (
 8.11.6/8.9.3) id g4TGorn07849; Wed, 29 May 2002 09:50:53 -0700
X-Authentication-Warning: ldt-sj3-022.sj.broadcom.com: carlson set
 sender to justinca@cs.cmu.edu using -f
Subject: __flush_cache_all() miscellany
From: "Justin Carlson" <justinca@cs.cmu.edu>
To: linux-mips@oss.sgi.com
X-Mailer: Ximian Evolution 1.0.5
Date: 29 May 2002 09:50:52 -0700
Message-ID: <1022691053.7644.16.camel@ldt-sj3-022.sj.broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 10EBD958841367-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Looking at the cache routines, I've noticed that there's been a
relatively recent introduction of a __flush_cache_all() routine. 
Looking at oss.sgi.com's cvs logs, I see this comment:

>Introduce __flush_cache_all() which flushes the cache no matter if
>this operation is necessary from the mm point of view or not.

Some questions:

Which caches does this apply to?  It looks like the current
implementations assume L1 only.

Would anyone have a problem with renaming this function?  To me, at
least, it's rather confusing to have all of:

flush_cache_all()
_flush_cache_all()
__flush_cache_all()
___flush_cache_all()

defined, especially when the latter two mean something significantly
different from the former two.  I'd prefer calling the new one
{_}force_flush_l1_caches() or somesuch.

In a related note, one of the few places this routine is called is the
kgdb stub routines (in arch/mips/kernel/gdb-stub.c):

void set_async_breakpoint(unsigned int epc)
{
	int cpu = smp_processor_id();

	async_bp[cpu].addr = epc;
	async_bp[cpu].val  = *(unsigned *)epc;
	*(unsigned *)epc = BP;
	__flush_cache_all();
}

Shouldn't that be a flush_icache_range() call anyways?

Thanks,
  Justin
