Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 17:44:28 +0100 (CET)
Received: from mail-fx0-f211.google.com ([209.85.220.211]:50775 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492995AbZKFQoV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Nov 2009 17:44:21 +0100
Received: by fxm3 with SMTP id 3so286089fxm.24
        for <linux-mips@linux-mips.org>; Fri, 06 Nov 2009 08:44:15 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ViQvux9M1cFrU4WYSZSmelpZp6Fuv0EVhsspoBrcGuQ=;
        b=vLPaUlcUmsULmgSiqoaMD4Y1TMjXOPF/xcF6AXRvqSHm1FnHjaSVKWfE2tDDwh7uxZ
         AdC5Ka0GUr9zYQEi7qTnzz1VCbfYcfw6o/NLimrYzR7m42Uncmj9kiJdIyDnoj/kF9lU
         mpgHxykxOwcdwZbff2CthxMeBfVwmFfHz2VBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UrQRpQhExG+p7eursXUuEZDxBAHQoPrr6Kk4mV3MJxH933caJZ4qfTmA5ady5Y7x29
         ChEYWpmqSHO8EKe+wltB32JmUb+Po182bkwGcPfyQkdgoJdGAifOHyD2YTBr+q6Vlw0J
         niTdQjmuD0h3lqt/B9Ei0h37BRwXkfy6j2UkQ=
MIME-Version: 1.0
Received: by 10.223.21.3 with SMTP id h3mr662205fab.39.1257525855218; Fri, 06 
	Nov 2009 08:44:15 -0800 (PST)
In-Reply-To: <90edad820911060834t5c14aa30t847c3b75bf7e36e@mail.gmail.com>
References: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>
	 <90edad820911060822g40233a8ft28001d68186b989e@mail.gmail.com>
	 <90edad820911060834t5c14aa30t847c3b75bf7e36e@mail.gmail.com>
Date:	Fri, 6 Nov 2009 18:44:15 +0200
Message-ID: <90edad820911060844n14f12301jbaa63c2d62d23f92@mail.gmail.com>
Subject: Re: COMMAND_LINE_SIZE and CONFIG_FRAME_WARN
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Nov 6, 2009 at 6:34 PM, Dmitri Vorobiev
<dmitri.vorobiev@gmail.com> wrote:
> On Fri, Nov 6, 2009 at 6:22 PM, Dmitri Vorobiev
> <dmitri.vorobiev@gmail.com> wrote:
>> On Fri, Nov 6, 2009 at 6:08 PM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>>> Recently COMMAND_LINE_SIZE (CL_SIZE) was extended to 4096 from 512.
>>> (commit 22242681 "MIPS: Extend COMMAND_LINE_SIZE")
>>>
>>> This cause warning if something like buf[CL_SIZE] was declared as a
>>> local variable, for example in prom_init_cmdline() on some platforms.
>>>
>>> And since many Makefiles in arch/mips enables -Werror, this cause
>>> build failure.
>>>
>>> How can we avoid this error?
>>>
>>> - do not use local array? (but dynamic allocation cannot be used in
>>>  such an early stage.  static array?)
>>
>> Maybe a static array marked with __initdata?
>
> Also, I just thought that maybe it's possible to use a c99
> variable-length array here? Like this:
>
> int n = COMMAND_LINE_SIZE;
> char buf[n];
>
> This way, we don't put yet another variable in the .init.data section,
> unlike with the static array solution.
>
> However, this is totally untested, just a thought...

Just tried the variable-length array option, proves to be working:

dmvo@cipher:/tmp$ cat c.c
f()
{
        char buf[4096];
}
dmvo@cipher:/tmp$ cc -c -Wframe-larger-than=1024 c.c
c.c: In function ‘f’:
c.c:4: warning: the frame size of 4112 bytes is larger than 1024 bytes
dmvo@cipher:/tmp$ cat d.c
f()
{
        int n = 4096;
        char buf1[n];
}
dmvo@cipher:/tmp$ cc -c -Wframe-larger-than=1024 d.c

Dmitri
