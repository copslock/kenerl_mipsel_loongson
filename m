Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jun 2009 07:59:52 +0200 (CEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:33942 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491771AbZFNF7p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 Jun 2009 07:59:45 +0200
Received: by fxm23 with SMTP id 23so3470635fxm.0
        for <multiple recipients>; Sat, 13 Jun 2009 22:59:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=NAlbSEttYqCOSL1PWlTANL/5wXGXcJBmkzzmJlO36BE=;
        b=LFTpzGZ3ft77wOAAjuhhhi7sH9/61E8grkCOQef0PfWvKEhQ9xLJ0SzuSp00eFgLET
         sRIdTY9WsMGHRc2v/S49nYYYCAdUd3jiyfNCFT57FSvnP1dI+578KQTvgMqO9YxFmEdE
         064X7GFHcGA6v7oNXX/zkkGlfwtH6c0ubzhw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=jd/QnXnz/GZzFlzN/AikfW+S/ArCKxytz/8qklokb5wbsLKjz+Z/yu15nnZMM9CVku
         x8sJgECjiLtz7Zs+hsT6Xd/cvOS446N+XGpQNU149LY9y7zJkVczp0MX0SVdC5o0z4nr
         QgYjFasO35F+KpnbYZ0fjiq6rK2QPfIuVelGg=
MIME-Version: 1.0
Received: by 10.103.248.17 with SMTP id a17mr2816066mus.83.1244959155054; Sat, 
	13 Jun 2009 22:59:15 -0700 (PDT)
In-Reply-To: <1244958863-28899-1-git-send-email-wuzhangjin@gmail.com>
References: <1244958863-28899-1-git-send-email-wuzhangjin@gmail.com>
Date:	Sun, 14 Jun 2009 08:59:15 +0300
X-Google-Sender-Auth: d4504877a94aa285
Message-ID: <84144f020906132259v2637b436vbc42b49c2adf06ff@mail.gmail.com>
Subject: Re: [PATCH] kmemtrace:fix undeclared 'PAGE_SIZE' via asm/page.h
From:	Pekka Enberg <penberg@cs.helsinki.fi>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Wu Zhangjin <wuzj@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <penberg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: penberg@cs.helsinki.fi
Precedence: bulk
X-list: linux-mips

On Sun, Jun 14, 2009 at 8:54 AM, Wu Zhangjin<wuzhangjin@gmail.com> wrote:
> From: Wu Zhangjin <wuzj@lemote.com>
>
> when compiling linux-mips with kmemtrace enabled, this error will be
> there:
>
> include/linux/trace_seq.h:12: error: 'PAGE_SIZE' undeclared here (not in
>                                a function)
>
> I checked the source code and found trace_seq.h used PAGE_SIZE but not
> include the relative header file, so, fix it via adding the header file
> <asm/page.h>
>
> this error will not be triggered in linux-x86 for there is a
> <asm/page.h> header file included in a certain header file. but which
> not means <asm/page.h> is not needed in trace_seq.h
>
> Signed-off-by: Wu Zhangjin <wuzj@lemote.com>

This looks like a generic tracing issue, not a kmemtrace problem so
the subject line needs fixing. But the change looks good to me:

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>
