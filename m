Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Nov 2006 21:51:51 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:9298 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20038695AbWKJVvq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Nov 2006 21:51:46 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Fwd: [Ltt-dev] MIPS atomic operations, "sync"]
Date:	Fri, 10 Nov 2006 13:51:38 -0800
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D4822E5@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Fwd: [Ltt-dev] MIPS atomic operations, "sync"]
Thread-Index: AccE99Zx9YPIosZXSVyRUJ1HYRLqigAGg3iw
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>,
	"Linux-MIPS" <linux-mips@linux-mips.org>
Cc:	<compudj@krystal.dyndns.org>, <tt-dev@shafik.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> I just came across the MIPS atomic.h and system.h 
> implementations in 2.6.18
> which brings a question :
> 
> Why are the primitives in include/asm-mips/atomic.h using the "sync"
> instruction even in the UP case ? system.h cmpxchg only uses 
> the sync in the
> SMP case.

There was just a discussion about this in the mailing list. Check the
archive.

Ralf Baechle mentioned that he has a patch to remove the syncs from
uniprocessor code, so that would seem to answer your question.

Thread subject line: "Sync operation in atomic_add_return()".
