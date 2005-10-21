Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2005 14:17:09 +0100 (BST)
Received: from baldrick.bootc.net ([83.142.228.48]:61882 "EHLO
	baldrick.bootc.net") by ftp.linux-mips.org with ESMTP
	id S8133440AbVJUNQw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Oct 2005 14:16:52 +0100
Received: from [192.168.1.3] (cpc4-hudd6-3-1-cust172.hudd.cable.ntl.com [82.21.103.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by baldrick.bootc.net (Postfix) with ESMTP id 8E7681400C00;
	Fri, 21 Oct 2005 14:16:50 +0100 (BST)
Message-ID: <4358EA41.4090001@bootc.net>
Date:	Fri, 21 Oct 2005 14:16:49 +0100
From:	Chris Boot <bootc@bootc.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [Slightly-OT] VR4110 core
References: <435818D5.7080807@bootc.net> <Pine.LNX.4.62.0510210958520.32398@numbat.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0510210958520.32398@numbat.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at bootc.plus.com
Return-Path: <bootc@bootc.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bootc@bootc.net
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:
> On Thu, 20 Oct 2005, Chris Boot wrote:
> 
>>I'm in my final year doing a BSc Computing Science degree in the UK, and for
>>my project/dissertation I've chosen to attempt to get Linux to run on an old
>>Sky Digibox (PACE 2500N) set-top-box. So far my research has revealed the CPU
>>has is a NEC VR4110 core with lots of MPEG and graphics processing stuff
> 
>          ^^^^^^^^^^^^^^^^^
> 
>>tacked on. The board itself is quite interesting, with a PC-Card slot, audio
>>out, 2x SCART, RF-out, modem, and serial connection.
> 
> 
> Do you know which SoC is actually used? Perhaps a NEC EMMA or EMMA2?
> 
> Gr{oetje,eeting}s,
> 
> 						Geert

Hi Geert,

Hmm, glancing at the "Product Letter" I have, it does mention "Enhanced 
Multi-Media Architecture" so I'm guessing its an EMMA SoC indeed.

Thanks,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
