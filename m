Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Mar 2003 21:58:01 +0000 (GMT)
Received: from 154-84-51-66.reonbroadband.com ([IPv6:::ffff:66.51.84.154]:18304
	"EHLO tibook.netx4.com") by linux-mips.org with ESMTP
	id <S8225193AbTCKV6A>; Tue, 11 Mar 2003 21:58:00 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h2BLvqw01448;
	Tue, 11 Mar 2003 16:57:52 -0500
Message-ID: <3E6E5BE0.4000203@embeddededge.com>
Date: Tue, 11 Mar 2003 16:57:52 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric DeVolder <eric.devolder@amd.com>
CC: Pete Popov <ppopov@mvista.com>, Bruno Randolf <br1@4g-systems.de>,
	linux-mips@linux-mips.org
Subject: Re: Mycable XXS board
References: <3E689267.3070509@prosyst.bg> <20030307133919.P26071@mvista.com> <3E691514.7000907@embeddededge.com> <200303111130.57387.br1@4g-systems.de> <1047395856.5198.127.camel@zeus.mvista.com> <3E6E588A.1090702@amd.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Eric DeVolder wrote:

> Check linux/arch/mips/au1000/common/irq.c, in function init_IRQ().
> Currently all the interrupt assignment are conditionalized per-board,

Well, only some of them, in particular the custom GPIO configurations.
In the case of USB and other on-chip peripherals, these are always
configured on all boards.

> ... I suspect many IRQ setups may be wrong.

I don't really think so.  I've done several different Au1xxx boards and
never touch this configuration for USB.  I would like to hear the
results of the message posted earlier today about the proper power up
of the USB interface on this board :-)


Thanks.


	-- Dan
