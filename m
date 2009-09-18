Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2009 22:03:30 +0200 (CEST)
Received: from mgw2.diku.dk ([130.225.96.92]:49470 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S2097378AbZIRUDX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Sep 2009 22:03:23 +0200
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 6C20619BCCC;
	Fri, 18 Sep 2009 22:03:18 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27430-11; Fri, 18 Sep 2009 22:03:17 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 62C7D19BCC3;
	Fri, 18 Sep 2009 22:03:17 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id E57976DF835; Fri, 18 Sep 2009 22:01:20 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3767)
	id 49EABF455; Fri, 18 Sep 2009 22:03:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ask.diku.dk (Postfix) with ESMTP id 447E3F0AB;
	Fri, 18 Sep 2009 22:03:17 +0200 (CEST)
Date:	Fri, 18 Sep 2009 22:03:17 +0200 (CEST)
From:	Julia Lawall <julia@diku.dk>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: question about arch/mips/kernel/smtc.c
Message-ID: <Pine.LNX.4.64.0909182202140.4238@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: amavisd-new at diku.dk
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

The file arch/mips/kernel/smtc.c contains:

static struct irqaction irq_ipi = {
        .handler        = ipi_interrupt,
        .flags          = IRQF_DISABLED,
        .name           = "SMTC_IPI",
        .flags          = IRQF_PERCPU
};

Is it intentional that there are two definitions of the flags field?

julia
