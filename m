Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 18:51:03 +0000 (GMT)
Received: from 154-84-51-66.reonbroadband.com ([IPv6:::ffff:66.51.84.154]:38784
	"EHLO tibook.netx4.com") by linux-mips.org with ESMTP
	id <S8225223AbTCMSux>; Thu, 13 Mar 2003 18:50:53 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h2DIokc01209;
	Thu, 13 Mar 2003 13:50:46 -0500
Message-ID: <3E70D306.5090608@embeddededge.com>
Date: Thu, 13 Mar 2003 13:50:46 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: baitisj@evolution.com
CC: Pete Popov <ppopov@mvista.com>, linux-mips@linux-mips.org
Subject: Re: arch/mips/au1000/common/irq.c
References: <20030313104704.V20129@luca.pas.lab>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Jeff Baitis wrote:

> Pete:
> 
> I've got a question concerning irq.c. In intc0_req0_irqdispatch() (linux_2_4
> branch) on lines 545 thru 552, the code reads:

I'm hacking these functions to use 'clz' and for other updates, so
the code will be changing soon, anyway :-)  Comment on the next version :-)

Thanks.


	-- Dan
