Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jul 2006 11:47:06 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.169]:28477 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133420AbWGEKqy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Jul 2006 11:46:54 +0100
Received: by ug-out-1314.google.com with SMTP id u2so2130466uge
        for <linux-mips@linux-mips.org>; Wed, 05 Jul 2006 03:46:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=pAsQO6hMToatk4RsuTtY79w9YGYOJ1KFuZbr7YGIecGE1zn4GanhM9hSg3wxuz7xiqEZ9d8hiJnYN1aGD9S3ILFYCdH4bpjeMbkIa+nzFodaQ2dpVayO9OXYaBKU2BVsiXWGiO4E2QBfSVJr3Agnb4Qr8plrQw+t1l8vtlHz4y8=
Received: by 10.78.166.7 with SMTP id o7mr1965413hue;
        Wed, 05 Jul 2006 03:46:48 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id 28sm1992590hua.2006.07.05.03.46.44;
        Wed, 05 Jul 2006 03:46:48 -0700 (PDT)
Message-ID: <44AB99AD.8000403@innova-card.com>
Date:	Wed, 05 Jul 2006 12:51:25 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] sparsemem fix
References: <20060705.012244.96686002.anemo@mba.ocn.ne.jp>	<44AB79D0.90002@innova-card.com> <20060705.192054.128618288.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060705.192054.128618288.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 05 Jul 2006 10:35:28 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>>  #elif defined(CONFIG_NEED_MULTIPLE_NODES)
>> why not using:
>>
>> #elif defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_NUMA)
>>
>> hence, we would have all memory model cases.
> 
> While NEED_MULTIPLE_NODES is defined if DISCONTIGMEM || NUMA, it seems
> no difference.
> 

well, in the previous case the reader sees a case for _all_ memory models.
In your case the reader needs to know that NEED_MULTIPLE_NODES is defined
as (DISCONTIGMEM || NUMA).

>> For now it seems to be implemented only in sgi-ip27 machine. Maybe we should
>> make things clear by adding:
>>
>> #ifdef CONFIG_SGI_IP27
>> #define pfn_valid	[...]
>> #else
>> #error discontigmem model is only supported by sgi-ip27 platforms.
>> #error Please try to implement a generic solution if you plan to
>> #error use this memory model. Good luck ;)
>> #endif /* CONFIG_SGI_IP27 */
> 
> Though the pfn_valid() is only used by ip27 for now, I suppose it
> could be used other NUMA systems (not sure).
> 

no the code related to NUMA is embedded in ip27 directory. So if
someone has another NUMA system, she should (a) copy all the stuff
in its platform directory or (b) make a generic solution maybe based
on ip27 one for all others NUMA platforms.  But in the second case,
the NUMA implementation is going to be modified heavily (a guess)
and probably same for pfn_valid definition.

The previous change makes things clear: for now, you can't use
pfn_valid when NUMA or DISCONTIGMEM configs without some reworks.


		Franck
