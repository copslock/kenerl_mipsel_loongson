Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 May 2005 17:30:57 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.195]:23606 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8225837AbVEaQan> convert rfc822-to-8bit;
	Tue, 31 May 2005 17:30:43 +0100
Received: by zproxy.gmail.com with SMTP id 13so3025799nzp
        for <linux-mips@linux-mips.org>; Tue, 31 May 2005 09:30:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tc//QyzF5EgCmdS0798yp8Jbo8/IDArlgdvg0FvuH1yGZK7m09W/rQrtmq0Fju1UOBk8q/QkV1HdhQxnuiJoOyhT4k0N8HbDX4J/RocFVko7ndCj9dMT+Ya2HwnyAFqVFClcmv1eeqs8I4kArGKiYlXZtbOuF5TO0TXvHnGH6lU=
Received: by 10.36.2.16 with SMTP id 16mr2386171nzb;
        Tue, 31 May 2005 09:30:35 -0700 (PDT)
Received: by 10.36.68.6 with HTTP; Tue, 31 May 2005 09:30:35 -0700 (PDT)
Message-ID: <6097c4905053109307edb80a6@mail.gmail.com>
Date:	Tue, 31 May 2005 20:30:35 +0400
From:	Maxim Osipov <maxim.osipov@gmail.com>
Reply-To: maxim@mox.ru
To:	macro@linux-mips.org
Subject: Re: glibc-2.3.4 mips64 compilation failure
Cc:	linux-mips@linux-mips.org, dan@debian.org
In-Reply-To: <429C8F71.6080606@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <429C8F71.6080606@siemens.com>
Return-Path: <maxim.osipov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxim.osipov@gmail.com
Precedence: bulk
X-list: linux-mips

Yes, thanks - I'm already using it, for glibc it did help with my
problem. Binutils 2.16 and gcc 3.4.3 seems to compile out of box (wo
any patches), but I didn't try produced code on a hardware yet.

Best regards,
Maxim

On 5/31/05, Maxim Osipov <maxim.osipov@siemens.com> wrote:
> > Do anyone have a clue what is happening? AFAIK, some people already
> > had success building glibc for mips64. Probably I miss something?
> 
>   Please feel free to have a look at packages available at my site -- the
> setup may seem a little bit odd (n64 is used as the default format and
> actually the only one supported), but if you are after general setup,
> patches, etc. it is still relevant; just ignore the odd stuff.  Binary
> packages have been built with GCC 4.0.0, so probably the sources + patches
> are going to work with older tools as well.  You may consider using
> binutils 2.16, though (in general, not to solve your particular problem).
> 
>    Maciej
>
