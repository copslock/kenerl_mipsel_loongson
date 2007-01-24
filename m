Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 19:41:25 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:55518 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20045869AbXAXTlV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2007 19:41:21 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 95A623EC9; Wed, 24 Jan 2007 11:40:46 -0800 (PST)
Message-ID: <45B7B63E.70608@ru.mvista.com>
Date:	Wed, 24 Jan 2007 22:40:46 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
  er
References: <45B78C19.4030408@pmc-sierra.com>
In-Reply-To: <45B78C19.4030408@pmc-sierra.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Marc St-Jean wrote:

>>http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc4/2.6.20-rc4-mm1/broken-out/8250-uart-backup-timer.patch

> This second patch failure description is identical to what we are seeing without
> the THRE work-around. This must be the timer patch Alan mentioned but it's not
> in the linux.git at l-m.o.

    Yeah, it must still be considered "experimental" as it resides only within 
the -mm tree.

> Could you please explain what you mean by and where I can find the "-mm tree"?

    http://kernel.org/patchtypes/mm.html

    As the serial drivers have no maintainer now, you probably have to CC the 
final patch to Andrew Morton (akpm@osdl.org), so it'd be better to be 
applicable against the recent -mm patch.

> Marc

MBR, Sergei
