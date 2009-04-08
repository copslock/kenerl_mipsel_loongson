Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 00:50:42 +0100 (BST)
Received: from main.gmane.org ([80.91.229.2]:28385 "EHLO ciao.gmane.org")
	by ftp.linux-mips.org with ESMTP id S20033025AbZDHXua (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 00:50:30 +0100
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LrhXJ-00027g-8u
	for linux-mips@linux-mips.org; Wed, 08 Apr 2009 23:50:29 +0000
Received: from 64-142-12-132.dsl.static.sonic.net ([64.142.12.132])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 08 Apr 2009 23:50:29 +0000
Received: from dave+gmane by 64-142-12-132.dsl.static.sonic.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 08 Apr 2009 23:50:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
To:	linux-mips@linux-mips.org
From:	David Wuertele <dave+gmane@wuertele.com>
Subject:  Re: What is the right way to setup MIPS timer irq in 2.6.29?
Date:	Wed, 8 Apr 2009 23:50:16 +0000 (UTC)
Message-ID:  <loom.20090408T233853-399@post.gmane.org>
References:  <loom.20090408T165537-312@post.gmane.org> <1239230814.14558.42.camel@chaos.ne.broadcom.com>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 64.142.12.132 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.8) Gecko/2009032608 Firefox/3.0.8)
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave+gmane@wuertele.com
Precedence: bulk
X-list: linux-mips

Cable STB SOC, I'm away from my desk but I think it was BCM7456D0.

> 
> Which platform?
> > 
> > Can anyone offer pointers on how to call setup_irq() from plat_time_init()?
