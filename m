Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 16:20:42 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.183]:27881 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20037632AbWIZPUj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Sep 2006 16:20:39 +0100
Received: by py-out-1112.google.com with SMTP id i49so2547161pyi
        for <linux-mips@linux-mips.org>; Tue, 26 Sep 2006 08:20:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        b=e5xLctlAW7jZZdD68pgRg4xExExyztoO5PCXVQ2AtQhHs7LGb51vu/hpPwZfR75upCBU0TEipEpxzQFKmKZ4je/imxW3QAc+gprv0p9zXWH49loagimdEB4Jo7TmY8yIIaCkiwjnyUjunD2Q1Kw+yl3ud1HmslpeEZsG+CLa/mI=
Received: by 10.35.80.20 with SMTP id h20mr1039171pyl;
        Tue, 26 Sep 2006 08:20:38 -0700 (PDT)
Received: from ?192.168.1.3? ( [61.125.212.22])
        by mx.gmail.com with ESMTP id w76sm3340419pyd.2006.09.26.08.20.35;
        Tue, 26 Sep 2006 08:20:37 -0700 (PDT)
User-Agent: Microsoft-Entourage/11.2.1.051004
Date:	Wed, 27 Sep 2006 00:20:30 +0900
Subject: Re: [PATCH] cleanup hardcoding __pa/__va macros etc. (take-2)
From:	girish <girishvg@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	girish <girishvg@gmail.com>
Message-ID: <C13F744E.72CB%girishvg@gmail.com>
Thread-Topic: [PATCH] cleanup hardcoding __pa/__va macros etc. (take-2)
Thread-Index: Acbhf01Di8KIO01yEdulewATIGIqNA==
In-Reply-To: <20060926.180240.109570923.nemoto@toshiba-tops.co.jp>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Return-Path: <girishvg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: girishvg@gmail.com
Precedence: bulk
X-list: linux-mips


>> The idea is to differentiate the Kseg0/Kseg1 segments in the physical area.
>> Beyond these areas lies the mapped area (or the HIGHMEM). What complicates
>> this matter further is their overlapping nature. The __pa()/__va() treated
>> all addresses mapped into PAGE_OFFSET (8000_0000) area. The effort is to
>> correctly differentiate these areas.
> 
> Yes, __va() and __pa() are used to convert an physical address from/to
> an kernel logical address (i.e. low unmapped virtual address).
> 
> I think passing another sort of addresses to them is simply wrong.

Agreed. 

But, then again treating all addresses as above PAGE_OFFSET is also wrong :)
I looked at it just as a work around. These macros are called from so many
other places that if an access is made at say 4000_0000 the kernel will oops
telling it was C000_0000 access error. Now that confused me a lot! With this
change now kernel oops on 4000_0000 :)

Anyway, you may ignore __pa/__va macros.

Could you please look into other changes I proposed?


> 
> P.S.
> Please do not reply to git-commits@linux-mips.org.

I am sorry. It was a stupid mistake in creating address book entry.
