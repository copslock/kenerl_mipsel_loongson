Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2004 23:29:41 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:28399 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225214AbUHDW3h>;
	Wed, 4 Aug 2004 23:29:37 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i74MTaar014169;
	Wed, 4 Aug 2004 15:29:36 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i74MTaTH014168;
	Wed, 4 Aug 2004 15:29:36 -0700
Date: Wed, 4 Aug 2004 15:29:36 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: anybody tried NPTL?
Message-ID: <20040804152936.D6269@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


I am looking into porting NPTL to MIPS.  Just curious if
anybody has tried this before.

I notice there was a discussion about the ABI extension
for TLS (thread local storage) support.  Before that support
becomes a reality it seems one can still use NPTL with 
the help of additional system calls.

A rough search of latest glibc source shows there is
zero MIPS code for nptl.  A couple of other arches
are missing as well (such as ARM)

Jun
