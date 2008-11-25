Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 18:41:48 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:11429 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23795161AbYKYSll (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2008 18:41:41 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 655933EC9; Tue, 25 Nov 2008 10:41:37 -0800 (PST)
Message-ID: <492C46E2.90904@ru.mvista.com>
Date:	Tue, 25 Nov 2008 21:41:38 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	Jeff Garzik <jeff@garzik.org>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
References: <492B56B0.9030409@caviumnetworks.com>	<1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com>	<492C2F23.8050105@garzik.org> <20081125171224.297931b2@lxorguk.ukuu.org.uk>
In-Reply-To: <20081125171224.297931b2@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Alan Cox wrote:

>>>The forthcoming OCTEON SOC Compact Flash driver needs a few more
>>>timing values than were available in the ata_timing table.  I add new
>>>columns for write_hold, read_hold, and read_holdz times.  The values
>>>were obtained from the Compact Flash specification Rev 4.1.

>>>Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>>>---
>>> drivers/ata/libata-core.c |   76 ++++++++++++++++++++++++--------------------
>>> include/linux/libata.h    |   14 ++++++--
>>> 2 files changed, 52 insertions(+), 38 deletions(-)

>>I would be happy to go ahead and apply this...  Alan, any last minute 
>>objections?

> Its close but I think Sergei is right about columns with all the same
> value - they can be constants and just computed into the final timing
> data in terms of clocks.

    The problem is that there's no exported libata API to compute just one 
arbitrary timing.

WBR, Sergei
