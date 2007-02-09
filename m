Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2007 16:35:22 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.237]:44650 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038803AbXBIQfR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Feb 2007 16:35:17 +0000
Received: by hu-out-0506.google.com with SMTP id 22so360268hug
        for <linux-mips@linux-mips.org>; Fri, 09 Feb 2007 08:34:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dvYMMz8Lu2+p0OVTasPFgyb02ZGFzw/DQw+HJLumNqLMDc+i/aD3ztNIIPcpJXnXi6r4Lq6XsOrvu2Bm9O+wP4PwwDp+VuPtJUO9MdXmGlnUmBtdA2Fz9GbACi+S7TqLNVjPBhtYQuEKhL7x9BClZgylvHYQooKD3gs9HuqdP70=
Received: by 10.78.20.13 with SMTP id 13mr5013662hut.1171038857030;
        Fri, 09 Feb 2007 08:34:17 -0800 (PST)
Received: by 10.78.183.16 with HTTP; Fri, 9 Feb 2007 08:34:16 -0800 (PST)
Message-ID: <61ec3ea90702090834k774bf18bwf7ec5f7b10349779@mail.gmail.com>
Date:	Fri, 9 Feb 2007 17:34:16 +0100
From:	"Franck Bui-Huu" <fbuihuu@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 3/3] signal.c: fix gcc warning on 32 bits kernel
Cc:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
In-Reply-To: <20070210.011835.08318488.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1171033658561-git-send-email-fbuihuu@gmail.com>
	 <11710336591652-git-send-email-fbuihuu@gmail.com>
	 <20070210.011835.08318488.anemo@mba.ocn.ne.jp>
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/9/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Fri,  9 Feb 2007 16:07:38 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> >       new_ka.sa.sa_handler = (__sighandler_t) __gu_tmp;
> >
> > Here we try to cast an 'unsigned long long' into a 32 bits pointer and
> > that's the reason of the warning.
>
> This line is never executed on 32bit kernel and gcc optimize out.  On

yes I agree but it seems that gcc compiles this line before optimizing out...

>
> I think this is a problem of __get_user() implementation or gcc
> itself.  Though I can not find better solution yet, hacking the caller
> to avoid the warning would not be right things to to.

I agree too but I haven't found something else.

BTW, my version of gcc is: mipsel-linux-gcc (GCC) 3.4.4 mipssde-6.05.00-20061023

thanks
-- 
                Franck
