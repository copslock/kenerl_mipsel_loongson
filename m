Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2007 16:51:45 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.229]:40462 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038769AbXBIQvl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Feb 2007 16:51:41 +0000
Received: by qb-out-0506.google.com with SMTP id e12so201449qba
        for <linux-mips@linux-mips.org>; Fri, 09 Feb 2007 08:50:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UivTl0Rm2pXaNnmlj9W1NimNSAv/dnzWQhIkITRoqjKY/V0rHfVQLmMR5VXeAenB1DyVp8bzrSVz2y/HmwI0aMdC85mzj0FTc3pnwvE46SBUBsONh5KpYGUFfhujKxvU8mv+QyGQ0X2Wjv00cq2EL+fyKHMuWV9dw4kksUl0Tl4=
Received: by 10.114.124.1 with SMTP id w1mr5048739wac.1171039836435;
        Fri, 09 Feb 2007 08:50:36 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Fri, 9 Feb 2007 08:50:36 -0800 (PST)
Message-ID: <cda58cb80702090850q6bedc940y7cc401af4bb231aa@mail.gmail.com>
Date:	Fri, 9 Feb 2007 17:50:36 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 1/3] signal: avoid useless test in do_signal()
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp,
	"Franck Bui-Huu" <fbuihuu@gmail.com>
In-Reply-To: <20070209162118.GA26617@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1171033658561-git-send-email-fbuihuu@gmail.com>
	 <11710336594091-git-send-email-fbuihuu@gmail.com>
	 <20070209162118.GA26617@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/9/07, Ralf Baechle <ralf@linux-mips.org> wrote:
Ralf Baechle wrote:
> On Fri, Feb 09, 2007 at 04:07:36PM +0100, Franck Bui-Huu wrote:
>
>> -			if (test_thread_flag(TIF_RESTORE_SIGMASK))
>> -				clear_thread_flag(TIF_RESTORE_SIGMASK);
>
> This is a microoptimization.  The assumption here is TIF_RESTORE_SIGMASK
> will rarely need to be cleared and atomic operations are somewhat
> expensive if as in this case we have to assume the cacheline isn't
> held exclusive yet.
>

I missed that. You can forget this patch or maybe something like this
is more appropriate ?

	if (unlikely(test_thread_flag(TIF_RESTORE_SIGMASK)))
		clear_thread_flag(TIF_RESTORE_SIGMASK);
-- 
               Franck
