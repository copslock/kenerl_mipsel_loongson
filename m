Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 00:30:43 +0000 (GMT)
Received: from mail.gmx.net ([213.165.64.21]:57776 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S8133594AbWASAaX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2006 00:30:23 +0000
Received: (qmail invoked by alias); 19 Jan 2006 00:34:04 -0000
Received: from 5354180C.cable.casema.nl (EHLO [192.168.1.60]) [83.84.24.12]
  by mail.gmx.net (mp015) with SMTP; 19 Jan 2006 01:34:04 +0100
X-Authenticated: #11016536
Message-ID: <43CEDEA9.6030506@gmx.net>
Date:	Thu, 19 Jan 2006 01:34:49 +0100
From:	freshy98 <freshy98@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Cobalt Raq2 HD upgrade - Advice required
References: <43CEB82F.6020009@kilimandjaro.dyndns.org>
In-Reply-To: <43CEB82F.6020009@kilimandjaro.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <freshy98@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freshy98@gmx.net
Precedence: bulk
X-list: linux-mips

Dominique Quatravaux wrote:

>Hi Linux-MIPS gurus,
>
>First, thanks to all involved for your work on the MIPS platform. My
>trusty Cobalt Raq2 in it's colocation farm not too far away boasts 394
>days of uptime tonight, and you are the guys who made it happen.
>
>I'd like to beef up the machine, with more RAM and another HD for
>backups. I found the appropriate Wiki page
>(http://www.linux-mips.org/wiki/Cobalt) and I believe I can deal with
>the RAM part. OTOH as regards the hard drive, the page is a bit evasive:
>exactly what kind of HD can I put there (one for a laptop perhaps)? Will
>I need any duct tape to fasten the second disk? Is there anything
>special I should know about the operation?
>
>Any insight would be greatly appreciated.
>
>  
>
Hello Dominique,

I used to own a RaQ2+ and had two 80GB drives in them.
Works just fine.

All you need is a new IDE cable since the default one only has the 
Master connector and you need the Slave as well.
Apart from that it should be easy.
Oh, you also need a Molex splitter since the default one is only good 
for one drive.

Regards,

Tom
