Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Oct 2005 15:50:45 +0100 (BST)
Received: from baldrick.bootc.net ([83.142.228.48]:17802 "EHLO
	baldrick.bootc.net") by ftp.linux-mips.org with ESMTP
	id S3465618AbVJVOu2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Oct 2005 15:50:28 +0100
Received: from [192.168.1.3] (cpc4-hudd6-3-1-cust172.hudd.cable.ntl.com [82.21.103.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by baldrick.bootc.net (Postfix) with ESMTP id 0EF0C1400C00;
	Sat, 22 Oct 2005 15:50:18 +0100 (BST)
Message-ID: <435A51A8.9030602@bootc.net>
Date:	Sat, 22 Oct 2005 15:50:16 +0100
From:	Chris Boot <bootc@bootc.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [Slightly-OT] VR4110 core
References: <435818D5.7080807@bootc.net> <Pine.LNX.4.62.0510210958520.32398@numbat.sonytel.be> <4358EA41.4090001@bootc.net> <Pine.LNX.4.62.0510211536380.32398@numbat.sonytel.be> <4358F910.2020204@bootc.net> <Pine.LNX.4.62.0510212038220.9129@numbat.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0510212038220.9129@numbat.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at bootc.plus.com
Return-Path: <bootc@bootc.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bootc@bootc.net
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:
> On Fri, 21 Oct 2005, Chris Boot wrote:
> 
>>Geert Uytterhoeven wrote:
>>
>>>On Fri, 21 Oct 2005, Chris Boot wrote:
>>>
>>>>Hmm, glancing at the "Product Letter" I have, it does mention "Enhanced
>>>>Multi-Media Architecture" so I'm guessing its an EMMA SoC indeed.
>>>
>>>Do you have to part number?
>>
>>Did I not send one?! It must have been late...
>>
>>It's a uPD61032, marked D61032GL on the chip. The exact markings are:
>>NEC JAPAN
>>D61032GL
>>9949EK019
> 
> 
> That's indeed the EMMA.

Now we know what it is...where do I find the docs?

>>There's a couple of 2MB SDRAM chips just next to the CPU (both from different
>>manufacturers, and with different pinouts, interestingly enough), 2 Amtel 2MB
> 
> 
> IIRC, there's a separate 2 MiB SDRAM for MPEG decoding.

That would explain it, I guess. What that means is I have all of 2MB to 
play with then :-(

> Gr{oetje,eeting}s,
> 
> 						Geert

Cheers,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
