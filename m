Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 14:02:03 +0100 (BST)
Received: from qb-out-0506.google.com ([72.14.204.238]:12781 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022919AbXFNNCA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 14:02:00 +0100
Received: by qb-out-0506.google.com with SMTP id q17so198004qba
        for <linux-mips@linux-mips.org>; Thu, 14 Jun 2007 06:00:59 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LW4h5ZuVyUexaXyB05VpUNqO5u0c1qpMy6zHao7r7KK2QI3nO0eDKqc8yR2fXrullsB8RmwkwDqG0hRnId5xlk78zHCnJexNedrgODs80+w0ZlJFNG659lxUwlUb6HJsPSDY7SwdlG1dmvW+WuO1zJYQjeQR7o9TYBVn4dnnmks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J4ZXfysNloEwMCjg7lUv7sWzXlOu+9J8SxRSawzLqSOjaiZYCH+OREorXOw51egeGduTSxOZ0fWaSWUqf1bjxkZ2DM/LoZqO3kfA2KPi5FVYH0bs7RlW3N4P9oqa1hjuVuy/A792dDY/0+IP0oi6Dl5RTBCormsnCmD+9vjAPQo=
Received: by 10.64.148.8 with SMTP id v8mr3082873qbd.1181826059063;
        Thu, 14 Jun 2007 06:00:59 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Thu, 14 Jun 2007 06:00:59 -0700 (PDT)
Message-ID: <cda58cb80706140600q2790b4e8i88b17b678fbd712@mail.gmail.com>
Date:	Thu, 14 Jun 2007 15:00:59 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 5/5] Implement clockevents for R4000-style cp0 timer
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070614.212913.82089068.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
	 <11818164024053-git-send-email-fbuihuu@gmail.com>
	 <20070614.212913.82089068.nemoto@toshiba-tops.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

On 6/14/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Thu, 14 Jun 2007 12:20:01 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> >  create mode 100644 arch/mips/lib/time.c
>
> I think this to_tm() cleanup should be done in separate patch.
>

I think so.

Actually that was something Ralf already did and I wanted to reuse.
I'll do that but for now I would like to know if this patch is the
right way to go...

Anyway thanks for noticing.

> Maybe selecting RTC_LIB in Kconfig and replace all to_tm() calls with
>
>         rtc_time_to_tm(tim, tm);
>         tm->tm_year += 1900;
>
> would be enough.
>

I dunno, but I think that could be part of another patchset if you don't mind.

-- 
               Franck
