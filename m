Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 15:17:37 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:51405 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039800AbWJJORe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Oct 2006 15:17:34 +0100
Received: from localhost (p3213-ipad213funabasi.chiba.ocn.ne.jp [124.85.68.213])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C960DAB3A; Tue, 10 Oct 2006 23:17:28 +0900 (JST)
Date:	Tue, 10 Oct 2006 23:19:44 +0900 (JST)
Message-Id: <20061010.231944.42203018.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ths@networkno.de, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of
 CPHYSADDR()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <452BA4E7.30901@innova-card.com>
References: <20061009165920.GC18308@networkno.de>
	<20061010.174901.25477190.nemoto@toshiba-tops.co.jp>
	<452BA4E7.30901@innova-card.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 10 Oct 2006 15:49:27 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> heh ? I'm wondering if anybody is using 'CONFIG_BUILD_ELF64=n' config at
> all...

arch/mips/configs/bigsur_defconfig:# CONFIG_BUILD_ELF64 is not set
arch/mips/configs/ip27_defconfig:# CONFIG_BUILD_ELF64 is not set
arch/mips/configs/ip32_defconfig:# CONFIG_BUILD_ELF64 is not set
arch/mips/configs/ocelot_c_defconfig:# CONFIG_BUILD_ELF64 is not set
arch/mips/configs/ocelot_g_defconfig:# CONFIG_BUILD_ELF64 is not set
arch/mips/configs/sb1250-swarm_defconfig:# CONFIG_BUILD_ELF64 is not set

According to arch/mips/configs, nobody is using CONFIG_BUILD_ELF64=y :-)

Also one might use gcc 3.x which ignore -msym32 option ...

> Atsushi, do you have any idea on how address are translated with
> 'CONFIG_BUILD_ELF64=n' config ? How such code is supposed to work ?
> 
> 	code_resource.start = virt_to_phys(&_text);
>  	code_resource.end = virt_to_phys(&_etext) - 1;
> 	data_resource.start = virt_to_phys(&_etext);
>  	data_resource.end = virt_to_phys(&_edata) - 1;
> 
> Let's say that '&_text' is in KSEG0 and is equal to 0xffffffff80000000.
> In this case virt_to_phys() returns 0x57ffffff80000000
> (with PAGE_OFFSET = 0xa800000000000000). Is this physical address
> correct ?

I think this peice of code is just broken, as you said.  This is bogus
but harmless since we have not checked these resources are
successfully registered or not.

---
Atsushi Nemoto
