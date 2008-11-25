Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 17:38:16 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:22568 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23910635AbYKYRiO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Nov 2008 17:38:14 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492c37fa0000>; Tue, 25 Nov 2008 12:38:02 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 09:38:00 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 09:37:59 -0800
Message-ID: <492C37F7.5060509@caviumnetworks.com>
Date:	Tue, 25 Nov 2008 09:37:59 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
CC:	Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] libata: New driver for OCTEON SOC Compact Flash interface
 (v2).
References: <492B56B0.9030409@caviumnetworks.com>	<1227577181-30206-2-git-send-email-ddaney@caviumnetworks.com>	<492C2EE2.3090702@garzik.org>	<492C3509.8010408@caviumnetworks.com> <20081125173401.44c28e17@lxorguk.ukuu.org.uk>
In-Reply-To: <20081125173401.44c28e17@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Nov 2008 17:37:59.0952 (UTC) FILETIME=[8F5E7900:01C94F24]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Alan Cox wrote:
>> system.  The only recourse is to cycle power to the board.  By allowing 
>> DMA to be disabled, we eliminate this problem.
> 
> You can already do this via the existing libata option functions that
> Tejun added a while back, or there is libata.dma=0 which is applied to
> all interfaces.
> 

Great, I will remove our driver's option.

David Daney
