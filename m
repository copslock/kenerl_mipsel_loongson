Received:  by oss.sgi.com id <S553794AbQJMRlM>;
	Fri, 13 Oct 2000 10:41:12 -0700
Received: from u-113.karlsruhe.ipdial.viaginterkom.de ([62.180.19.113]:521
        "EHLO u-113.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553791AbQJMRkx>; Fri, 13 Oct 2000 10:40:53 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868830AbQJMRkb>;
        Fri, 13 Oct 2000 19:40:31 +0200
Date:   Fri, 13 Oct 2000 19:40:31 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith Owens <kaos@melbourne.sgi.com>
Cc:     Cort Dougan <cort@fsmlabs.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: modutils bug? 'if' clause executes incorrectly
Message-ID: <20001013194031.D31641@bacchus.dhis.org>
References: <20001013135731.A30919@bacchus.dhis.org> <18457.971451839@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <18457.971451839@ocs3.ocs-net>; from kaos@melbourne.sgi.com on Sat, Oct 14, 2000 at 02:43:59AM +1100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 14, 2000 at 02:43:59AM +1100, Keith Owens wrote:

> Would that be this entry in the change log from 1998?
> 
> Tue Nov  3 22:26:18 MET 1998  Ralf Baechle  <ralf@gnu.org>
> 
>         * obj/obj_mips.c (arch_apply_relocation): Fix application of R_MIPS_26
>         relocations.
> 
> Thanks for tracking the problem down.  I really, *really* want to kill
> people using modutils 2.1.121 on current kernels.

Now that explains the deja vue I had when I found this one ...

I'm not using modules at all which why I still have such vintage modutils
around ...

  Ralf
