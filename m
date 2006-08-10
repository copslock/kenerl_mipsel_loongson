Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2006 14:27:56 +0100 (BST)
Received: from buzzloop.caiaq.de ([212.112.241.133]:41232 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S20043400AbWHJN1x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Aug 2006 14:27:53 +0100
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id A1C787F4028;
	Thu, 10 Aug 2006 15:27:46 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23060-08; Thu, 10 Aug 2006 15:27:46 +0200 (CEST)
Received: from [192.168.1.140] (port-83-236-238-37.static.qsc.de [83.236.238.37])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by buzzloop.caiaq.de (Postfix) with ESMTP id 302DF7F4022;
	Thu, 10 Aug 2006 15:27:46 +0200 (CEST)
In-Reply-To: <20060810065337.GA8889@roarinelk.homelinux.net>
References: <20060810065337.GA8889@roarinelk.homelinux.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <78B291EC-774F-4FDF-AB9D-133F38A3215E@caiaq.de>
Cc:	linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] Au1200 OHCI/EHCI fixes
Date:	Thu, 10 Aug 2006 15:27:43 +0200
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
X-Mailer: Apple Mail (2.752.2)
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips

Hi,

On Aug 10, 2006, at 8:53 AM, Manuel Lauss wrote:

> This little patch fixes compileproblems in Au1000
> OHCI/EHCI code. Run-tested on custom Au1200 Platform.

This has already been fixed - a similar patch went upstream to 2.6.18- 
rc3.
Did you check out the latest git?

Daniel
