Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 17:58:16 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.204]:64518 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133683AbWAZR56 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 17:57:58 +0000
Received: by zproxy.gmail.com with SMTP id l8so428087nzf
        for <linux-mips@linux-mips.org>; Thu, 26 Jan 2006 10:02:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vi4ET290iaIMDdhvY6s1w/ojaB4tN2LDEUGz8NUyTOB5uvWo99Atg17evW7y1yYyZisYzY0W5SuPaoWjeZsvFdcG5aXKrg2XIsihplaPXY/SOnxNKDsOxw5OqHhXO+fKt40pui6I0yQhWNLyhhmJYsEAb5i7rNO04kYnfwtOImw=
Received: by 10.36.104.15 with SMTP id b15mr1652257nzc;
        Thu, 26 Jan 2006 10:02:29 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Thu, 26 Jan 2006 10:02:29 -0800 (PST)
Message-ID: <cda58cb80601261002w6eb02249k@mail.gmail.com>
Date:	Thu, 26 Jan 2006 19:02:29 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	Nigel Stephens <nigel@mips.com>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <43D8FF16.40107@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <cda58cb80601250632r3e8f7b9en@mail.gmail.com>
	 <20060125150404.GF3454@linux-mips.org>
	 <cda58cb80601251003m6ba4379w@mail.gmail.com>
	 <43D7C050.5090607@mips.com>
	 <cda58cb80601260702wf781e70l@mail.gmail.com>
	 <005101c6228c$6ebfb0a0$10eca8c0@grendel> <43D8F000.9010106@mips.com>
	 <cda58cb80601260831i61167787g@mail.gmail.com>
	 <43D8FF16.40107@mips.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/26, Nigel Stephens <nigel@mips.com>:
>
> Then you'll have to have a look at the resulting disassembled code and
> figure what's changed. :)
>
> Thinking about this in more detail:
>
> 1) Using -march=4ksd reduces the cost of a multiply by 1 instruction
> (from 5 to 4 cycles), so a few more constant multiplications, previously
> expanded into a sequence of shifts, adds and subs, may now be replaced
> by a shorter sequence of "li" and "mul" instructions.
>

Is it really specific to 4ksd cpu ? Could this behaviour be triggered
by other options ?

> 2) Enabling branch-likely may allow some instructions to be moved into a
> branch delay slot which previously couldn't be -- but usually these are
> duplicates of the code at the original branch target, so have little
> effect on overall code size.
>
> 3) Using -march=mips32r2 with -O1 and above (but not -Os) enables 64-bit
> alignment of functions and frequently-used branch targets (e.g. loop
> headers); whereas -march=4ksc will not do that. This will add some
> additional "nops" to the code.
>

I noticed your last point when staring at the disassembled code. And
it seems to be ack by these figures:

   text    data     bss     dec     hex filename
2099642  110784   81956 2292382  22fa9e vmlinux-4ksd
2136269  110784   81956 2329009  2389b1 vmlinux-mips32r2
1953086  110784   81956 2145826  20be22 vmlinux-4ksd-Os
1954489  110784   81956 2147229  20c39d vmlinux-mips32r2-Os

I now have to check that your first and second points don't have too
much bad impact on the overall speed although I don't know how to
measure that...But if so, I could safely use -march=mips32r2 -Os
options.

Thanks
--
               Franck
