Received:  by oss.sgi.com id <S553801AbQKWQZ4>;
	Thu, 23 Nov 2000 08:25:56 -0800
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:13064 "EHLO
        proteus.paralogos.com") by oss.sgi.com with ESMTP
	id <S553793AbQKWQZa>; Thu, 23 Nov 2000 08:25:30 -0800
Received: from Ulysses ([195.154.177.178])
	by proteus.paralogos.com (8.9.3/8.9.3) with SMTP id RAA06892;
	Thu, 23 Nov 2000 17:14:46 +0100
Message-ID: <009d01c0556a$74eda6c0$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@paralogos.com>
To:     "Dan Aizenstros" <dan@vcubed.com>, <linux-mips@oss.sgi.com>
References: <3A1D3DA1.E982879B@vcubed.com>
Subject: Re: Strange messages.
Date:   Thu, 23 Nov 2000 17:28:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This really deserves to be in the  FAQ.  I guess
I ought to put a version of this up an a web site
somewhere and just point people to the URL:
Either Ralf or I end up answering it about
once a month.  

This message occurs when the kernel gets an 
"unimplemented operation" trap from the FPU, 
which means that an FP instruction has been issued
that the hardware cannot handle on its own.  Usually
this is a conversion of an extreme value or an operation 
on a denormalized value. What the OS is supposed 
to do in this case is to deal with the situation, by killing
the process, fixing up the values, or emulating
the instruction in software.

Setting flush-denormal-to-zero mode of the FPU
and replaying the instruction to see if that helps
is a slightly shady (in my opinion) hack that Ralf put in 
as part of a tiny, minimal emulator that handled these 
exceptions in some versions of MIPS Linux.  MIPS later
integrated a full IEEE FPU emulator from Algorithmics
into the 2.2.12 kernel, but it hasn't yet gone into
the 2.3/2.4 repository.

So long as all you got was that message, and
awk didn't subsequently dump core, you're probably
OK.  Just don't do any serious numerical programming
on the system until the full IEEE support goes in!

            Kevin K.

----- Original Message ----- 
From: "Dan Aizenstros" <dan@vcubed.com>
To: <linux-mips@oss.sgi.com>
Sent: Thursday, November 23, 2000 4:54 PM
Subject: Strange messages.


> Hello All,
> 
> Recently I upgraded my Linux/MIPS kernel from 2.2.12 to 
> 2.4.0-test9 and I started getting messages like the following:
> 
> Setting flush to zero for awk.
> 
> I did not get this message when using a 2.2.12 kernel but I am
> getting them with a 2.4.0-test9 kernel.
> 
> The 2.4.0-test9 kernel is based on the code from the snapshot
> at oss.sgi.com in the following file,
> /pub/linux/mips/mips-linux/simple/crossdev/src/linux-001027.tar.gz
> with the patches from the same directory applied.
> 
> I get the message many times and for different programs during
> system startup.
> 
> Has anyone seen this before?
> 
> Dan Aizenstros
> Software Engineer
> V3 Semiconductor Corp.
> 
