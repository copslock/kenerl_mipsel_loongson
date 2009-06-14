Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jun 2009 08:25:38 +0200 (CEST)
Received: from wa-out-1112.google.com ([209.85.146.177]:34644 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491786AbZFNGZ3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Jun 2009 08:25:29 +0200
Received: by wa-out-1112.google.com with SMTP id n4so595330wag.0
        for <multiple recipients>; Sat, 13 Jun 2009 23:25:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=p2k0XFXJPp/pm4PSePvzDerjGdBnR03Nejl1cH6IUCk=;
        b=mKBI3Sm+ABgjFEFXD/6zrhXxc7UZT6jiBo1v2vFdF1Bv0H/WUZAm8qSoko3Fe1jZEL
         hzaySrY2lI/v6DUvPDjHK8XFFiTdBysC44FLtdbnayThK3UXh7PpnXK24v8sMqg4q/ah
         3chQhil/gcA8FhB5Hc3IKLSI2MSR/gtS5g90o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=GjVNvePPgCtkipDC4J+T2A0Y1exgl8iku7SldQwCgwomFdxDYuoKg8Q8KFoXx9oNK6
         8oEmrOqs+4KaKCg0GRmwRx0BdyIZp3LzqOunBLVVjehLsE0SfG3Aof2ofblwqagW6GJo
         LcfGvb1KZqrOBX7eoUAr5Eqh3W16sfOuMMk+8=
Received: by 10.115.73.20 with SMTP id a20mr9169515wal.72.1244960274676;
        Sat, 13 Jun 2009 23:17:54 -0700 (PDT)
Received: from ?192.168.1.103? ([219.246.59.144])
        by mx.google.com with ESMTPS id m17sm3858337waf.3.2009.06.13.23.17.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 23:17:53 -0700 (PDT)
Subject: Re: [PATCH] kmemtrace:fix undeclared 'PAGE_SIZE' via asm/page.h
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Pekka Enberg <penberg@cs.helsinki.fi>
Cc:	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <84144f020906132259v2637b436vbc42b49c2adf06ff@mail.gmail.com>
References: <1244958863-28899-1-git-send-email-wuzhangjin@gmail.com>
	 <84144f020906132259v2637b436vbc42b49c2adf06ff@mail.gmail.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sun, 14 Jun 2009 14:17:46 +0800
Message-Id: <1244960266.4968.162.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, 2009-06-14 at 08:59 +0300, Pekka Enberg wrote:
> On Sun, Jun 14, 2009 at 8:54 AM, Wu Zhangjin<wuzhangjin@gmail.com> wrote:
> > From: Wu Zhangjin <wuzj@lemote.com>
> >
> > when compiling linux-mips with kmemtrace enabled, this error will be
> > there:
> >
> > include/linux/trace_seq.h:12: error: 'PAGE_SIZE' undeclared here (not in
> >                                a function)
> >
> > I checked the source code and found trace_seq.h used PAGE_SIZE but not
> > include the relative header file, so, fix it via adding the header file
> > <asm/page.h>
> >
> > this error will not be triggered in linux-x86 for there is a
> > <asm/page.h> header file included in a certain header file. but which
> > not means <asm/page.h> is not needed in trace_seq.h
> >
> > Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
> 
> This looks like a generic tracing issue, not a kmemtrace problem so
> the subject line needs fixing. But the change looks good to me:
> 
so, what about this subject?
	
  ftrace: fix undeclared 'PAGE_SIZE' in include/linux/trace_seq.h 

> Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>

will add it later.

thanks!
Wu Zhangjin
