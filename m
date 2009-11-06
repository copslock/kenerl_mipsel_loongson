Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 17:34:42 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:41502 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492983AbZKFQeS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 17:34:18 +0100
Received: by bwz21 with SMTP id 21so1344824bwz.24
        for <linux-mips@linux-mips.org>; Fri, 06 Nov 2009 08:34:10 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=hWZnce3LBdQP1RP3aDxEklftz7SjDoJsY3wIUCxx7rU=;
        b=Ag1d4ldhtVVT2JITdDR9KgOCOS/KHoQQFKueiXzbq6WbLYV5yTbWGQ/mEvAa8ovGKD
         fEqByScqXVNFlQ2Bwo7tJibzuryOJromITfqeBKO6VxjaSS4cO5LL8WEU7XgwT7vxUOR
         CsZP/O0WQmxbnRU9N0jjvMy3D2720T6+8Dl64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BloOUPPl8DVGzVmN3lIL8pKPsWX4xaGRPNV6SVI3b8jfVwqeftg2uX0WJ4kOAQrbb+
         AGxE8b8O7nXGHPq4kmvnrdjPfDemPGLI9qhByFV8ejcqAVZL7DDzkmuRMvwRoEFCNikp
         mxBJ5h9nB0cuVvG8D8+40tjIl1zIyWo+nVv6Q=
MIME-Version: 1.0
Received: by 10.223.14.22 with SMTP id e22mr711491faa.42.1257525250650; Fri, 
	06 Nov 2009 08:34:10 -0800 (PST)
In-Reply-To: <90edad820911060822g40233a8ft28001d68186b989e@mail.gmail.com>
References: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>
	 <90edad820911060822g40233a8ft28001d68186b989e@mail.gmail.com>
Date:	Fri, 6 Nov 2009 18:34:10 +0200
Message-ID: <90edad820911060834t5c14aa30t847c3b75bf7e36e@mail.gmail.com>
Subject: Re: COMMAND_LINE_SIZE and CONFIG_FRAME_WARN
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Nov 6, 2009 at 6:22 PM, Dmitri Vorobiev
<dmitri.vorobiev@gmail.com> wrote:
> On Fri, Nov 6, 2009 at 6:08 PM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>> Recently COMMAND_LINE_SIZE (CL_SIZE) was extended to 4096 from 512.
>> (commit 22242681 "MIPS: Extend COMMAND_LINE_SIZE")
>>
>> This cause warning if something like buf[CL_SIZE] was declared as a
>> local variable, for example in prom_init_cmdline() on some platforms.
>>
>> And since many Makefiles in arch/mips enables -Werror, this cause
>> build failure.
>>
>> How can we avoid this error?
>>
>> - do not use local array? (but dynamic allocation cannot be used in
>>  such an early stage.  static array?)
>
> Maybe a static array marked with __initdata?

Also, I just thought that maybe it's possible to use a c99
variable-length array here? Like this:

int n = COMMAND_LINE_SIZE;
char buf[n];

This way, we don't put yet another variable in the .init.data section,
unlike with the static array solution.

However, this is totally untested, just a thought...

Dmitri

>
> Dmitri
>
