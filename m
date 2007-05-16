Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2007 12:06:46 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:6844 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20023255AbXEPLGo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 May 2007 12:06:44 +0100
Received: (qmail 5975 invoked by uid 507); 16 May 2007 19:13:58 +0800
Received: from unknown (HELO ?192.168.1.112?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 16 May 2007 19:13:58 +0800
Message-ID: <464AE59E.2070004@ict.ac.cn>
Date:	Wed, 16 May 2007 19:06:06 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To:	guanzb@lemote.com
CC:	Martin Michlmayr <tbm@cyrius.com>, debian-mips@lists.debian.org,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Several packages whose page size is 4k.
References: <464A7C53.3010309@lemote.com> <464A805C.5020606@ict.ac.cn> <20070516081555.GA22169@networkno.de> <464AC466.4000907@lemote.com> <20070516085737.GD22169@networkno.de> <20070516094617.GJ19816@deprecation.cyrius.com> <464ADF9B.6050602@lemote.com>
In-Reply-To: <464ADF9B.6050602@lemote.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips



Zhibin.Guan 写道:
>  We have already commit kernel patches to linux-mips.
> but, it seems that they have no reaction and response to that.
To be fair, Ralf do response, I remembered that the last question he
asked was related to alsa patches, but we have nobody to handle that.

Maybe that part can be ignored presently and let us make the necessary
parts in first.

What is your opinion, Ralf?
> 
> Martin Michlmayr 写道:
>> * Thiemo Seufer <ths@networkno.de> <mailto:ths@networkno.de> [2007-05-16 09:57]:
>>   
>>> With regard to debian-installer support, this needs a working kernel
>>> in Debian before it can go forward, but you can already file the patch
>>> as a wishlist bug report against the respective package.
>>>     
>> I'm happy to commit patches for debian-installer.  I was planning to
>> add Loongson/Fulong support myself, but I'm currently waiting for the
>> kernel patches to make it into the mainline kernel.
>>   
> 
> -- To UNSUBSCRIBE, email to debian-mips-REQUEST@lists.debian.org with a
> subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
