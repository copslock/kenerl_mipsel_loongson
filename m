Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2002 05:03:08 +0200 (CEST)
Received: from eth0.lnk.aims.com.au ([203.31.73.253]:23560 "EHLO
	postoffice.aims.com.au") by linux-mips.org with ESMTP
	id <S1123891AbSJQDDH>; Thu, 17 Oct 2002 05:03:07 +0200
Received: from postoffice.aims.com.au (nts-ts1.aims.private [192.168.10.2])
	by postoffice.aims.com.au  with ESMTP id g9H32luP068456
	for <linux-mips@linux-mips.org>; Thu, 17 Oct 2002 14:02:48 +1100 (EST)
	(envelope-from nigel@aims.com.au)
Received: from ntsts1 by aims.com.au
	with SMTP (MDaemon.v3.5.3.R)
	for <linux-mips@linux-mips.org>; Thu, 17 Oct 2002 13:49:05 +1100
Reply-To: <nigel@aims.com.au>
From: "Nigel Weeks" <nigel@aims.com.au>
To: "Linux-Mips \(E-mail\)" <linux-mips@linux-mips.org>
Subject: RE: break_cow and cache flushing
Date: Thu, 17 Oct 2002 13:49:03 +1100
Message-ID: <000901c27587$c1988c30$020aa8c0@aims.private>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
In-Reply-To: <3DADFC0B.81C8C058@broadcom.com>
X-Return-Path: nigel@aims.com.au
X-MDaemon-Deliver-To: linux-mips@linux-mips.org
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
Return-Path: <nigel@aims.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@aims.com.au
Precedence: bulk
X-list: linux-mips

MOO!, Don't hurt me, MOOOO!!!!

(cow collapses against the fence, twitching and subsiding into silience, as
the farmer loads the offcut onto the carry-all)



sorry, just had to...


-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Kip Walker
Sent: Thursday, 17 October 2002 10:54
To: linux-mips@linux-mips.org
Subject: break_cow and cache flushing



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
