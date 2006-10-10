Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 14:48:23 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:11364 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039871AbWJJNsV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Oct 2006 14:48:21 +0100
Received: by nf-out-0910.google.com with SMTP id n29so281833nfc
        for <linux-mips@linux-mips.org>; Tue, 10 Oct 2006 06:48:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=YjULFD4IURTJPzO3ieMUL/MS0Jpw7vzqfU7cEJQg/+4FD5PVkCi6Nw2J3uLZ58q5NTF5kxXqFHSmWEqM7DyTv3XLDILtVhrvmSvbinuq6usRxDwK/8Bo5QHVDqi+MBqj0DGP+h7gZ03C2FHjr7neX7vIjWJLZYVfZ9JnoY74gZ4=
Received: by 10.49.20.5 with SMTP id x5mr1457638nfi;
        Tue, 10 Oct 2006 06:48:19 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id h1sm1957236nfe.2006.10.10.06.48.19;
        Tue, 10 Oct 2006 06:48:19 -0700 (PDT)
Message-ID: <452BA4E7.30901@innova-card.com>
Date:	Tue, 10 Oct 2006 15:49:27 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	ths@networkno.de, vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of CPHYSADDR()
References: <20061009145817.GB18308@networkno.de>	<20061010.005142.03977034.anemo@mba.ocn.ne.jp>	<20061009165920.GC18308@networkno.de> <20061010.174901.25477190.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061010.174901.25477190.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 9 Oct 2006 17:59:20 +0100, Thiemo Seufer <ths@networkno.de> wrote:
>>> Just for clarification: IIRC this optimization needs somewhat
>>> up-to-date binutils/gcc and is not enabled on current lmo kernel,
>>> right?
>> For old toolchains there used to be a gruesome hack (which AFAIR broke
>> at some point), for modern toolchains there's -msym32.
> 
> Hmm, I found that the -msym32 is enabled if BUILD_ELF64 was not
> selected, since 2.6.17.  But does CONFIG_BUILD_ELF64=n really work for
> modules?  While MAP_BASE is 0xc000000000000000 for most 64-bit
> platforms, I suppose modules should not be compiled with -msym32.
> 

heh ? I'm wondering if anybody is using 'CONFIG_BUILD_ELF64=n' config at
all...

Atsushi, do you have any idea on how address are translated with
'CONFIG_BUILD_ELF64=n' config ? How such code is supposed to work ?

	code_resource.start = virt_to_phys(&_text);
 	code_resource.end = virt_to_phys(&_etext) - 1;
	data_resource.start = virt_to_phys(&_etext);
 	data_resource.end = virt_to_phys(&_edata) - 1;

Let's say that '&_text' is in KSEG0 and is equal to 0xffffffff80000000.
In this case virt_to_phys() returns 0x57ffffff80000000
(with PAGE_OFFSET = 0xa800000000000000). Is this physical address
correct ?

Thanks
		Franck
