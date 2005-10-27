Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Oct 2005 11:29:30 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:64789 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133569AbVJ0K3N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Oct 2005 11:29:13 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9RATDxi019415;
	Thu, 27 Oct 2005 11:29:14 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9RATD8L019414;
	Thu, 27 Oct 2005 11:29:13 +0100
Date:	Thu, 27 Oct 2005 11:29:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chris Boot <bootc@bootc.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: Execute-in-Place (XIP)
Message-ID: <20051027102912.GB17645@linux-mips.org>
References: <18E0376E-A524-42EE-A5ED-BDF9A0668DE6@bootc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18E0376E-A524-42EE-A5ED-BDF9A0668DE6@bootc.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 27, 2005 at 10:02:40AM +0100, Chris Boot wrote:

> Due to the puny amounts of RAM (2MB) on my board, I'm going to have  
> to use XIP so that RAM isn't being taken up by kernel code. I was  
> looking around for MIPS XIP patches and all I could find was in the  
> linux-vr tree which seems, well, dead.

The linux-vr tree is kept online for people to dig out the goodies which
may be left in there :-)

> Does anyone know of any more  
> recent patches or should I undertake the work of porting the patch to  
> a more recent 2.4 kernel?

I guess you'll have to do that.  The alternative would be to port the
2.6 ARM XIP_KERNEL implementation.

  Ralf
