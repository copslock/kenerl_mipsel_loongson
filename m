Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2006 19:51:28 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.174]:48834 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133577AbWG0SvT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Jul 2006 19:51:19 +0100
Received: by ug-out-1314.google.com with SMTP id y2so382720uge
        for <linux-mips@linux-mips.org>; Thu, 27 Jul 2006 11:51:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CIxcd9XT/SazVaR6EkmAbHR78T0PlIljlyg1dktNayWneg1eMOVOCClTbFWmy3i+svoyNm7cFbkvb49ETAXPupaPzid2ubJAk2MbrReqOYJIAspib7ppGIZPiQsvV8Qsw6+IloE3O+QhQTeuy6hTvmh+QsGxWx6hnfy+YQBw/Zs=
Received: by 10.67.29.12 with SMTP id g12mr7564180ugj;
        Thu, 27 Jul 2006 11:51:17 -0700 (PDT)
Received: by 10.67.87.8 with HTTP; Thu, 27 Jul 2006 11:51:17 -0700 (PDT)
Message-ID: <cda58cb80607271151n2dcfe64cn4cb1ecca3ece6b1e@mail.gmail.com>
Date:	Thu, 27 Jul 2006 20:51:17 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Thiemo Seufer" <ths@networkno.de>
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
Cc:	"David Daney" <ddaney@avtrex.com>,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
In-Reply-To: <20060727170305.GB4505@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060726.232231.59465336.anemo@mba.ocn.ne.jp>
	 <44C8EFE2.4010102@avtrex.com> <20060727170305.GB4505@networkno.de>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/7/27, Thiemo Seufer <ths@networkno.de>:
> David Daney wrote:
> > Atsushi Nemoto wrote:
> > >Instead of dump all possible address in the stack, unwind the stack
> > >frame based on prologue code analysis, as like as get_chan() does.
> > >While the code analysis might fail for some reason, there is a new
> > >kernel option "raw_show_trace" to disable this feature.
> > >
> > >Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >
> > Let me start by saying I have not analyzed how all this code works, but
> > I have done something similar in user space.
> >
> > Since the kernel ABI does not use gp, many functions may not have a
> > prolog (especially when compiled with newer versions of GCC).  In the
> > user space case, most leaf functions have no prolog.  For the kernel I
> > would imagine that many non-leaf functions (simple non-leaf functions
> > that do only a tail call) would also not have a prolog.
>
> Non-leaves have to save/restore $31 somewhere, so there should be a
> prologue.
>

That's no always true. Consider this simple example:

void foo_wrapper(int a, int b)
{
        /* doing some checkings */
        [...];
        foo(a,b);
}

void foo(int a, intb)
{
        [...];
}

In foo_wrapper(), gcc will generate a "j" instruction (well I guess)
because once foo() is called and is finished, there's no needs to
return back to foo_wrapper(). In that case, foo_wrapper() won't have a
prologue.

But is it really needed to show that foo_wrapper() has been called
before foo() ? The backtrace given by oops is for the first debug
intervention. They don't give a very accurate backtrace but it's
enough to understand what's going on in most cases.

BTW, the same exists with inlined functions. Gcc can inlined function
that are not been marked inlined and these functions won't appear in
any traces...

-- 
               Franck
