Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2008 10:35:35 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:38347 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23630505AbYKLKfc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2008 10:35:32 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 07CAF3EC9; Wed, 12 Nov 2008 02:35:28 -0800 (PST)
Message-ID: <491AB16A.3050203@ru.mvista.com>
Date:	Wed, 12 Nov 2008 13:35:22 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Bruno Randolf <bruno.randolf@4g-systems.biz>
Subject: Re: [PATCH 2/3] Alchemy: Move evalboard code to common directory
References: <cover.1226143942.git.mano@roarinelk.homelinux.net>	 <0b1dcd4090411d59e2272ca94da0fb4f5a4bbceb.1226143942.git.mano@roarinelk.homelinux.net>	 <b66aea73a24b5eb990339845892f4a43ccd7efaa.1226143942.git.mano@roarinelk.homelinux.net> <1226462433.9026.12.camel@kh-d820-ubuntu.razamicroelectronics.com>
In-Reply-To: <1226462433.9026.12.camel@kh-d820-ubuntu.razamicroelectronics.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Kevin Hickey wrote:

> And in keeping with my other email, I think that the evalboards
> directory is a good idea (though I would recommend the name
> "develboards" as that is what DB stands for), but it should contain
>   

   I'd prefer devel-boards, or dev-boards.

> subdirectories for each board and a common directory for common DB code.
> Smashing all of the board code into one file doesn't leave any room to
> grow if that file gets too big.

   I doubt that this could be the case here. And I don't think anybody 
has placed limits on the source file size so far.

> Also, a single common.c will not be sufficient in the future.
>   

   Wait, the file only includes prom_init() for now, so might be worth 
renaming it...

> =Kevin
>
> On Sat, 2008-11-08 at 13:08 +0100, Manuel Lauss wrote:
>   
>> Move all code of the Pb/Db boards to a single subdirectory and extract
>> some common code.
>>
>> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>>     

    And now I'll have to give Kevin two lessons of the network etiquette:

- don't top-post (your comments should be below the quoted text you're 
replying to);
- above all, don't leave tens of KBs of uncommented patch behind, do 
spend several seconds to delete it!

WBR, Sergei
