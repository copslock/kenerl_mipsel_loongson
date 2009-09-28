Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2009 20:46:29 +0200 (CEST)
Received: from mail-pz0-f196.google.com ([209.85.222.196]:54847 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493548AbZI1SqV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Sep 2009 20:46:21 +0200
Received: by pzk34 with SMTP id 34so2603518pzk.22
        for <multiple recipients>; Mon, 28 Sep 2009 11:46:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=5HDgAIl5a660DqR9WckDWO+37SnMKsk16R6Qh3k0GCw=;
        b=qCvPqDgY393E/LBXp20ey+1+VX5wvgl7cfUhRyHLcITvBfIFAHp1KK1by3u8KXGndv
         5JzcLmhulJZo72jJdLiwiWZxzDhwCNk4c8sDbTl4wnEniizwHzJmst5UqDOH7FF/lMXh
         56Qp412zwQEqsgzUDnl8i1s0XEaY0QoyZQGFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=GiMSeWOc/gcPQZlcD1Fbv1WkHnB+SSdzNzljGJL4Ze7mcMXtkj2rtaQ8CYySKXm8Hm
         scWXPldoxN3p2XSdkPQ9KIApZLcwbodq/xrpH1I+PD/jZZ44sKxIqK7LnraKWAtWdeO0
         i3tVBfvNxXh9UirW/T/FXiNmzIKacKIKQhfcg=
MIME-Version: 1.0
Received: by 10.143.24.40 with SMTP id b40mr22285wfj.0.1254163571554; Mon, 28 
	Sep 2009 11:46:11 -0700 (PDT)
In-Reply-To: <20090928104728.GA3571@linux-mips.org>
References: <1254021294-3832-1-git-send-email-weiyi.huang@gmail.com>
	 <20090928104728.GA3571@linux-mips.org>
Date:	Mon, 28 Sep 2009 20:46:11 +0200
X-Google-Sender-Auth: f0f0989e8b9fa693
Message-ID: <10f740e80909281146y57b4aa67h5ec69b46fe77b4fd@mail.gmail.com>
Subject: Re: [PATCH 1/5] MIPS: remove duplicated #include
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Huang Weiyi <weiyi.huang@gmail.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 28, 2009 at 12:47, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sun, Sep 27, 2009 at 11:14:54AM +0800, Huang Weiyi wrote:
>
>> Remove duplicated #include('s) in
>>   arch/mips/kernel/smp.c
>>
>> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
>
> This is the 3rd identical patch I've received ...

I have the impression people discovered the good old `make includecheck', since
it's been added to `make help' ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
