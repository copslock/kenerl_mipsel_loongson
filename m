Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2007 13:48:43 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:45253 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038843AbXBPNsi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Feb 2007 13:48:38 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 0C1AC3EC9; Fri, 16 Feb 2007 05:48:03 -0800 (PST)
Message-ID: <45D5B60F.7020104@ru.mvista.com>
Date:	Fri, 16 Feb 2007 16:47:59 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Marc St-Jean <stjeanma@pmc-sierra.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git master
References: <200702151926.l1FJQT2o020816@pasqua.pmc-sierra.bc.ca> <20070215171035.83918aae.akpm@linux-foundation.org>
In-Reply-To: <20070215171035.83918aae.akpm@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Andrew Morton wrote:

>>+			status = *(volatile u32 *)up->port.private_data;

> It distresses me that this patch uses a variable which this patch
> doesn't initialise anywhere.  It isn't complete.

    I assume this gets passed via early_serial_setup(). Marc?

> The sub-driver code whch sets up this field shuld be included in the
> patch, no?

    Hardly so, this code (not a subdriver) resides under arch/mips/ I think.

WBR, Sergei
