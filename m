Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2006 14:40:29 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.231]:63741 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038940AbWLMOkZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 13 Dec 2006 14:40:25 +0000
Received: by wr-out-0506.google.com with SMTP id i32so62041wra
        for <linux-mips@linux-mips.org>; Wed, 13 Dec 2006 06:40:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZkXKIFYsC9RR13cjkt2snGqBSJh11khefZ954ceuDZI17ppGwffOrdCnpqCa7MQXgm6Hs4qFNq/tmnlCaB4ahFK/pAcqQtoJhz4zI4428/oqVPbvBG4e1JyXSdX3VxH+TW2BCyoVLBaLXk0bUC0N8/pN8ROCh/Fh+bmbFrf13TU=
Received: by 10.90.52.2 with SMTP id z2mr781362agz.1166020821564;
        Wed, 13 Dec 2006 06:40:21 -0800 (PST)
Received: by 10.90.101.14 with HTTP; Wed, 13 Dec 2006 06:40:21 -0800 (PST)
Message-ID: <b647ffbd0612130640r10bedda5l491679df882fe2e@mail.gmail.com>
Date:	Wed, 13 Dec 2006 15:40:21 +0100
From:	"Dmitry Adamushko" <dmitry.adamushko@gmail.com>
To:	"Thiemo Seufer" <ths@networkno.de>
Subject: Re: unwind_stack() and an exception at the last instruction (after the epilogue)
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20061213135222.GB25904@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b647ffbd0612121342y5b188be0o5ccce1b2c57a9725@mail.gmail.com>
	 <b647ffbd0612130307q4ea221d0l3daf34ef0048abcb@mail.gmail.com>
	 <20061213115438.GA25904@networkno.de>
	 <b647ffbd0612130445r14895d70p4ea313f94dee8b41@mail.gmail.com>
	 <20061213135222.GB25904@networkno.de>
Return-Path: <dmitry.adamushko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.adamushko@gmail.com
Precedence: bulk
X-list: linux-mips

> > gcc version 3.4.2
>
> I figure it doesn't create such an zero access as shown in the example.

the code in question intentionally dereferenced a NULL pointer.

the funny thing is that when it's like this :

void cause_oops(void)
{
        unsigned long *addr = NULL;

        printf("Let's crash...");     // (1)
       *addr = 0;                     // (2)
}

the compiler (-g -Os) generates the code as I have sent before, iow
with "sw zero, 0(zero)" in the delay slot [see, the compiler is kindof
smart as it elimimates a need to store "addr" on stack :]
But if I change the order of (1) and (2), the generated code is different

00401364 <cause_oops>:
  401364:       3c1c0fc0        lui     gp,0xfc0
  401368:       279c6cec        addiu   gp,gp,27884
  40136c:       0399e021        addu    gp,gp,t9
  401370:       8f84801c        lw      a0,-32740(gp)
  401374:       8f9980b0        lw      t9,-32592(gp)
  401378:       ac000000        sw      zero,0(zero)
  40137c:       03200008        jr      t9
  401380:       24842010        addiu   a0,a0,8208

So the "prologue" and "epilogue" are omitted, that's good.

>
> It looks rather broken, given that the stack frame is only used to
> pointlessly push s8 around. The compiler should have optimized it away.

Yes, all the "broken" functions (there are a few in sched.o) have at
least one thing in common - they don't use stack at all, aside of
storing the frame pointer (s8).


> > Are there any configure options that might have caused such a
> > behaviour [hmmm... e.g. gcc was configured with --ignore-abi-rulles :]
> > ? Although, I don't think this would be an option-dependent case.
>
> Well, breakage happens from time to time in gcc. To cover such cases
> it would be nice to have a more robust stack unwinder, but that's easier
> said than done.

Yep, but this would add additional complexity which is not that
necessary for the common path.

e.g. as we know the start and end address of the function
(ksyms_lookup_size_off()), it's possible to find out a position of the
"prologue" and "epilogue" (addiu sp,sp,SIZE - the same way it's done
in get_frame_info()) so we would know:

function_start (1), prologue_addr (2), epilogue_addr (3), function_end (4)

and this would cover the (broken) cases when <epc> is in [1, 2] or [3, 4]
as well as the cases when e.g. <sp> is broken in the prologue ?

Anyway, thanks for the conversation.


>
> Thiemo
>


-- 
Best regards,
Dmitry Adamushko
