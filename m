Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2009 16:02:40 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47975 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493918AbZLGPCh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Dec 2009 16:02:37 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB7F2abu024960
        for <linux-mips@linux-mips.org>; Mon, 7 Dec 2009 15:02:37 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB7F2aaq024958
        for linux-mips@linux-mips.org; Mon, 7 Dec 2009 15:02:36 GMT
Date:   Mon, 7 Dec 2009 15:02:36 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: Warning about add_wired_entry
Message-ID: <20091207150236.GD19269@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

The earlier posting wrt. add_wired_entry reminded my of this long standing
issue.

The kernel does not reserve any address space for use by add_wired_entry().
In other words there is the possibility that vmalloc, ioremap or other
kernel APIs will use the same address space resulting in a crash or worse.

Currently there are three users of add_wired_entry:

 - Alchemy
 - Cavium
 - Jazz

The interface itself also is hostile as it directly exposes the MIPS TLB
registers to the C programmer so should die.  And often wiring a TLB entry
is a bad idea.  TLB entries are a scarce resource and wasting them unwisely
may impact performance.  Especially on the lowest-end CPUs with just
16 TLB entries this can be significant but even on the high-end TLBs with
64 entries it's not always clear if wiring entries is a good idea.  And
there are a few core types that don't even have the capability of wiring
entries.

  Ralf
