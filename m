Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2002 01:54:06 +0200 (CEST)
Received: from mms2.broadcom.com ([63.70.210.59]:5 "EHLO mms2")
	by linux-mips.org with ESMTP id <S1123891AbSJPXyG>;
	Thu, 17 Oct 2002 01:54:06 +0200
Received: from 63.70.210.1 by mms2 with ESMTP (Broadcom MMS2 SMTP Relay
 (MMS v5.0)); Wed, 16 Oct 2002 16:51:27 -0700
X-Server-Uuid: 59F48136-7074-4F4B-B709-D7F3B6466DB0
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id QAA22273 for <linux-mips@linux-mips.org>; Wed, 16 Oct 2002 16:53:48
 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 g9GNrlER004016 for <linux-mips@linux-mips.org>; Wed, 16 Oct 2002 16:53:
 47 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id QAA14850 for
 <linux-mips@linux-mips.org>; Wed, 16 Oct 2002 16:53:47 -0700
Message-ID: <3DADFC0B.81C8C058@broadcom.com>
Date: Wed, 16 Oct 2002 16:53:47 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: break_cow and cache flushing
X-WSS-ID: 11B324F5126344-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips


Can anyone comment on the following observations:

1) 'flush_cache_page' seems to be intended for flushing virtually
indexed dcaches when a virtual->physical mapping changes (based on
PAddr)
2) 'flush_page_to_ram' is also related to avoiding virtual aliasing in
the dcache (based on VAddr)
3) 'flush_icache_page' seems to be intended for making the icache
coherent with the dcache after an executable page has been filled
4) 'break_cow' may copy an executable page that is marked executable,
for example a stack page (which has VM_EXEC) and might contain a live
signal trampoline

On a CPU with writeback physically indexed/tagged dcache and virtually
indexed icache that isn't coherent with the dcache, (1) and (2) are NOPs
and (3) must writeback the dcache and flush the icache.

BUT either my understanding of (1) or (2) is wrong, or 'break_cow' needs
to do a 'flush_icache_page' when the page is executable.  Consider the
following (evil) case.

A process takes a signal, and calls 'fork' from the handler.  The signal
trampoline is sitting in the stack, and both processes end up with the
stack page COW.  The parent ends up breaking the COW and so it gets the
new copy of the page, but if the caches aren't flushed, it may execute
garbage from the old contents of the new stack page.

Whew.

I've verified that doing a 'flush_icache_page' in 'break_cow' whenever
an executable page is copied (which shouldn't be too often, I'd guess)
and leaving 'flush_cache_page' and 'flush_page_to_ram' as NOPs seems
stable (and fixes the previously crashing case described above).

Kip
