Received:  by oss.sgi.com id <S553777AbQJMPoV>;
	Fri, 13 Oct 2000 08:44:21 -0700
Received: from ppp0.ocs.com.au ([203.34.97.3]:43526 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S553779AbQJMPoG>;
	Fri, 13 Oct 2000 08:44:06 -0700
Received: (qmail 14246 invoked from network); 13 Oct 2000 15:44:00 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 13 Oct 2000 15:43:59 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Cort Dougan <cort@fsmlabs.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: modutils bug? 'if' clause executes incorrectly 
In-reply-to: Your message of "Fri, 13 Oct 2000 13:57:31 +0200."
             <20001013135731.A30919@bacchus.dhis.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sat, 14 Oct 2000 02:43:59 +1100
Message-ID: <18457.971451839@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 13 Oct 2000 13:57:31 +0200, 
Ralf Baechle <ralf@oss.sgi.com> wrote:
>I think in your module the following jump gets misstreated:
>
>  90:   0800002d        j       b4 <init_module+ac>
>                        90: R_MIPS_26   .text
>
>But older modutils - including the modutils-2.1.121-12lm.src.rpm package
>from oss - do this:
>
>      *loc = (*loc & ~0x03ffffff) | ((*loc & 0x03ffffff) + (v >> 2));
>
>which is different - and wrong.

Would that be this entry in the change log from 1998?

Tue Nov  3 22:26:18 MET 1998  Ralf Baechle  <ralf@gnu.org>

        * obj/obj_mips.c (arch_apply_relocation): Fix application of R_MIPS_26
        relocations.

Thanks for tracking the problem down.  I really, *really* want to kill
people using modutils 2.1.121 on current kernels.
