Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2008 19:08:47 +0200 (CEST)
Received: from h155.mvista.com ([63.81.120.155]:6077 "EHLO imap.sh.mvista.com")
	by lappi.linux-mips.net with ESMTP id S532902AbYDCMlE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Apr 2008 14:41:04 +0200
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 91F913EC9; Thu,  3 Apr 2008 05:40:16 -0700 (PDT)
Message-ID: <47F4D006.4090200@ru.mvista.com>
Date:	Thu, 03 Apr 2008 16:39:34 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] PbAu1200: fix header breakage
References: <200804022353.19379.sshtylyov@ru.mvista.com>
In-Reply-To: <200804022353.19379.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> Looks like nobody ever cared since the code was merged -- there's no defconfig.

    Er, no... the breakage has been introduced by the commit 
95c4eb3ef4484ca85da5c98780d358cffd546b90 ([MIPS] Alchemy: Renumber interrupts 
so irq_cpu can work.), so thanks go to its hasty author. ;-)

WBR, Sergei
