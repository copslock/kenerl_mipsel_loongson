Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 17:51:01 +0000 (GMT)
Received: from 154-84-51-66.reonbroadband.com ([IPv6:::ffff:66.51.84.154]:30080
	"EHLO tibook.netx4.com") by linux-mips.org with ESMTP
	id <S8225223AbTCMRvA>; Thu, 13 Mar 2003 17:51:00 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h2DHolc01141;
	Thu, 13 Mar 2003 12:50:47 -0500
Message-ID: <3E70C4F7.4030008@embeddededge.com>
Date: Thu, 13 Mar 2003 12:50:47 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bruno Randolf <br1@4g-systems.de>
CC: linux-mips@linux-mips.org
Subject: Re: Mycable XXS board
References: <3E689267.3070509@prosyst.bg> <200303131408.05612.br1@4g-systems.de> <3E70ABCE.9030909@embeddededge.com> <200303131823.22343.br1@4g-systems.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Bruno Randolf wrote:

> allright, i can do that - but doesn't this create a lot of unnecessary copied 
> code?

Initially, perhaps, but over time similar software will be moved into
common areas.  IMHO, it helps to keep these boards separate because
it serves to remind us the XXS board is not a PB1500.  You may also
find more things unique to your board, so the unique board configuration
will become useful to isolate features.

Thanks.


	-- Dan
