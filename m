Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 09:45:00 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:21952 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S28581446AbYGPIo5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 09:44:57 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 28F24C80EA;
	Wed, 16 Jul 2008 11:44:52 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id KIop1fbaT0Iy; Wed, 16 Jul 2008 11:44:52 +0300 (EEST)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id 0B909C8084;
	Wed, 16 Jul 2008 11:44:52 +0300 (EEST)
Message-ID: <487DB503.10105@movial.fi>
Date:	Wed, 16 Jul 2008 11:44:51 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20080509)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3 part 2] [MIPS] make the pcibios_max_latency	variable
 static
References: <1216141052-28005-2-git-send-email-dmitri.vorobiev@movial.fi> <1216195309-13069-1-git-send-email-dmitri.vorobiev@movial.fi> <20080716084310.GA22957@linux-mips.org>
In-Reply-To: <20080716084310.GA22957@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Jul 16, 2008 at 11:01:49AM +0300, Dmitri Vorobiev wrote:
> 
>> Along with making the pcibios_max_latency variable static,
>> its declaration needs to be removed from the header file.
>>
>> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
>> ---
>>
>> Hi Ralf,
>>
>> Forgot about this one yesterday, sorry.
> 
> No big deal, lmo's internet connection was down for part of the afternoon
> so I wasn't doing as much patch stuff as I was hoping to ...
> 
> I folded part 2 into part 1 of your patch and applied the result.

Thank you, Ralf.

Regards,
Dmitri

> 
> Thanks,
> 
>   Ralf
> 
