Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jul 2005 13:38:12 +0100 (BST)
Received: from mail.spb.artcoms.ru ([IPv6:::ffff:82.114.120.253]:43426 "EHLO
	mrelay.spb.artcoms.ru") by linux-mips.org with ESMTP
	id <S8224917AbVGTMhv>; Wed, 20 Jul 2005 13:37:51 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mrelay.spb.artcoms.ru (Postfix) with ESMTP
	id 420FB132F6; Wed, 20 Jul 2005 16:39:40 +0400 (MSD)
Received: from mrelay.spb.artcoms.ru ([127.0.0.1])
 by localhost (megera.artcoms.ru [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21547-03; Wed, 20 Jul 2005 16:39:40 +0400 (MSD)
Received: from ALEC (unknown [192.168.249.108])
	by mrelay.spb.artcoms.ru (Postfix) with SMTP
	id EE4CC132EF; Wed, 20 Jul 2005 16:39:39 +0400 (MSD)
Message-ID: <010901c58d28$15e2a3b0$6cf9a8c0@ALEC>
Reply-To: "Alexander Voropay" <alec@artcoms.ru>
From:	"Alexander Voropay" <alec@artcoms.ru>
To:	"Kishore K" <hellokishore@gmail.com>
Cc:	<linux-mips@linux-mips.org>
References: <f07e6e05071909301c212ab4@mail.gmail.com> <20050719164427.GB8758@linux-mips.org> <f07e6e05071910194bab9b16@mail.gmail.com> <1121802786.7285.88.camel@localhost.localdomain> <Pine.LNX.4.61L.0507200955390.30702@blysk.ds.pg.gda.pl> <f07e6e05072002197b529b72@mail.gmail.com>
Subject: Re: bal instruction in gcc 3.x
Date:	Wed, 20 Jul 2005 16:39:31 +0400
Organization: Art Communications
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Virus-Scanned: by amavisd-new at spb.artcoms.ru
Return-Path: <alec@artcoms.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alec@artcoms.ru
Precedence: bulk
X-list: linux-mips

<hellokishore@gmail.com> wrote:

>>> However, if I compile the code with gcc3, it exits with the
>>>error "Cannot branch to unknown symbol".

> On the other hand, if I replace 
> 
> bal jump_to_label   
> 
> by 
> 
> la t9, jump_to_label
> jalr t9
> 
> I don't see any warning. What could be the reason ?


1) With "jal label " you'll have a MIPS_26 RELOC type in the ELF obj file:

  jal  lablel

00000000 <.text>:
   0:   0c000000        jal     0x0
   4:   00000000        nop

RELOCATION RECORDS FOR [.text]:
OFFSET   TYPE              VALUE
00000000 R_MIPS_26         label


2) The "la r,label" is a syntetic inctruction wich expanded into two:
"lui r,%hi label  ; addui r,%lo label". It gives you two RELOCs:

  la  t0, label
  jalr t0

00000000 <.text>:
   0:   3c080000        lui     t0,0x0
   4:   25080000        addiu   t0,t0,0
   8:   0100f809        jalr    t0
   c:   00000000        nop

RELOCATION RECORDS FOR [.text]:
OFFSET   TYPE              VALUE
00000000 R_MIPS_HI16       label
00000004 R_MIPS_LO16       label

3) AFAIK (correct me), there is no MIPS-specific RELOC type for
the "branch"  instruction format in the BFD, so "bal" to the *external*
symbols is impossible.

May be, old gas generates something like RELOC_PCREL
for "bal external" ?


--
-=AV=-
