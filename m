Received:  by oss.sgi.com id <S553761AbQJMAYT>;
	Thu, 12 Oct 2000 17:24:19 -0700
Received: from u-151.karlsruhe.ipdial.viaginterkom.de ([62.180.18.151]:15368
        "EHLO u-151.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553721AbQJMAYK>; Thu, 12 Oct 2000 17:24:10 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869535AbQJMAXu>;
        Fri, 13 Oct 2000 02:23:50 +0200
Date:   Fri, 13 Oct 2000 02:23:50 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith Owens <kaos@melbourne.sgi.com>
Cc:     Cort Dougan <cort@fsmlabs.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: modutils bug? 'if' clause executes incorrectly
Message-ID: <20001013022350.J21634@bacchus.dhis.org>
References: <20001011171449.A19344@bacchus.dhis.org> <3897.971317531@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3897.971317531@kao2.melbourne.sgi.com>; from kaos@melbourne.sgi.com on Thu, Oct 12, 2000 at 01:25:31PM +1100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Oct 12, 2000 at 01:25:31PM +1100, Keith Owens wrote:

> Ralf Baechle <ralf@oss.sgi.com> wrote:
> >For such occassions I would like to see some debugging functionality in
> >modutils which allows dumping the relocated disk image as it would be
> >loaded into the kernel into a disk image which then could be examined
> >with objdump etc. for potencial problems.
> 
> By the time insmod has finished with the module, the rest is a binary
> blob.  No ELF headers, no symbols, all the sections run together with a
> struct module at the start.  I can dump that easily enough but I
> question how much use it would be.  Outputing anything more complicated
> such as ELF headers and symbols would be a significant addition to
> insmod.

The blob is actually already ok and just what I wanted.  You can easily talk
objdump into disassembling that easily.  All that is required in addition
is the base address of the blob as the argument of the --adjust-vma option.

[ralf@lappi ralf]$ mips-linux-objdump -b binary -m mips --adjust-vma 0xc0000000 -D /etc/group | head

/etc/group:     file format binary

No symbols in "/etc/group".
Disassembly of section .data:

00000000c0000000 <.data>:
    c0000000:	726f6f74 	jalx	c1bdbdc8
    c0000004:	3a3a303a 	xori	$s0,$s1,0x3a3a
    c0000008:	726f6f74 	jalx	c1bdbdc8

  Ralf
