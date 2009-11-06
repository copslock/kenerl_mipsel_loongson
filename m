Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 18:08:07 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:62683 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493040AbZKFRIA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 18:08:00 +0100
Received: by bwz21 with SMTP id 21so1379725bwz.24
        for <linux-mips@linux-mips.org>; Fri, 06 Nov 2009 09:07:54 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=OqlBHZmp/lTAsvFMnBVr+2eArn1No3T6bU0XrKpTjC8=;
        b=S8HdLXn80eD1wmtcD/mKYzzNmawjRMkoUkNnKQnq1k/nlhOnaRYWOTsyg652PknksV
         OgOgG0Xsgkv2JGkzjBpk6VbW/B27I2IqT0AX6jBtLkskWo+x82QSoW8drOYEkXsUV6sh
         gjO7x1+GVG2sUrliEoZMz4ZHGi0AIjEDLHeOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wJXZy2gsw2CioFaIVTbdJfAVlE/QI5JgT3QjrQfD7+nWtb0vbglmK5GuF5DilyosXe
         Tmci/ixdlswfQje6WXrMDHwifxZB1hxduRubhi+sCYviW6KDWTaukMLoU/UVjLORmjHw
         fJPgb1N0yHXTgaVQCJxy5VlVUwtfb1j9KLecs=
MIME-Version: 1.0
Received: by 10.223.14.22 with SMTP id e22mr717770faa.42.1257527274318; Fri, 
	06 Nov 2009 09:07:54 -0800 (PST)
In-Reply-To: <4AF4526B.3020502@caviumnetworks.com>
References: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>
	 <90edad820911060822g40233a8ft28001d68186b989e@mail.gmail.com>
	 <90edad820911060834t5c14aa30t847c3b75bf7e36e@mail.gmail.com>
	 <4AF4526B.3020502@caviumnetworks.com>
Date:	Fri, 6 Nov 2009 19:07:54 +0200
Message-ID: <90edad820911060907j4a605167xfe1ebdf0dcf7b635@mail.gmail.com>
Subject: Re: COMMAND_LINE_SIZE and CONFIG_FRAME_WARN
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Nov 6, 2009 at 6:44 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> Dmitri Vorobiev wrote:
>>
>> On Fri, Nov 6, 2009 at 6:22 PM, Dmitri Vorobiev
>> <dmitri.vorobiev@gmail.com> wrote:
>>>
>>> On Fri, Nov 6, 2009 at 6:08 PM, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>>> wrote:
>>>>
>>>> Recently COMMAND_LINE_SIZE (CL_SIZE) was extended to 4096 from 512.
>>>> (commit 22242681 "MIPS: Extend COMMAND_LINE_SIZE")
>>>>
>>>> This cause warning if something like buf[CL_SIZE] was declared as a
>>>> local variable, for example in prom_init_cmdline() on some platforms.
>>>>
>>>> And since many Makefiles in arch/mips enables -Werror, this cause
>>>> build failure.
>>>>
>>>> How can we avoid this error?
>>>>
>>>> - do not use local array? (but dynamic allocation cannot be used in
>>>>  such an early stage.  static array?)
>>>
>>> Maybe a static array marked with __initdata?
>>
>> Also, I just thought that maybe it's possible to use a c99
>> variable-length array here? Like this:
>>
>> int n = COMMAND_LINE_SIZE;
>> char buf[n];
>>
>> This way, we don't put yet another variable in the .init.data section,
>> unlike with the static array solution.
>>
>> However, this is totally untested, just a thought...
>>
>
> It depends on your concerns.  You are still using 4096 bytes of stack, but
> you are trying to trick the compiler into not warning.
>
> If you think the warning is bogus, you should remove it for all code, not
> just this file.  If you think the warning is valid, then you should fix the
> code so that it doesn't use as much stack space.

Frankly, I don't think that the warning is bogus, especially if we're
talking about the case of the 4K page and 32-bit kernel, and I started
thinking htat probably the static array solution would be the safest
bet here.

Dmitri
