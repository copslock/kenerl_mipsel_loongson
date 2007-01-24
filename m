Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 12:25:37 +0000 (GMT)
Received: from ag-out-0708.google.com ([72.14.246.249]:49907 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20045497AbXAXMZc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 12:25:32 +0000
Received: by ag-out-0708.google.com with SMTP id 22so162951agd
        for <linux-mips@linux-mips.org>; Wed, 24 Jan 2007 04:25:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IMCG2Joifk6bbEYi/RHViHaBvFUiChU0FO+7cP2WJlZtdbVQrlqYe3U/lKyiGqD8qDvEGXILzgHoo/1uxCgOca2XCU+HP8AWR+5ZyTp8bKyerPBIO5NK/fRbJmZU80t70/vjZcbF08tcPALfmk5xPgK8rmrCFprUuggEl0AQyVg=
Received: by 10.90.116.6 with SMTP id o6mr471939agc.1169641527638;
        Wed, 24 Jan 2007 04:25:27 -0800 (PST)
Received: by 10.90.104.20 with HTTP; Wed, 24 Jan 2007 04:25:27 -0800 (PST)
Message-ID: <cda58cb80701240425r7be3769fj577185e151bf3580@mail.gmail.com>
Date:	Wed, 24 Jan 2007 13:25:27 +0100
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
X-archive-position: 13787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 1/23/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Jan 23, 2007 at 03:18:17PM +0100, Franck Bui-Huu wrote:
>
> > From: Franck Bui-Huu <fbuihuu@gmail.com>
> >
> > This trivial change reduces considerably code size of these
> > 2 functions callers. For instance, here is the figures for
> > arch/kernel/signal.o objects:
> >
> >    text    data     bss     dec     hex filename
> >   11972       0       0   11972    2ec4 arch/mips/kernel/signal.o~old
> >    5380       0       0    5380    1504 arch/mips/kernel/signal.o~new
>
> Have you ran any benchmarks on this?  Unrolling the loops used to make
> a noticable difference.
>

OK, I ran a micro benchmark on setup_frame() which calls
setup_sigcontext(). I got the execution time of setup_frame() by
counting the number of cycles spent in it (by using cp0_count
register).

Without this patchset applied it takes about 14600 cycles for
setup_frame() execution whereas with this patchset applied it takes
10300 cycles. These figures are averages.

So it appears that this patchset has a positive impact on both size and speed.

thanks
-- 
               Franck
