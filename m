Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2003 07:57:35 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:65040 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8224861AbTDHG5c>;
	Tue, 8 Apr 2003 07:57:32 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP id EC793B56A
	for <linux-mips@linux-mips.org>; Tue,  8 Apr 2003 08:57:28 +0200 (CEST)
Message-ID: <3E9274F0.227008F7@ekner.info>
Date: Tue, 08 Apr 2003 09:06:24 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Aliasing in pgtable-bits.h (CONFIG_64BIT_PHYS_ADDR)
Content-Type: multipart/alternative;
 boundary="------------83E8F6EE13791CE1B2EF091D"
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips


--------------83E8F6EE13791CE1B2EF091D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From pgtable-bits.h:

#if defined(CONFIG_CPU_MIPS32) && defined(CONFIG_64BIT_PHYS_ADDR)

#define _PAGE_PRESENT               (1<<6)  /* implemented in software */
#define _PAGE_READ                  (1<<7)  /* implemented in software */
#define _PAGE_WRITE                 (1<<8)  /* implemented in software */
#define _PAGE_ACCESSED              (1<<9)  /* implemented in software */
#define _PAGE_MODIFIED              (1<<10) /* implemented in software */

#define _PAGE_R4KBUG                (1<<0)  /* workaround for r4k bug  */
#define _PAGE_GLOBAL                (1<<0)

Is the aliasing between R4KBUG & GLOBAL intentional? This is the only CONFIG case where it
is done. Superficially, I can't see R4KBUG used anywhere, so maybe it doesn't matter. But
if R4KBUG truly isn't used, why not consider removing it entirely from all PTE layouts?

/Hartvig


--------------83E8F6EE13791CE1B2EF091D
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<tt>From pgtable-bits.h:</tt><tt></tt>
<p><tt>#if defined(CONFIG_CPU_MIPS32) &amp;&amp; defined(CONFIG_64BIT_PHYS_ADDR)</tt>
<br><tt>&nbsp;</tt>
<br><tt>#define _PAGE_PRESENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(1&lt;&lt;6)&nbsp; /* implemented in software */</tt>
<br><tt>#define _PAGE_READ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(1&lt;&lt;7)&nbsp; /* implemented in software */</tt>
<br><tt>#define _PAGE_WRITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(1&lt;&lt;8)&nbsp; /* implemented in software */</tt>
<br><tt>#define _PAGE_ACCESSED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(1&lt;&lt;9)&nbsp; /* implemented in software */</tt>
<br><tt>#define _PAGE_MODIFIED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(1&lt;&lt;10) /* implemented in software */</tt>
<br><tt>&nbsp;</tt>
<br><tt>#define _PAGE_R4KBUG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(1&lt;&lt;0)&nbsp; /* workaround for r4k bug&nbsp; */</tt>
<br><tt>#define _PAGE_GLOBAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(1&lt;&lt;0)</tt><tt></tt>
<p><tt>Is the aliasing between R4KBUG &amp;&nbsp;GLOBAL&nbsp;intentional?
This is the only CONFIG case where it</tt>
<br><tt>is done. Superficially, I&nbsp;can't see R4KBUG&nbsp;used anywhere,
so maybe it doesn't matter. But</tt>
<br><tt>if R4KBUG&nbsp;truly isn't used, why not consider removing it entirely
from all PTE&nbsp;layouts?</tt><tt></tt>
<p><tt>/Hartvig</tt>
<br><tt></tt>&nbsp;</html>

--------------83E8F6EE13791CE1B2EF091D--
