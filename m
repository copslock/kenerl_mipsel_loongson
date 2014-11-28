Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Nov 2014 00:50:24 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:54690 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007454AbaK1XuWfKpGN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Nov 2014 00:50:22 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 89C5E1538A; Fri, 28 Nov 2014 23:50:16 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     linux-mips@linux-mips.org
Subject: fast_iob() vs PHYS_OFFSET
Date:   Fri, 28 Nov 2014 23:50:16 +0000
Message-ID: <yw1xsih2evgn.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

I'm a little confused over the interaction between fast_iob() and
non-zero PHYS_OFFSET.

The __fast_iob() macro performs a load from CKSEG1.  AFAICT, CKSEG1 is
always (on 32-bit systems) defined to 0xa0000000.  In case of a non-zero
PHYS_OFFSET, this address might not map to anything in particular, and
almost certainly not RAM.  There is a special case for IP28, but this is
not the only system with an unusual address map.

What am I missing?

-- 
Måns Rullgård
mans@mansr.com
