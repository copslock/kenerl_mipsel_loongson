Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 12:19:29 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:47924 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27027214AbcDUKTYmVSkE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Apr 2016 12:19:24 +0200
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::1000])
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <aurelien@aurel32.net>)
        id 1atBhk-0007Ce-4B
        for linux-mips@linux-mips.org; Thu, 21 Apr 2016 12:19:24 +0200
Received: from aurel32 by ohm.aurel32.net with local (Exim 4.87)
        (envelope-from <aurelien@aurel32.net>)
        id 1atBhj-0006Tp-Si
        for linux-mips@linux-mips.org; Thu, 21 Apr 2016 12:19:23 +0200
Date:   Thu, 21 Apr 2016 12:19:23 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-mips@linux-mips.org
Subject: Emulation of unaligned LDXC1/SDXC1 instructions
Message-ID: <20160421101923.GA24852@aurel32.net>
Mail-Followup-To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

Hi all,

Debian recently got access to Cavium III machines which have an FPU,
before we were using Cavium II machines with the kernel FPU emulation.

It appears some code (at least openjdk and lcms2, probably more) use the
LDXC1 and SDXC1 instructions with word aligned addresses instead of
double-word aligned addresses as required by the specification. This
causes a SIGILL. The kernel emulation is more relaxed and allow word
aligned addresses.

First of all I am surprised to get a SIGILL in that case instead of a
SIGBUS, and secondly I think the behavior with and without FPU should be
consistent. The kernel currently emulates unaligned LDC1 and SDC1
instructions even with an FPU, so I wonder if the kernel should also
emulate unaligned LDXC1 and SDXC1 instructions.

Any opinion?

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
