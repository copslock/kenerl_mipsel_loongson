Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Sep 2004 11:16:08 +0100 (BST)
Received: from c2ce9fba.adsl.oleane.fr ([IPv6:::ffff:194.206.159.186]:7079
	"EHLO nikita.france.sdesigns.com") by linux-mips.org with ESMTP
	id <S8224953AbUIJKQE>; Fri, 10 Sep 2004 11:16:04 +0100
Received: from nikita.france.sdesigns.com (localhost.localdomain [127.0.0.1])
	by nikita.france.sdesigns.com (8.12.11/8.12.11) with ESMTP id i8AAFxKp018478;
	Fri, 10 Sep 2004 12:15:59 +0200
Received: (from michon@localhost)
	by nikita.france.sdesigns.com (8.12.11/8.12.11/Submit) id i8AAFwet018477;
	Fri, 10 Sep 2004 12:15:58 +0200
X-Authentication-Warning: nikita.france.sdesigns.com: michon set sender to em@realmagic.fr using -f
Subject: ...cache dimensioning ;-)
From: Emmanuel Michon <em@realmagic.fr>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: REALmagic France SAS
Message-Id: <1094811358.29872.8745.camel@nikita.france.sdesigns.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 12:15:58 +0200
Return-Path: <em@realmagic.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: em@realmagic.fr
Precedence: bulk
X-list: linux-mips

Hi,

I'm still in the process of choosing the best configurable parameters of
a hardware design based on 4KEc

As far as I understand, excepted alpha platforms, 4KByte pages are the
de facto standard [I assume linux developers are reasonable so changing
the page size to 8KB is not going to be a nightmare...]

Since the mips cache is virtually indexed but physically tagged, I see
two problems when the size of a cache way exceeds the size of a page:

- virtual aliasing. Can only happen on R/W pages (data cache) and only
when two different virtual addresses map the same physical page. An
example of this is: two processes sharing a memory area; should I
consider this is taken into account by linux already?

- I was told the software exception handlers for tlb are much less
efficient when cacheway > pagesize, forcing to flush too often. Is this
true? What is, in practice, the ratio of instruction pages and data
pages in a tlb?

If I consider a platform like Toshiba TX39 which has d-cache four ways
with total 32KBytes, it must already have the problems above. I'd like
to get some more clues though...

Thanks a lot,

Sincerely yours,

E.M.
