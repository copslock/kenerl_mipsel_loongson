Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 16:26:33 +0000 (GMT)
Received: from wx-out-0506.google.com ([66.249.82.238]:19301 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20044680AbXAWQ02 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 16:26:28 +0000
Received: by wx-out-0506.google.com with SMTP id t14so1761556wxc
        for <linux-mips@linux-mips.org>; Tue, 23 Jan 2007 08:26:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DYIDFOjytc+jGaNSORGPzApxTjap3B3oXcxUXy2R5DB/EmYkn3QeiYnmj/N6j+2z2/ur5WqTscDcVUrCQI/WmZ0HSdP+bvR+XjIm2r+2Zp6+RLUCaKY0xRp29MKX3A6y3PfKmoHvtIKpfFoOMiX7fIGQahN353d3EckicDllo+E=
Received: by 10.90.56.14 with SMTP id e14mr8174648aga.1169569581734;
        Tue, 23 Jan 2007 08:26:21 -0800 (PST)
Received: by 10.90.104.20 with HTTP; Tue, 23 Jan 2007 08:26:21 -0800 (PST)
Message-ID: <cda58cb80701230826i3cba9164jf20678f9efd1a7ba@mail.gmail.com>
Date:	Tue, 23 Jan 2007 17:26:21 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 1/7] signals: reduce {setup,restore}_sigcontext sizes
Cc:	linux-mips@linux-mips.org, "Franck Bui-Huu" <fbuihuu@gmail.com>
In-Reply-To: <20070123143814.GE18083@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1169561903878-git-send-email-fbuihuu@gmail.com>
	 <11695619031540-git-send-email-fbuihuu@gmail.com>
	 <20070123143814.GE18083@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 1/23/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Jan 23, 2007 at 03:18:17PM +0100, Franck Bui-Huu wrote:
> >    text    data     bss     dec     hex filename
> >   11972       0       0   11972    2ec4 arch/mips/kernel/signal.o~old
> >    5380       0       0    5380    1504 arch/mips/kernel/signal.o~new
>
> Have you ran any benchmarks on this?  Unrolling the loops used to make
> a noticable difference.
>

No, I haven't. Since the size code has been reduced by a factor 2, I
would think that signal code can better fit in instruction cache
lines. For example, the loop is made up by 11 instructions (I don't
know why gcc makes it so big though) which fits into 3 cache lines in
my cases. Where as the old code generated 246 instructions for the
same job, which should cause many more cache misses.

Do you have any pointers on benchmarks I could run ?

thanks
-- 
               Franck
