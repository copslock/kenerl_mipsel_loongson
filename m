Received:  by oss.sgi.com id <S553762AbQJXNao>;
	Tue, 24 Oct 2000 06:30:44 -0700
Received: from router.isratech.ro ([193.226.114.69]:57103 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553711AbQJXNaZ>;
	Tue, 24 Oct 2000 06:30:25 -0700
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id e9ODTcZ12857
	for <linux-mips@oss.sgi.com>; Tue, 24 Oct 2000 11:29:41 -0200
Message-ID: <39F5EF83.6AFF6A5D@isratech.ro>
Date:   Tue, 24 Oct 2000 16:22:27 -0400
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Linux Mips kernel!
Content-Type: multipart/mixed;
 boundary="------------F149F4556971E85E03E3B2AB"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------F149F4556971E85E03E3B2AB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

I have the final version of Mips Linux kernel from the CVS site but I do
not manage to compile it.
After make menuconfig , make  dep and make CROSS_COMPILE=mips-linux-   I
get the following error.

 h/mips/kernel/kernel.o: In function `i8259_do_irq':
irq.c(.text.init+0x370): undefined reference to `prom_init'
irq.c(.text.init+0x370): relocation truncated to fit: R_MIPS_26
prom_init
arch/mips/mm/mm.o: In function `free_initmem':
init.c(.text+0x664): undefined reference to `prom_free_prom_memory'
init.c(.text+0x664): relocation truncated to fit: R_MIPS_26
prom_free_prom_memory
arch/mips/mm/mm.o: In function `get_pte_slow':
init.c(.text.init+0x278): undefined reference to `page_is_ram'
init.c(.text.init+0x278): relocation truncated to fit: R_MIPS_26
page_is_ram
arch/mips/mm/mm.o: In function `do_check_pgt_cache':
init.c(.text.init+0x39c): undefined reference to `prom_printf'
init.c(.text.init+0x39c): relocation truncated to fit: R_MIPS_26
prom_printf
make: *** [vmlinux] Error 1

Can anyone help me ?

Regards,
Nicu

--------------F149F4556971E85E03E3B2AB
Content-Type: text/x-vcard; charset=us-ascii;
 name="octavp.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nicu Popovici
Content-Disposition: attachment;
 filename="octavp.vcf"

begin:vcard 
n:POPOVICI;Nicolae Octavian 
tel;cell:+40 93 605020
x-mozilla-html:FALSE
org:SC Silicon Service SRL;Software
adr:;;;;;;
version:2.1
email;internet:octavp@isratech.ro
title:Software engineer
x-mozilla-cpt:;0
fn:Nicolae Octavian POPOVICI
end:vcard

--------------F149F4556971E85E03E3B2AB--
