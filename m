Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2003 17:48:01 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:50415 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224861AbTDQQsB>;
	Thu, 17 Apr 2003 17:48:01 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3HGlx316417;
	Thu, 17 Apr 2003 09:47:59 -0700
Date: Thu, 17 Apr 2003 09:47:59 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: What is .MIPS.options ELF section?
Message-ID: <20030417094759.C1642@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


I started to play with the new N32/N64 toolchains.  I notice a new
section is generated for kernel, called .MIPS.options.  (it actually
causes some grief for some firmware)

Can someone enlighten me a little bit on what it is? 


Jun
