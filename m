Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2008 12:08:11 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:11475 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S23632605AbYKLMIG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Nov 2008 12:08:06 +0000
Received: (qmail 11715 invoked by uid 1000); 12 Nov 2008 13:05:28 +0100
Date:	Wed, 12 Nov 2008 13:05:28 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Kevin Hickey <khickey@rmicorp.com>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Bruno Randolf <bruno.randolf@4g-systems.biz>
Subject: Re: [PATCH 2/3] Alchemy: Move evalboard code to common directory
Message-ID: <20081112120528.GA11667@roarinelk.homelinux.net>
References: <cover.1226143942.git.mano@roarinelk.homelinux.net> <0b1dcd4090411d59e2272ca94da0fb4f5a4bbceb.1226143942.git.mano@roarinelk.homelinux.net> <b66aea73a24b5eb990339845892f4a43ccd7efaa.1226143942.git.mano@roarinelk.homelinux.net> <1226462433.9026.12.camel@kh-d820-ubuntu.razamicroelectronics.com> <491AB16A.3050203@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <491AB16A.3050203@ru.mvista.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

On Wed, Nov 12, 2008 at 01:35:22PM +0300, Sergei Shtylyov wrote:
> Hello.
>
> Kevin Hickey wrote:
>
>> And in keeping with my other email, I think that the evalboards
>> directory is a good idea (though I would recommend the name
>> "develboards" as that is what DB stands for), but it should contain
>>   
>
>   I'd prefer devel-boards, or dev-boards.

Can we settle on "devboards" without the hyphen?  Everybody okay with that?


>> subdirectories for each board and a common directory for common DB code.
>> Smashing all of the board code into one file doesn't leave any room to
>> grow if that file gets too big.
>
>   I doubt that this could be the case here. And I don't think anybody has 
> placed limits on the source file size so far.
>
>> Also, a single common.c will not be sufficient in the future.
>>   
>
>   Wait, the file only includes prom_init() for now, so might be worth 
> renaming it...

I planned on putting some of the code currently living in common/ into it.
Not a good idea?  Then I'll rename it to prom.c and leave it alone.


Thoughts?

Thanks,
	Manuel Lauss
