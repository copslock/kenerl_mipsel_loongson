Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2008 15:06:22 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:18012 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23834755AbYKVPGI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 22 Nov 2008 15:06:08 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 569533EC9; Sat, 22 Nov 2008 07:06:00 -0800 (PST)
Message-ID: <49281FD4.4090006@ru.mvista.com>
Date:	Sat, 22 Nov 2008 18:05:56 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
References: <49261BE5.2010406@caviumnetworks.com>	<49280FC5.3040608@ru.mvista.com> <20081122145204.52270dbe@lxorguk.ukuu.org.uk>
In-Reply-To: <20081122145204.52270dbe@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Alan Cox wrote:

>>    But if you're saying that there is only DMA completion inetrrupt, you 
>> *cannot* completely emulate SFF-8038i BMDMA since its interrupt status 
>> is the (delayed) IDE INTRQ status. I suggest that you move away from the 
>> emulation -- Alan has said it's possible.
>>     
>
> I don't see whats wrong with treating it that way if it keeps the amount
> of code needed down.

   Well, as ata_sff_host_intr() doesn't get called, probably nothing 
indeed...

MBR, Sergei
