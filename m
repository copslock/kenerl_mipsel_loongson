Received:  by oss.sgi.com id <S553776AbQJMPUm>;
	Fri, 13 Oct 2000 08:20:42 -0700
Received: from u-239.karlsruhe.ipdial.viaginterkom.de ([62.180.19.239]:53768
        "EHLO u-239.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553773AbQJMPUZ>; Fri, 13 Oct 2000 08:20:25 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870062AbQJML5b>;
        Fri, 13 Oct 2000 13:57:31 +0200
Date:   Fri, 13 Oct 2000 13:57:31 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Cort Dougan <cort@fsmlabs.com>,
        Keith Owens <kaos@melbourne.sgi.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: modutils bug? 'if' clause executes incorrectly
Message-ID: <20001013135731.A30919@bacchus.dhis.org>
References: <20001013022350.J21634@bacchus.dhis.org> <10267.971398664@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <10267.971398664@ocs3.ocs-net>; from kaos@melbourne.sgi.com on Fri, Oct 13, 2000 at 11:57:44AM +1100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Cort,

I think in your module the following jump gets misstreated:

  90:   0800002d        j       b4 <init_module+ac>
                        90: R_MIPS_26   .text

This one is is supposed to skip over the ``printk("A");'' code after
``printk("B");'', so it's the prime suspect.

And this is how current modutils correctly compute such a R_MIPS_26
relocation in obj/obj_mips.c:

      *loc = (*loc & ~0x03ffffff) | ((*loc + (v >> 2)) & 0x03ffffff);

But older modutils - including the modutils-2.1.121-12lm.src.rpm package
from oss - do this:

      *loc = (*loc & ~0x03ffffff) | ((*loc & 0x03ffffff) + (v >> 2));

which is different - and wrong.  This latter expression will for an
assumed load address of 0xc0000000 place 0x3800042d into *loc which
is ``xori $zero, $zero, 0x42d'', in other words a glorified nop resulting
in the printk("A") statement also getting executed.

So the fix should be either upgrading modutils or replacing above
expression in obj/obj_mips.c in your old version of modutils with the
correct one.

  Ralf
