Received:  by oss.sgi.com id <S553767AbQJTHKJ>;
	Fri, 20 Oct 2000 00:10:09 -0700
Received: from router.isratech.ro ([193.226.114.69]:61959 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553751AbQJTHJy>;
	Fri, 20 Oct 2000 00:09:54 -0700
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id e9K79dZ17129
	for <linux-mips@oss.sgi.com>; Fri, 20 Oct 2000 05:09:39 -0200
Message-ID: <39EFEE24.B0A08A8D@isratech.ro>
Date:   Fri, 20 Oct 2000 10:03:00 +0300
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: [Fwd: CrossGcc steps!]
Content-Type: multipart/mixed;
 boundary="------------C79C27A2B80D1E202D3050AA"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------C79C27A2B80D1E202D3050AA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------C79C27A2B80D1E202D3050AA
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <39EF0FE2.1BBD2B63@isratech.ro>
Date: Thu, 19 Oct 2000 18:14:42 +0300
From: Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jbglaw@lug-owl.de
Subject: Re: CrossGcc steps!
References: <20001018171111.H32077@lug-owl.de> <39EE8300.49D8959C@isratech.ro> <20001019081727.A8870@lug-owl.de> <39EE99E6.96E07087@isratech.ro> <20001019094429.A9454@lug-owl.de> <39EEAC8E.B510FFD2@isratech.ro> <20001019103728.B9832@lug-owl.de> <39EEB80A.C0B989F5@isratech.ro> <20001019110946.C9832@lug-owl.de> <39EEC729.2081E422@isratech.ro> <20001019122516.G9832@lug-owl.de>
Content-Type: multipart/mixed;
 boundary="------------12DCACDD8387F5F42A221503"

This is a multi-part message in MIME format.
--------------12DCACDD8387F5F42A221503
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Jan,

Finally I have the CVS linux tree in my directory but now I have another problem. As I said I used
binutils 2.8.1 with patches anf egcs1.0.3a with patches but when I do make clean make dep and make
I get the following error at make:

arch/mips/kernel/kernel.o: In function 'init_IRQ'
irq.c (__ksymtab+0x80) : undefined refernce to 'enable_irq'
irq.c (__ksymtab+0x88) : undefined refernce to 'disable_irq'

arch/mips/kernel/kernel.o: In function 'do_IRQ'
irq.c(.text.init+0x5a8): undefined refernce to 'prom_init'
irq.c(.text.init+0x5a8): relocation truncated to fit : R_MIPS_26 prom_init

arch/mips/mm/mm.o : In function 'free_initmem'
init.c(.text+0x694): undefined refernce to 'prom_free_prom_memory'
init.c(.text+0x694): relocation truncated to fit : R_MIPS_26 prom_free_prom_memory

arch/mips/mm/mm.o : In function 'get_pte_slow'
init.c(.text.init+0x278): undefined reference to 'page_is_ram'
init.c(.text.init+0x278): relocation truncated to fit: R_MIPS_26 page_is_ram

arch/mips/mm/mm.o : In function 'do_check_pgt_cache'
init.c(.text.init+0x39c):undefined refernce to 'prom_printf'
init.c(.text.init+0x39c):relocation truncated to fit : R_MIPS_26 prom_printf

make : *** (vmlinux) Error 1

Can anyone help me with this kind of error ?

What I wanted to ask you is : did you make any particular configuration for this kernel with make
menuconfig ?
Or the problem is not from the CVS kernel ?

Regards,
Nicu


--------------12DCACDD8387F5F42A221503
Content-Type: text/x-vcard; charset=us-ascii;
 name="octavp.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nicu Popovici
Content-Disposition: attachment;
 filename="octavp.vcf"

begin:vcard 
n:Popovici;Nicu
tel;cell:+40 93 605020
x-mozilla-html:FALSE
org:SC Silicon Service SRL;software 
adr:;;;IASI;IASI;6600;ROMANIA
version:2.1
email;internet:octavp@isratech.ro
title:software engineer
x-mozilla-cpt:;0
fn:Nicu Popovici
end:vcard

--------------12DCACDD8387F5F42A221503--


--------------C79C27A2B80D1E202D3050AA
Content-Type: text/x-vcard; charset=us-ascii;
 name="octavp.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nicu Popovici
Content-Disposition: attachment;
 filename="octavp.vcf"

begin:vcard 
n:Popovici;Nicu
tel;cell:+40 93 605020
x-mozilla-html:FALSE
org:SC Silicon Service SRL;software 
adr:;;;IASI;IASI;6600;ROMANIA
version:2.1
email;internet:octavp@isratech.ro
title:software engineer
x-mozilla-cpt:;0
fn:Nicu Popovici
end:vcard

--------------C79C27A2B80D1E202D3050AA--
