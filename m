Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 03:12:23 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:58094 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225202AbTGaCMV>;
	Thu, 31 Jul 2003 03:12:21 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6V2CJV03298;
	Wed, 30 Jul 2003 19:12:19 -0700
Date: Wed, 30 Jul 2003 19:12:19 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: Malta + USB on 2.4, anyone?
Message-ID: <20030730191219.A14914@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


Has anybody tried USB on malta with 2.4 kernel?  I just found that
I got 0xff IRQ number and kernel panics.

Will look further tomorrow, but want to see if anybody knows about 
it first.

Also, the kgdb seems to be flaky.  Targets can send chars too fast
so that chars get lost.  It appears that the linux status register
might be lying about "transmitter buffer empty".  

Jun
