Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Mar 2003 00:10:57 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:6387 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225197AbTCEAK5>;
	Wed, 5 Mar 2003 00:10:57 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h250AtB19303;
	Tue, 4 Mar 2003 16:10:55 -0800
Date: Tue, 4 Mar 2003 16:10:55 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com, rml@mvista.com
Subject: preemptible kernel support for mips32
Message-ID: <20030304161055.C18978@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


You can find the fresh baked MIPS preemptible kernel patch at 

http://linux.junsun.net/patches/oss.sgi.com/experimental/

You will need two patches there to make it work

030304-a.rml-preempt-2.4.21.no-arch.patch
030304-b.preempt-mips.patch

Robert, please incorporate the latest MIPS preemption support from the
second patch in your next patch release.

Jun
