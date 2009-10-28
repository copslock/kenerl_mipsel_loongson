Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 04:57:19 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:52754 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491777AbZJ1D5M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Oct 2009 04:57:12 +0100
Received: by pxi26 with SMTP id 26so312573pxi.22
        for <linux-mips@linux-mips.org>; Tue, 27 Oct 2009 20:57:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ZwiTzeT1bT739D7B5Ot0NJHTrAcx5cjEh66QA+8cjjo=;
        b=nGrG3WltPbFuOMSu4ACp/rUDnc+QXe1L7L0pLzPadshS+tXkE9rfv97RJ2IrA5s4n7
         I8Mr4fLqJKorMSECXR9rw1OtrVyTc1KHl4aejfr3upIm9XB5q5uAOUiaj/7WgI1GJEfx
         CZntaCgyBQDFWxYs0qRk91bYkBUMWgvIGjIwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=A1g4Uyps8hGpbTuRFhgACZxIzEZoJxhoq/v1ttaEFKhPs2z+zBVHZaexpqgnCYZhHn
         7zKaJUv3bOxgoO9bAJaQ7myujRFlKsXebFEPmcoq39Tk66/su0HbIpvYz8caGV/674tD
         mG1gW9IqfCKZIH4N8N4cUvJgsbB7ja0QiPWMo=
MIME-Version: 1.0
Received: by 10.143.20.40 with SMTP id x40mr1405150wfi.226.1256702225074; Tue, 
	27 Oct 2009 20:57:05 -0700 (PDT)
In-Reply-To: <3a665c760910270627u784d43b8t2978731110c920a4@mail.gmail.com>
References: <3a665c760910270627u784d43b8t2978731110c920a4@mail.gmail.com>
From:	Mulyadi Santosa <mulyadi.santosa@gmail.com>
Date:	Wed, 28 Oct 2009 10:56:45 +0700
Message-ID: <f284c33d0910272056n4cd082et2ba1a4b5e228bb0e@mail.gmail.com>
Subject: Re: kernel panic about kernel unaligned access
To:	loody <miloody@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	Kernel Newbies <kernelnewbies@nl.linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mulyadi.santosa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mulyadi.santosa@gmail.com
Precedence: bulk
X-list: linux-mips

Hi...

On Tue, Oct 27, 2009 at 8:27 PM, loody <miloody@gmail.com> wrote:
> Dear all:
> I use kernel 2.6.18 and I get the kernel panic as below:
> Unhandled kernel unaligned access[#1]:
> Cpu 0
> $ 0   : 00000000 11000001 0000040a 8721f0d8
> $ 4   : 874a6c00 80001d18 00000000 00000000
> $ 8   : 00000000 ffffa438 00000000 874c2000
> $12   : 00000000 00000000 00005800 00011000
> $16   : 80001d10 874a6c40 874a6c00 87d7bf00
> $20   : 874a6c78 871a0000 87370000 874a6c80
> $24   : 00000000 2aacc770
> $28   : 87d7a000 87d7be88 ffffa438 8709ed20
> Hi    : 00000000
> Lo    : 00000000
> epc   : 8709e72c sync_sb_inodes+0x9c/0x320     Not tainted
> ra    : 8709ed20 writeback_inodes+0xb4/0x160

Hmmm, your machine is not x86, is it? So, I guess this panic is caused
by unaligned memory access.

AFAIK, in certain architecture, accessing memory at address not a
multiple of its word size might cause trap. So, for example if it is a
CPU with 4 byte word size, then accessing memory at 0x00000005 will
cause panic.


> my questions are:
> 1. what does "Not tainted" mean?

AFAIK, it means no non GPL-ed kernel module are currently inserted.

> 2. I grep the kernel and I find the above message comes from do_ade in
> unaligned.c, If I guess correctly.
>    but from the call trace I cannot find out who call it.
>    who and how kernel pass the information to do_ade?

Likely it is part of trap handler.... thus it is installed as interrupt handler.


-- 
regards,

Mulyadi Santosa
Freelance Linux trainer and consultant

blog: the-hydra.blogspot.com
training: mulyaditraining.blogspot.com
