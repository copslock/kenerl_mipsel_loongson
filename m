Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 18:23:38 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:62885 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S2097301AbZKFRXb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 18:23:31 +0100
Received: by bwz21 with SMTP id 21so1395393bwz.24
        for <multiple recipients>; Fri, 06 Nov 2009 09:23:25 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=EnjWM7XUEkO9VU3J88853Tedx7TALi04AqNuXldGo+0=;
        b=EaRgf1F25x5emyj7bZV8dKxaavJ9InxBOuSi5Q0S0tVrq4t8Qo1KOZBl7o+jD2c0H2
         2aGd8eX+w73YXdp5ezCu7XsgOYpZRlmOJAMvAuc57+DtE6C5QIDjXGFvd4VMcOA2zAmA
         ZHPbEtt+8iPDhzigiZDy1fqI0pFcOgpWI8wk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mxAQerFLrsfP/QsvOFgoC+j5lK+TwibUVN5SxymCV2yViPqOLceh0GH6gWuz40Hvnt
         Ibv68PTjv/HCb8gjqCbXDrF+wqBvkzj79G1+5yZ5rZoMrRp9r7LBsMosecXY5A1JCjhH
         alxY4ZeoZT1W+me4mNkgKYM+XdumlQXHPhYss=
MIME-Version: 1.0
Received: by 10.223.6.9 with SMTP id 9mr665718fax.84.1257528205172; Fri, 06 
	Nov 2009 09:23:25 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0911061710160.9725@eddie.linux-mips.org>
References: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>
	 <90edad820911060822g40233a8ft28001d68186b989e@mail.gmail.com>
	 <90edad820911060834t5c14aa30t847c3b75bf7e36e@mail.gmail.com>
	 <4AF4526B.3020502@caviumnetworks.com>
	 <90edad820911060907j4a605167xfe1ebdf0dcf7b635@mail.gmail.com>
	 <alpine.LFD.2.00.0911061710160.9725@eddie.linux-mips.org>
Date:	Fri, 6 Nov 2009 19:23:25 +0200
Message-ID: <90edad820911060923w6cd59c5dh57d123b6bc9d4219@mail.gmail.com>
Subject: Re: COMMAND_LINE_SIZE and CONFIG_FRAME_WARN
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Nov 6, 2009 at 7:16 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Fri, 6 Nov 2009, Dmitri Vorobiev wrote:
>
>> > It depends on your concerns.  You are still using 4096 bytes of stack, but
>> > you are trying to trick the compiler into not warning.
>> >
>> > If you think the warning is bogus, you should remove it for all code, not
>> > just this file.  If you think the warning is valid, then you should fix the
>> > code so that it doesn't use as much stack space.
>>
>> Frankly, I don't think that the warning is bogus, especially if we're
>> talking about the case of the 4K page and 32-bit kernel, and I started
>> thinking htat probably the static array solution would be the safest
>> bet here.
>
>  KSEG space is not paged, so who cares about the page size?  You're not
> making additional stack page allocations, although you can overflow the
> space available at some point (but that's avoided if you know a priori
> your backtrace is not going to be deep).  Static allocation has its
> drawbacks, for example it takes storage space (if it's initialised data)
> or memory space (if it's BSS) indefinitely.

Thanks for the explanation. Then a variable-size array, I guess.

Dmitri

>
>  Maciej
>
