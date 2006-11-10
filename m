Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Nov 2006 18:40:22 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:34003 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038621AbWKJSkS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Nov 2006 18:40:18 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id BF4B03EBE; Fri, 10 Nov 2006 10:39:53 -0800 (PST)
Message-ID: <4554C770.10106@ru.mvista.com>
Date:	Fri, 10 Nov 2006 21:39:44 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	compudj@krystal.dyndns.org, tt-dev@shafik.org
Subject: [Fwd: [Ltt-dev] MIPS atomic operations, "sync"]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Forwarding to the correct mail list...

-------- Original Message --------
Subject: [Ltt-dev] MIPS atomic operations, "sync"
Date: Fri, 10 Nov 2006 13:36:53 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: lkml@vger.kernel.org, ltt-dev@shafik.org

Hi,

I am currently creating a "LOCK" prefix free and memory barrier free version
of atomic.h to fulfill my tracer (LTTng) needs, which is to atomically update
per-cpu data and have a minimal performance loss.

I just came across the MIPS atomic.h and system.h implementations in 2.6.18
which brings a question :

Why are the primitives in include/asm-mips/atomic.h using the "sync"
instruction even in the UP case ? system.h cmpxchg only uses the sync in the
SMP case.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
_______________________________________________
Ltt-dev mailing list
Ltt-dev@listserv.shafik.org
http://listserv.shafik.org/mailman/listinfo/ltt-dev
