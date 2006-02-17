Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 17:20:30 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:59347 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133441AbWBQRUW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Feb 2006 17:20:22 +0000
Received: (qmail 8932 invoked from network); 17 Feb 2006 17:26:55 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 17 Feb 2006 17:26:55 -0000
Message-ID: <43F60824.9030401@ru.mvista.com>
Date:	Fri, 17 Feb 2006 20:30:12 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Jordan Crouse <jordan.crouse@amd.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Small time UART configuration fix for AU1100 processor
References: <20060217145406.GE14066@dusktilldawn.nl> <20060217172447.GA30429@cosmic.amd.com>
In-Reply-To: <20060217172447.GA30429@cosmic.amd.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Jordan Crouse wrote:
> I know this is a stupid question for an AMD employee to ask, but since
> I've only been associated with the AU1200, and to a limited extent the AU1550,
> do *ANY* of our boards have an UART2 on them?

   Looks like only Au1000 SOC has all 4 UARTs. The other SOCs have UART2 
missing...

> Jordan

WBR, Sergei
