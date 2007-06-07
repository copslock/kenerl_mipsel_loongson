Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 15:48:16 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:43955 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022670AbXFGOsO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2007 15:48:14 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id D39B03EC9; Thu,  7 Jun 2007 07:48:10 -0700 (PDT)
Message-ID: <46681B17.2080207@ru.mvista.com>
Date:	Thu, 07 Jun 2007 18:49:59 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Tickless/dyntick kernel, highres timer and general time crapectomy
References: <20070606185450.GA10511@linux-mips.org>	 <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com>	 <20070607113032.GA26047@linux-mips.org>	 <cda58cb80706070611t3083f026p769e3e1beee1f11e@mail.gmail.com>	 <46680B75.5040809@ru.mvista.com> <cda58cb80706070744v21e1bbf3sa28990b4477a8844@mail.gmail.com>
In-Reply-To: <cda58cb80706070744v21e1bbf3sa28990b4477a8844@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Franck Bui-Huu wrote:

> [ weird, Gmail thought you were a spamer... ]

    Well, I guess I should thank my ISP which indeed hosts many spammers. :-)

> Sergei Shtylyov wrote:

>>    No, it doesn't. Even on dyntick kernels, interrupts do happen several
>> times a second. Dynticks have nothing to do with disabling timer
>> interrupts...
>>
> 
> That's true however if your system has 2 clock devices. One is the r4k-hpt
> and the other one soemthing else with a higher rating. If you don't stop
> r4k-hpt interrupts, how does it work ?

    The unwanted events just gets ignored by higher-level code, IIRC... 
Classic PowerPC CPUs have the same problem (even worse, actually) -- one can't 
disable the decrementer interrupt at all.

WBR, Sergei
