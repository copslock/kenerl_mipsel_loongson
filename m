Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 12:08:13 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:24767
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225195AbUJNLIH>; Thu, 14 Oct 2004 12:08:07 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id i9EB7uoJ009332;
	Thu, 14 Oct 2004 04:07:56 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id i9EB7sdd017474;
	Thu, 14 Oct 2004 04:07:55 -0700 (PDT)
Message-ID: <002f01c4b1de$cb80abc0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Fuxin Zhang" <fxzhang@ict.ac.cn>
Cc: <linux-mips@linux-mips.org>
References: <20041014115304.3edbe141.toch@dfpost.ru> <416E3CA4.9080807@ict.ac.cn> <000b01c4b1da$6e049f00$10eca8c0@grendel> <416E5B62.8050508@ict.ac.cn>
Subject: Re: Strange instruction
Date: Thu, 14 Oct 2004 13:13:11 +0200
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Sorry about that disinformation.  The man page doesn't provide
the necessary details - but running "objdump -H" does (and the
-H help option *is* called out in the man page).

----- Original Message ----- 
From: "Fuxin Zhang" <fxzhang@ict.ac.cn>
To: "Kevin D. Kissell" <kevink@mips.com>
Sent: Thursday, October 14, 2004 12:56
Subject: Re: Strange instruction


> 
> 
> Kevin D. Kissell wrote:
> 
> >In all fairness, the syntax is in he "man" page for objdump, so 
> >  
> >
> The man page does mention the option -m
> 
>       -m machine
>       --architecture=machine
>            Specify the architecture to use when  disassembling  object  
> files.
>            This  can  be  useful  when disassembling object files which 
> do not
>            describe architecture information, such as S-records.  You 
> can list
>            the available architectures with the -i option.
>      but it does not mention how to specify a machine, although I did 
> find it in
> objdump --help later:)
> 
> debian GNU objdump 2.14.90.0.7 20031029
> 
> >one doesn't really have to read the sources to figure it out!
> >But the question of whether the default mode of objdump 
> >should be the minimum 32-bit legacy instruction set is a good 
> >one.  Not  many currenly used MIPS processors are MIPS I.  
> >I understand that disassembling advanced instructions that are 
> >not supported by a particular CPU as if they were normal can 
> >cause confusion and error, but perhaps the default would be to 
> >disassmble everything as MIPS64 rev 2, but with all instructions 
> >that are not in MIPS I flagged somehow, perhaps with a message
> >after the assembly code to indicate the extended ISA level?  e.g.
> >
> >a0000650:       07400003        bltz    k0,a0000660 <nmi_handler+0x1c>          
> >a0000654:       03a0d82d        move k1,sp *mips3*
> >a0000658:       3c1ba020        lui     k1,0xa020 
> >
> >Where specifying -m mips:isa64 or -m mips:4000 would suppress the warnings
> >on MIPS64 or MIPS III instructions respectively. Just a thought...
> >
> >----- Original Message ----- 
> >From: "Fuxin Zhang" <fxzhang@ict.ac.cn>
> >To: "Dmitriy Tochansky" <toch@dfpost.ru>
> >Cc: <linux-mips@linux-mips.org>
> >Sent: Thursday, October 14, 2004 10:45
> >Subject: Re: Strange instruction
> >
> >
> >  
> >
> >>objdump -d -mmips:4000 vmlinux to force it regconize all MIPS III 
> >>instructions
> >>
> >>I think this option should be renamed( i had try -mips3 -mmips3 etc. 
> >>before i find it
> >>by reading the source code)
> >> or the default should be changed.
> >>
> >>Dmitriy Tochansky wrote:
> >>
> >>    
> >>
> >>>Hello!
> >>>
> >>>When starts kernel for my au1500 board reseting board. After disassembling I found instruction
> >>>which reseting board. Here is few strings of "mipsel-linux-objdump -D vmlinux" output:
> >>>
> >>>---
> >>>
> >>>a0000650:       07400003        bltz    k0,a0000660 <nmi_handler+0x1c>          
> >>>a0000654:       03a0d82d        0x3a0d82d                                       
> >>>a0000658:       3c1ba020        lui     k1,0xa020 
> >>>
> >>>---
> >>>
> >>>Base address changed by me.
> >>>
> >>>What is A0000654? There is board resets.
> >>>      
> >>>
> >
> >
> >  
> >
> 
