Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2009 19:48:24 +0100 (WEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:39281 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024045AbZFJSsR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jun 2009 19:48:17 +0100
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id CB7734C81EE;
	Wed, 10 Jun 2009 20:48:03 +0200 (CEST)
Received: from [192.168.1.189] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 2896F4C81B8;
	Wed, 10 Jun 2009 20:48:00 +0200 (CEST)
Message-ID: <4A2FFFDA.6010807@free.fr>
Date:	Wed, 10 Jun 2009 20:47:54 +0200
From:	matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081204 Iceape/1.1.14 (Debian-1.1.14-1)
MIME-Version: 1.0
To:	Wim Van Sebroeck <wim@iguana.be>
CC:	Florian Fainelli <florian@openwrt.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	biblbroks@sezampro.rs
Subject: Re: add bcm47xx watchdog driver
References: <4A282D98.6020004@free.fr> <20090605124813.d7666ed0.akpm@linux-foundation.org> <4A29805D.60205@free.fr> <200906081615.45889.florian@openwrt.org> <20090610171732.GI16090@infomag.iguana.be>
In-Reply-To: <20090610171732.GI16090@infomag.iguana.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <castet.matthieu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: castet.matthieu@free.fr
Precedence: bulk
X-list: linux-mips

Hi,

Wim Van Sebroeck wrote:
> Hi Matthieu, Florian,
> 
>> It works very well on my Netgear WGT634U, thanks !
>>
>> Tested-by: Florian Fainelli <florian@openwrt.org>
> 
> I incorporated the changes of Andrew and did a clean-up here and there to keep checkpatch happy.
> Could you test the attached diff to see that it still works.
> 
> Thanks,
> Wim.
> 

> +
> +#define WDT_DEFAULT_TIME	30	/* seconds */
> +#define WDT_MAX_TIME		255	/* seconds */
Why have changed this from 256 to 255 ?

> +}
> +
> +static int bcm47xx_wdt_notify_sys(struct notifier_block *this,
> +	nsigned long code, void *unused)
        ^^^^
Does this build ?


Matthieu
