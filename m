Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jul 2005 13:53:50 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:3973 "EHLO
	mx01.qsc.de") by linux-mips.org with ESMTP id <S8224931AbVGTMxQ>;
	Wed, 20 Jul 2005 13:53:16 +0100
Received: from port-195-158-170-19.dynamic.qsc.de ([195.158.170.19] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1DvE5z-0003OZ-00; Wed, 20 Jul 2005 14:54:43 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1DvE5z-0004H2-8T; Wed, 20 Jul 2005 14:54:43 +0200
Date:	Wed, 20 Jul 2005 14:54:43 +0200
To:	Alexander Voropay <alec@artcoms.ru>
Cc:	Kishore K <hellokishore@gmail.com>, linux-mips@linux-mips.org
Subject: Re: bal instruction in gcc 3.x
Message-ID: <20050720125442.GK2071@hattusa.textio>
References: <f07e6e05071909301c212ab4@mail.gmail.com> <20050719164427.GB8758@linux-mips.org> <f07e6e05071910194bab9b16@mail.gmail.com> <1121802786.7285.88.camel@localhost.localdomain> <Pine.LNX.4.61L.0507200955390.30702@blysk.ds.pg.gda.pl> <f07e6e05072002197b529b72@mail.gmail.com> <010901c58d28$15e2a3b0$6cf9a8c0@ALEC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010901c58d28$15e2a3b0$6cf9a8c0@ALEC>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Alexander Voropay wrote:
> <hellokishore@gmail.com> wrote:
> 
> >>>However, if I compile the code with gcc3, it exits with the
> >>>error "Cannot branch to unknown symbol".
> 
> >On the other hand, if I replace 
> >
> >bal jump_to_label   
> >
> >by 
> >
> >la t9, jump_to_label
> >jalr t9
> >
> >I don't see any warning. What could be the reason ?
> 
> 
> 1) With "jal label " you'll have a MIPS_26 RELOC type in the ELF obj file:
> 
>  jal  lablel
> 
> 00000000 <.text>:
>   0:   0c000000        jal     0x0
>   4:   00000000        nop
> 
> RELOCATION RECORDS FOR [.text]:
> OFFSET   TYPE              VALUE
> 00000000 R_MIPS_26         label
> 
> 
> 2) The "la r,label" is a syntetic inctruction wich expanded into two:
> "lui r,%hi label  ; addui r,%lo label". It gives you two RELOCs:
> 
>  la  t0, label
>  jalr t0
> 
> 00000000 <.text>:
>   0:   3c080000        lui     t0,0x0
>   4:   25080000        addiu   t0,t0,0
>   8:   0100f809        jalr    t0
>   c:   00000000        nop
> 
> RELOCATION RECORDS FOR [.text]:
> OFFSET   TYPE              VALUE
> 00000000 R_MIPS_HI16       label
> 00000004 R_MIPS_LO16       label
> 
> 3) AFAIK (correct me), there is no MIPS-specific RELOC type for
> the "branch"  instruction format in the BFD, so "bal" to the *external*
> symbols is impossible.

There is R_MIPS_PC16 which was ill-defined (missing rightshift for the
immediate) in the old ELF spec and thus unused.

> May be, old gas generates something like RELOC_PCREL
> for "bal external" ?

Old gas/ld used R_MIPS_PC16 without reasonable range checking, IOW it
broke silently for branch spans greater than +-32k.

Implementing external branches for gas/ld with the correct R_MIPS_PC16
definition is somewhere on my TODO list but is unlikely to get priority
any time soon.


Thiemo
