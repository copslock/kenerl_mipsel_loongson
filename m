Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2007 21:00:20 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:12964 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039618AbXBIVAR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Feb 2007 21:00:17 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l19L0FtH027035;
	Fri, 9 Feb 2007 21:00:15 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l19L0EKD027034;
	Fri, 9 Feb 2007 21:00:14 GMT
Date:	Fri, 9 Feb 2007 21:00:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <fbuihuu@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, vagabon.xyz@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] signal.c: fix gcc warning on 32 bits kernel
Message-ID: <20070209210014.GA26939@linux-mips.org>
References: <1171033658561-git-send-email-fbuihuu@gmail.com> <11710336591652-git-send-email-fbuihuu@gmail.com> <20070210.011835.08318488.anemo@mba.ocn.ne.jp> <61ec3ea90702090834k774bf18bwf7ec5f7b10349779@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ec3ea90702090834k774bf18bwf7ec5f7b10349779@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 09, 2007 at 05:34:16PM +0100, Franck Bui-Huu wrote:
> Date:	Fri, 9 Feb 2007 17:34:16 +0100
> From:	"Franck Bui-Huu" <fbuihuu@gmail.com>
> To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
> Subject: Re: [PATCH 3/3] signal.c: fix gcc warning on 32 bits kernel
> Cc:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
> 	linux-mips@linux-mips.org
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> 
> On 2/9/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> >On Fri,  9 Feb 2007 16:07:38 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> 
> >wrote:
> >>       new_ka.sa.sa_handler = (__sighandler_t) __gu_tmp;
> >>
> >> Here we try to cast an 'unsigned long long' into a 32 bits pointer and
> >> that's the reason of the warning.
> >
> >This line is never executed on 32bit kernel and gcc optimize out.  On
> 
> yes I agree but it seems that gcc compiles this line before optimizing 
> out...
> 
> >
> >I think this is a problem of __get_user() implementation or gcc
> >itself.  Though I can not find better solution yet, hacking the caller
> >to avoid the warning would not be right things to to.
> 
> I agree too but I haven't found something else.

All gcc versions produce this warning and no, it's not a gcc bug but a
kernel bug.  __get_user expands into:

        case 8: {
                unsigned long long __gu_tmp;
[...]
		new_ka.sa.sa_handler =
			(__typeof__(*((&act->sa_handler)))) __gu_tmp;
	}

Which is quite a funny C problem to solve :-)

  Ralf
