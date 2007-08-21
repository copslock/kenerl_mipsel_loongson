Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2007 21:41:26 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.190]:32982 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022138AbXHUUlX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Aug 2007 21:41:23 +0100
Received: by fk-out-0910.google.com with SMTP id f40so1645131fka
        for <linux-mips@linux-mips.org>; Tue, 21 Aug 2007 13:41:06 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kJ8Vu64KKjNiL5xP+IVsAetxZSGI7JxOdZNafXK/+lrMWqUzAxEihpXGu4PczyPKrxuy+oNGBx18Jpf2jbzemVBzp4/HrMDpH7S7WW9g9uKFTpIeqwXx/AW3/41YIsDwcy2HkcnCWHx4aIupk2Rpc1DobwkAe9hjAIJonJFDVBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cN4tXoYMxt/nrUp0m8GRowxotWIePfjMMlyUXlSbA+oCc1bAnsrAPg191j7/xlp63WkmmT4ozcxwCUqsoSPewHIxmCy3GrPYXtIBuP3NwfUZnU2dFopbUyY+WfXhUtyRqfywpVBMpwhGD9/XpDuRjCQzWXtYb9u9IDJ7vrNpstA=
Received: by 10.82.112.3 with SMTP id k3mr11263933buc.1187728864272;
        Tue, 21 Aug 2007 13:41:04 -0700 (PDT)
Received: by 10.82.139.9 with HTTP; Tue, 21 Aug 2007 13:41:04 -0700 (PDT)
Message-ID: <5d6222a80708211341s63f8c1eau922f018e66db49f4@mail.gmail.com>
Date:	Tue, 21 Aug 2007 17:41:04 -0300
From:	"Glauber de Oliveira Costa" <glommer@gmail.com>
To:	"Chris Wedgwood" <cw@f00f.org>
Subject: Re: RFC: drop support for gcc < 4.0
Cc:	"Adrian Bunk" <bunk@kernel.org>,
	"Randy Dunlap" <randy.dunlap@oracle.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Jarek Poplawski" <jarkao2@o2.pl>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mips@linux-mips.org
In-Reply-To: <20070821182505.GA20968@puku.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070821132038.GA22254@ff.dom.local>
	 <20070821093103.3c097d4a.randy.dunlap@oracle.com>
	 <20070821173550.GC30705@stusta.de>
	 <20070821182505.GA20968@puku.stupidest.org>
Return-Path: <glommer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glommer@gmail.com
Precedence: bulk
X-list: linux-mips

On 8/21/07, Chris Wedgwood <cw@f00f.org> wrote:
> On Tue, Aug 21, 2007 at 07:35:50PM +0200, Adrian Bunk wrote:
>
> > Are there any architectures still requiring a gcc < 4.0 ?
>
> Yes, sadly in some places (embedded) there are people with older
> compiler who want newer kernels.

Last time I tried a mips build, it would fail the compile unless I was
using _exactly_ 3.4.4 (I didn't tried older versions, but did try
3.4.6, for ex.). So I also think the 3.4 series will still have to be
around for a while.

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
