Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 14:42:07 +0100 (BST)
Received: from [85.186.197.132] ([85.186.197.132]:40915 "HELO swpark.galati.ro")
	by ftp.linux-mips.org with SMTP id S20022345AbXIKNl7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2007 14:41:59 +0100
Received: (qmail 6575 invoked by uid 1011); 11 Sep 2007 12:42:07 -0000
Received: from unknown (HELO ?10.95.12.191?) (vlad@comsys.ro@127.0.0.1)
  by swpark.galati.ro with SMTP; 11 Sep 2007 12:42:07 -0000
Message-ID: <46E69AAF.2090509@comsys.ro>
Date:	Tue, 11 Sep 2007 16:39:59 +0300
From:	Vlad Lungu <vlad@comsys.ro>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	qemu-devel@nongnu.org, linux-mips@linux-mips.org
Subject: Re: [Qemu-devel] Qemu and Linux 2.4
References: <46E68AA3.2010907@comsys.ro> <20070911125421.GE10713@networkno.de>
In-Reply-To: <20070911125421.GE10713@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vlad@comsys.ro>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vlad@comsys.ro
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Vlad Lungu wrote:
>> I know some of you will laugh, but:
>>
>> - QEMU malta emulation is not really complete, to put it mildly
> 
> Out of curiosity, what parts did you miss?

Like, for example, the PCI stuff. So I can use the network card.
And yes, I am aware of YAMON.

>> - the QEMU target is available only for Linux 2.6
>> - despite popular opinion, 2.4 ain't dead yet, at least in the embedded 
>> market
>>
>>
>> I have a port of the QEMU target for Linux 2.4.34.4 (latest 2.4 kernel on 
>> linux-mips.org), with NE2000 card working (in both BE and LE modes).
>> Still rough at the edges, but it works on stock qemu-0.9.0 with -M mips.
> 
> I recommend to improve the Qemu Malta emulation, and make it work with
> 2.4 Malta kernels. (ISTR it used to work, so it shouldn't need a lot to
> get there.)

I'm sure that improving the Qemu Malta emulation is a very noble goal, 
but for people that need a working 2.4 kernel NOW, my patch could be 
useful. Having the QEMU target in 2.6 surely helped me.

Vlad
