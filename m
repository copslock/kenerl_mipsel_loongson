Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 16:03:33 +0000 (GMT)
Received: from 154-84-51-66.reonbroadband.com ([IPv6:::ffff:66.51.84.154]:4992
	"EHLO tibook.netx4.com") by linux-mips.org with ESMTP
	id <S8225223AbTCMQDd>; Thu, 13 Mar 2003 16:03:33 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h2DG3Qc00922;
	Thu, 13 Mar 2003 11:03:26 -0500
Message-ID: <3E70ABCE.9030909@embeddededge.com>
Date: Thu, 13 Mar 2003 11:03:26 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bruno Randolf <br1@4g-systems.de>
CC: linux-mips@linux-mips.org
Subject: Re: Mycable XXS board
References: <3E689267.3070509@prosyst.bg> <3E6E588A.1090702@amd.com> <3E6E5BE0.4000203@embeddededge.com> <200303131408.05612.br1@4g-systems.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Bruno Randolf wrote:

> i got USB to work with the proper power up :)

Cool, thanks for the update.

> i attach a patch with the usb power up for the mycable XXS board,

The way this should really be done is to have a board definition,
directory and files unique to the XXS board.  Hacking the PB1500
may be the fast way to get it done locally, but it isn't the right
way from a Linux structure/maintenance viewpoint.

Thanks.

	-- Dan
