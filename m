Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2008 20:41:31 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:26367 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23894393AbYKXUlX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Nov 2008 20:41:23 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492b11570000>; Mon, 24 Nov 2008 15:40:55 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Nov 2008 12:40:52 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Nov 2008 12:40:52 -0800
Message-ID: <492B1153.5080001@caviumnetworks.com>
Date:	Mon, 24 Nov 2008 12:40:51 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
CC:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
References: <49261BE5.2010406@caviumnetworks.com>	<49280FC5.3040608@ru.mvista.com> <20081122145204.52270dbe@lxorguk.ukuu.org.uk>
In-Reply-To: <20081122145204.52270dbe@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Nov 2008 20:40:52.0070 (UTC) FILETIME=[F0D91060:01C94E74]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Alan Cox wrote:
>>    But if you're saying that there is only DMA completion inetrrupt, you 
>> *cannot* completely emulate SFF-8038i BMDMA since its interrupt status 
>> is the (delayed) IDE INTRQ status. I suggest that you move away from the 
>> emulation -- Alan has said it's possible.
> 
> I don't see whats wrong with treating it that way if it keeps the amount
> of code needed down.
> 

For exactly that reason, I intend to continue to try to emulate it.

David Daney
