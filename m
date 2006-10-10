Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 16:00:51 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:13236 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039883AbWJJPAt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Oct 2006 16:00:49 +0100
Received: by nf-out-0910.google.com with SMTP id n29so299872nfc
        for <linux-mips@linux-mips.org>; Tue, 10 Oct 2006 08:00:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=h2COUBzSC6Zs6LJaOA/r4Q8i5++p752GwoNxSODUp4MekRFBQ+2+QHI4jpS+kNCU4z4SXltsl+LsQac0tuMqk/2VVum/UCI/Laj0M3XW3SPfnqUbb+rJYyX6ZnlvQ/WwFwqQIgaB1SpqJOb9gKX6eyQGKUMgpiAW8bwiGWUzUoI=
Received: by 10.49.93.13 with SMTP id v13mr1561895nfl;
        Tue, 10 Oct 2006 08:00:45 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id x27sm2091322nfb.2006.10.10.08.00.44;
        Tue, 10 Oct 2006 08:00:44 -0700 (PDT)
Message-ID: <452BB5E1.5090308@innova-card.com>
Date:	Tue, 10 Oct 2006 17:01:53 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ths@networkno.de, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of CPHYSADDR()
References: <20061009165920.GC18308@networkno.de>	<20061010.174901.25477190.nemoto@toshiba-tops.co.jp>	<452BA4E7.30901@innova-card.com> <20061010.231944.42203018.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061010.231944.42203018.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Tue, 10 Oct 2006 15:49:27 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> heh ? I'm wondering if anybody is using 'CONFIG_BUILD_ELF64=n' config at
>> all...
> 
> arch/mips/configs/bigsur_defconfig:# CONFIG_BUILD_ELF64 is not set
> arch/mips/configs/ip27_defconfig:# CONFIG_BUILD_ELF64 is not set
> arch/mips/configs/ip32_defconfig:# CONFIG_BUILD_ELF64 is not set
> arch/mips/configs/ocelot_c_defconfig:# CONFIG_BUILD_ELF64 is not set
> arch/mips/configs/ocelot_g_defconfig:# CONFIG_BUILD_ELF64 is not set
> arch/mips/configs/sb1250-swarm_defconfig:# CONFIG_BUILD_ELF64 is not set
> 
> According to arch/mips/configs, nobody is using CONFIG_BUILD_ELF64=y :-)
> 
> Also one might use gcc 3.x which ignore -msym32 option ...
> 

yeah, that's probably the reason...

>> Atsushi, do you have any idea on how address are translated with
>> 'CONFIG_BUILD_ELF64=n' config ? How such code is supposed to work ?
>>
>> 	code_resource.start = virt_to_phys(&_text);
>>  	code_resource.end = virt_to_phys(&_etext) - 1;
>> 	data_resource.start = virt_to_phys(&_etext);
>>  	data_resource.end = virt_to_phys(&_edata) - 1;
>>
>> Let's say that '&_text' is in KSEG0 and is equal to 0xffffffff80000000.
>> In this case virt_to_phys() returns 0x57ffffff80000000
>> (with PAGE_OFFSET = 0xa800000000000000). Is this physical address
>> correct ?
> 
> I think this peice of code is just broken, as you said.  This is bogus
> but harmless since we have not checked these resources are
> successfully registered or not.
> 

what about all other uses of virt_to_phys(x) ? And what the point to set
PAGE_OFFSET to 0xa800000000000000 ? I'm really confused...

		Franck
