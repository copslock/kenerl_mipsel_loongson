Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 17:02:17 +0200 (CEST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:10962 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133476AbWEaPCJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 May 2006 17:02:09 +0200
Received: (qmail 16092 invoked from network); 31 May 2006 19:10:37 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 31 May 2006 19:10:37 -0000
Message-ID: <447DAFAE.10503@ru.mvista.com>
Date:	Wed, 31 May 2006 19:01:02 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>
CC:	jgarzik@pobox.com, netdev@vger.kernel.org,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: [PATCH] au1000_eth.c Power Management, driver registration and
 module support
References: <20060405154711.GL7029@enneenne.com> <20060405222332.GO7029@enneenne.com> <20060405222620.GP7029@enneenne.com> <4435290C.50607@ru.mvista.com> <20060406155011.GC23424@enneenne.com> <4446857D.90507@ru.mvista.com> <20060502150914.GE20543@gundam.enneenne.com>
In-Reply-To: <20060502150914.GE20543@gundam.enneenne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:

> here:

>    http://ftp.enneenne.com/pub/misc/au1100-patches/linux/patch-au1000_eth-pm-and-registration

> the new version of my patch for au1000_eth.c who should implement:

> Also, as suggested by Sergei it:
> 
> * uses physical addresses and not KSEG1-based virtual anymore and
>   claims/releases the 4-byte MAC enable registers:
> 
>    wwpc:~# cat /proc/iomem
>    10500000-1050ffff : eth-base
>    10520000-10520003 : eth-mac
>       
> * assigns to the Ethernet ports two consecutive MAC addresses:
> 
>    -		dev->dev_addr[4] += 0x10;
>    +				((unsigned long) macen_addr);
>    +		memcpy(ndev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
>    +		ndev->dev_addr[5] += 0x01;
>       
> Ciao,

    Now that this is merged, Rodolfo's patch should probably preempt mine...
but it looks like something was lost during the transition: I failed to see
where SYS_PINFUNC register is actually read (the comment mentioning this was 
retained :-) to check whether Ethernet port 1 is enabled (its pins are shared 
w/GPIO)...

> Rodolfo

WBR, Sergei
