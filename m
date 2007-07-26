Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2007 05:48:54 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:30618 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20021370AbXGZEsv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Jul 2007 05:48:51 +0100
Received: (qmail 29380 invoked by uid 507); 26 Jul 2007 13:30:43 +0800
Received: from unknown (HELO ?127.0.0.1?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 26 Jul 2007 13:30:43 +0800
Message-ID: <46A827A0.70304@ict.ac.cn>
Date:	Thu, 26 Jul 2007 12:48:32 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 2.0.0.5 (Windows/20070716)
MIME-Version: 1.0
To:	Dajie Tan <jiankemeng@gmail.com>
CC:	John Levon <levon@movementarian.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>, phil.el@wanadoo.fr,
	oprofile-list@lists.sourceforge.net
Subject: Re: [PATCH] Add support for profiling Loongson 2E
References: <5861a7880707240220g5d8129anc95e10bea833e323@mail.gmail.com>	 <20070724144051.GA17256@linux-mips.org>	 <5861a7880707242041w32811dal6e2765747cbada32@mail.gmail.com>	 <20070725125235.GD8454@totally.trollied.org.uk> <5861a7880707251814q4b6876a1u4291d068e201488c@mail.gmail.com>
In-Reply-To: <5861a7880707251814q4b6876a1u4291d068e201488c@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips



Dajie Tan 写道:
>> > Yeah,this change is to enhance the robust of oprofile. When using
>> > performace counter manually(writting control register in a module, no
>> > need to use the oprofile),I usually make kernel panic if I do not
>> > initialize the oprofile and enable the overflow interrupt carelessly.
>> > So, this change can avoid this panic. :D
>>
>> This panic is good and should stay. It shows that you've made a mistake.
>>
>> john
>>
>
> This panic is caused by accessing a null pointer.Do you think that
> accessing a null
> pointer is allowed in a robust system ?
I think you don't really understand Ralf and John's responses. The 
problem should not be workarounded in that position.
Your code should ensure that overflow interrupt will not be enabled when 
oprofile is not enabled, or something like this. If everyone choose to 
'fix' problems via patching generic code, it would be a maintainence 
headache. Why other platform s won't have your problem?

It is not to say that the panic is ok, but it is your problem if others 
are not suffering the same panic, and should be fixed in your code.
>
>
>
>

-- 
------------------------------------------------
Fuxin Zhang

Vice Researcher
Microprocessor Research Center, Institute of Computing Technolgy
Chiese Academy of China
Beijing, 100080
Email: fxzhang@ict.ac.cn
http://www.ict.ac.cn

------------------------------------------------
 
