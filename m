Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2008 10:04:44 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:62420 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23675272AbYKNKEm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Nov 2008 10:04:42 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 4E5273ECC; Fri, 14 Nov 2008 02:04:37 -0800 (PST)
Message-ID: <491D4D2F.4010802@ru.mvista.com>
Date:	Fri, 14 Nov 2008 13:04:31 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] New IDE/block driver for OCTEON SOC Compact Flash interface.
References: <491C7F28.2070507@caviumnetworks.com>	<491CC0B6.8020400@ru.mvista.com> <20081114011851.1fa01a33@lxorguk.ukuu.org.uk>
In-Reply-To: <20081114011851.1fa01a33@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Alan Cox wrote:

>> OTOH, CF support via self-contained driver is certainly a waste of code 
>> since IDE core and (libata) are here to drive the CF devices as well. 
>> What we need is a "normal" IDE or libata (at your option) driver.
>>     
>
> A libata driver would be nice and probably easiest to do as you don't
> have to pretend to be close to old style taskfile IDE for a PC.
>   

   AFAIU you don't need to pretend that with IDE as well now.

> I am not convinced there is no case for a 'dumb' small CF driver, but if
> so the chipset code and the core code need to be separated as the other
> requests I see for this are different embedded boxes wanting to keep
> codesize down.
>   

  Yeah, that might be worth considering...

> Alan
>   

WBR, Sergei
