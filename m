Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2003 05:53:42 +0100 (BST)
Received: from [IPv6:::ffff:63.161.110.249] ([IPv6:::ffff:63.161.110.249]:56054
	"EHLO tibook.netx4.com") by linux-mips.org with ESMTP
	id <S8225072AbTFCExj>; Tue, 3 Jun 2003 05:53:39 +0100
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h534rVq05662;
	Tue, 3 Jun 2003 00:53:32 -0400
Message-ID: <3EDC29CB.1010409@embeddededge.com>
Date: Tue, 03 Jun 2003 00:53:31 -0400
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: baitisj@evolution.com
CC: n_gale@ok.ru, linux-mips@linux-mips.org
Subject: Re: DBAu1500 board flash downloading
References: <web-13584424@backend4.aha.ru> <20030530144535.T29389@luca.pas.lab>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Jeff Baitis wrote:

> Rather than building an EJTAG interface, I recommend the Raven EJTAG interface.
> It plugs into your LPT port, and will plug into the EJTAG interface on your
> DBAu1500 board.

I can recommend the Abatron BDI-2000 (www.abatron.ch).  It's a powerful,
flexible tool that will work in a variety of development environments.
In addition to providing debugging features, it also has built-in flash
programming algorithms.  You can erase/program flash with simple console
or script commands from various file formats transferred over the network
using tftp.


	-- Dan
