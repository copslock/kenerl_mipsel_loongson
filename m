Received:  by oss.sgi.com id <S553910AbRBUNGy>;
	Wed, 21 Feb 2001 05:06:54 -0800
Received: from sovereign.org ([209.180.91.170]:51375 "EHLO lux.homenet")
	by oss.sgi.com with ESMTP id <S553773AbRBUNGc>;
	Wed, 21 Feb 2001 05:06:32 -0800
Received: (from jfree@localhost)
	by lux.homenet (8.11.2/8.11.2/Debian 8.11.2-1) id f1LD7BD26818
	for linux-mips@oss.sgi.com; Wed, 21 Feb 2001 06:07:11 -0700
From:   Jim Freeman <jfree@sovereign.org>
Date:   Wed, 21 Feb 2001 06:07:11 -0700
To:     linux-mips@oss.sgi.com
Subject: sync plea
Message-ID: <20010221060711.A26654@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I have a farm of MIPS, PPC, and IA32 machines that I need to
keep running from a common current source tree.

The recent mips update into 2.4.2pre2 (thankyouthankyouthankyou...)
has helped in this task, but the diff between any 2.4.2pre[n>=2] or
2.4.1-ac[n>=9] tree vs the MIPS cvs tree is still huge, and painful
to cull through to wind up with a sane mips patch (should be fairly
small since the update into 2.4.2pre2) against a 2.4.*{pre*|-ac*} tree.

A sync of mips cvs to any 2.4.1{pre*|-ac*} kernel post 2.4.2pre2
would be of great use, but I don't know how much pain that entails
for the maintainers.

In lieu of that, can anyone clue me in to newbie tricks (CVS or
otherwise) for syncing 2 trees less painfully than culling diffs?

TIA,
...jfree
