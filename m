Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 12:36:57 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:5309 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021845AbXCSMgw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2007 12:36:52 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id C65063ED1; Mon, 19 Mar 2007 05:36:14 -0700 (PDT)
Message-ID: <45FE83B6.3040100@ru.mvista.com>
Date:	Mon, 19 Mar 2007 15:36:06 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Marco Braga <marco.braga@gmail.com>
Cc:	Michael Stickel <michael@cubic.org>, linux-mips@linux-mips.org
Subject: Re: Au1500 and TI PCI1510 cardbus
References: <d459bb380703161129l769d3f48w744ba0bfdf04fc91@mail.gmail.com>	 <45FBB9C7.9060800@cubic.org>	 <d459bb380703170554l3fb40d60h6f68b70472ad7cb@mail.gmail.com>	 <45FBF0F1.70302@cubic.org> <d459bb380703180617i6e50539bx13ad405fb306fe44@mail.gmail.com>
In-Reply-To: <d459bb380703180617i6e50539bx13ad405fb306fe44@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Marco Braga wrote:
>> I am sory, I meant the datasheet of the Au1500. I do not find the
>> paragraph anymore, but can tell you more on monday.

    I think Michael actually mean the specification update, not datasheet.
Indeed, errata 32

> Thank you. I've checked the data book but I've not found anything so
> explicit. Paragraph 4.3.10 "Other notes" states:

> "The Au1500 PCI contoller cannot be used with external PCI-to-PCI bridges
> that have PCI bus-mastering devices on the
> secondary bus which target the Au1500 memory."

> But this is not exactly an explanation.. I've found nothing regarding race
> conditions or delayed transactions. I'll wait eagerly for monday when all
> the truths will be revealed. :)

    Hrm, this seems enough of an explanation -- it basically says that you 
can't use any decent PCI device behind the bridge.  The abovementioned errata 
tells that "any mastering device on the other side of a P2P bridge, where the 
target is the Au1500 processor, will eventually lead to a lock-up condition of 
the PCI bus or even the entire system".

> Thanks!!

WBR, Sergei
