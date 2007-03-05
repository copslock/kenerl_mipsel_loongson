Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2007 16:53:02 +0000 (GMT)
Received: from newmail.sw.starentnetworks.com ([12.33.234.78]:56990 "EHLO
	mail.sw.starentnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20037605AbXCEQw4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Mar 2007 16:52:56 +0000
Received: from zeus.sw.starentnetworks.com (zeus.sw.starentnetworks.com [12.33.233.46])
	by mail.sw.starentnetworks.com (Postfix) with ESMTP id BD0F63E15F
	for <linux-mips@linux-mips.org>; Mon,  5 Mar 2007 11:52:05 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17900.19125.660006.553487@zeus.sw.starentnetworks.com>
Date:	Mon, 5 Mar 2007 11:52:05 -0500
From:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>
To:	linux-mips@linux-mips.org
Subject: Re: SMP+PREEMPT causes NULL dereference in khelper on startup
In-Reply-To: <17897.48239.366047.442797@zeus.sw.starentnetworks.com>
References: <17897.48239.366047.442797@zeus.sw.starentnetworks.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linux-mips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips

Dave Johnson writes:
> It appears a0 to detach_pid (*task) points to somewhere wrong as
> 'link' (now in a1) is a valid pointer, but points to a bunch of
> zeros.

I found the issue.  This appears to be a compiler bug in
__unhash_process().

SMP (works):
-----------

ffffffff8013c940:       0220f809        jalr    s1
ffffffff8013c944:       0080802d        move    s0,a0
ffffffff8013c948:       24050001        li      a1,1
ffffffff8013c94c:       de020170        ld      v0,368(s0)
ffffffff8013c950:       12020015        beq     s0,v0,ffffffff8013c9a8 <$L10>
ffffffff8013c954:       0200202d        move    a0,s0

[...]

ffffffff8013c9a8 <$L10>:
ffffffff8013c9a8:       0220f809        jalr    s1    <<< detach_pid(p, PIDTYPE_PGID);
ffffffff8013c9ac:       00000000        nop
ffffffff8013c9b0:       0200202d        move    a0,s0
ffffffff8013c9b4:       0220f809        jalr    s1    <<< detach_pid(p, PIDTYPE_SID);
ffffffff8013c9b8:       24050002        li      a1,2


SMP+PREEMPT (fails):
-------------------

ffffffff8013e62c:       0220f809        jalr    s1
ffffffff8013e630:       0080802d        move    s0,a0
ffffffff8013e634:       24050001        li      a1,1
ffffffff8013e638:       de020170        ld      v0,368(s0)
ffffffff8013e63c:       12020016        beq     s0,v0,ffffffff8013e698 <$L10>
ffffffff8013e640:       0200202d        move    a0,s0

[...]
ffffffff8013e698 <$L10>:
ffffffff8013e698:       0220f809        jalr    s1    <<< detach_pid(p, PIDTYPE_PGID);
ffffffff8013e69c:       0200202d        move    a0,s0
ffffffff8013e6a0:       0220f809        jalr    s1    <<< detach_pid(p, PIDTYPE_SID);
ffffffff8013e6a4:       24050002        li      a1,2


The delay slot is missing after the first call causing a0 to not
get set for the second call.



-- 
Dave Johnson
Starent Networks
