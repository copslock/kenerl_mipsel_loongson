Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 20:24:09 +0100 (BST)
Received: from h24-80-147-251.no.shawcable.net ([IPv6:::ffff:24.80.147.251]:8721
	"EHLO antichrist") by linux-mips.org with ESMTP id <S8225205AbTDJTYI>;
	Thu, 10 Apr 2003 20:24:08 +0100
Received: by antichrist (Postfix, from userid 1003)
	id 1660C4030; Thu, 10 Apr 2003 12:23:20 -0700 (PDT)
Date: Thu, 10 Apr 2003 12:23:19 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: linux-mips@linux-mips.org
Subject: recommended toolchain
Message-ID: <20030410192319.GA21381@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <ramune@net-ronin.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ramune@net-ronin.org
Precedence: bulk
X-list: linux-mips

Hi,

	What's the currently recommended toolchain for building MIPS kernels?
I'm working on a NEC VR4111 (mipsel, MIPS16, I, II, III, no LL/SC :P) and
would like to avoid tracking down toolchain bugs.

	Also, Are partial patches (i.e. platform not fully functional yet)
accepted?  Or should I finish a full port (hits userland) first?

	Vadem Clio 1000, reading the 2.4.0-test9 tree that's the last version
I see in CVS and porting to 2.5 (bk pull as of... a while ago).

	Thanks,

-- DN
Daniel
