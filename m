Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 20:30:18 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:49575 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039018AbXBWUaO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Feb 2007 20:30:14 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id A85063EC9; Fri, 23 Feb 2007 12:29:40 -0800 (PST)
Message-ID: <45DF4EAE.9060007@ru.mvista.com>
Date:	Fri, 23 Feb 2007 23:29:34 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] mtd: PMC MSP71xx flash/rootfs mappings
References: <200702231958.l1NJwMpn000422@pasqua.pmc-sierra.bc.ca>
In-Reply-To: <200702231958.l1NJwMpn000422@pasqua.pmc-sierra.bc.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Marc St-Jean wrote:
> [PATCH 5/5] mtd: PMC MSP71xx flash/rootfs mappings

> Patch to add flash and rootfs mappings for the PMC-Sierra
> MSP71xx devices.

> These 5 patches along with the previously posted serial patch
> will boot the PMC-Sierra MSP7120 Residential Gateway board.

> Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
> ---
>  Kconfig          |   31 +++++++++
>  Makefile         |    2 
>  pmcmsp-flash.c   |  180 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  pmcmsp-ramroot.c |  106 ++++++++++++++++++++++++++++++++
>  4 files changed, 319 insertions(+)

    This patch surely belongs to linux-mtd@lists.infradead.org

WBR, Sergei
