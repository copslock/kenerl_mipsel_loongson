Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Dec 2003 11:41:50 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:7808 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225073AbTLMLlk>; Sat, 13 Dec 2003 11:41:40 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.35 #1 (Debian))
	id 1AV89O-0002Zp-00; Sat, 13 Dec 2003 11:41:34 +0000
Date: Sat, 13 Dec 2003 11:41:34 +0000
To: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Subject: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
Message-ID: <20031213114134.GA9896@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

The current MIPS 2.4 kernel (from CVS) currently allows fixed shared
mappings to violate D-cache aliasing constraints.

The check for illegal fixed mappings is done in
arch_get_unmapped_area(), but these mappings are granted in
get_unmapped_area() and arch_get_unmapped_area() is never called.

A quick look at sparc and sparc64 seem to show the same problem.

P.
