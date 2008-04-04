Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2008 15:23:20 +0200 (CEST)
Received: from h155.mvista.com ([63.81.120.155]:41462 "EHLO imap.sh.mvista.com")
	by lappi.linux-mips.net with ESMTP id S527924AbYDDNXK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2008 15:23:10 +0200
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 0B54A3EC9; Fri,  4 Apr 2008 06:22:25 -0700 (PDT)
Message-ID: <47F62B66.6040908@ru.mvista.com>
Date:	Fri, 04 Apr 2008 17:21:42 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] PbAu1200: fix header breakage
References: <200804022353.19379.sshtylyov@ru.mvista.com> <47F4FB9A.6070005@ru.mvista.com> <20080403214316.GC721@linux-mips.org>
In-Reply-To: <20080403214316.GC721@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>   Er, the boards are called Pb1x00, not PbAu1x00, so Ralf please change 
>>the summary before comitting (if you feel inclined :-).
>>   (Luckily, DBAu1200 uses its own header, so it wasn't hurt by this error.)

> Sorry, I already had committed the patch.  I'll fix it up in what I'm
> going to send to Linus though.

    Er, thanks. May I also ask you to pickup the "Make KGDB compile on UP" 
patch which I psted 2 weeks ago? :-)

>   Ralf

WBR, Sergei
