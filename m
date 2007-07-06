Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jul 2007 09:30:54 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.176]:5040 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022467AbXGFIat (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jul 2007 09:30:49 +0100
Received: by wa-out-1112.google.com with SMTP id m16so178930waf
        for <linux-mips@linux-mips.org>; Fri, 06 Jul 2007 01:30:35 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LY7rsAc8qT6xnlJaIHicLYSnpjQ/jCQNA1OWwHtY1VzWnCyitLjAy3b/Gvp1e3Lg3Dh6bp1kOGNzgFRUHdwzqn+wtls6VQYPuL2hbsioUYcrF+pmmsm8Al4H5EoT+RyJqjj1dCWf9kIG/YuX1+ADc7b/zxT8YVyzHhEgiuLgYOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jRksg4c7vBDWnYI0HTBKj2oO6/KJAY5YhbClz41b9w6L4e0ZpZCb9XP+j4mfTb5Ea2DKQ0VuhE/sLX/HAPLYXoXhF6y7ppRYd+nkYDdLiGMGu+/ylZ3uA9JhIkJ16eVS4eLkkDvtQPqXEmDuD6Nt/ppqXvrZw4ZCDB8rt615NYE=
Received: by 10.114.112.1 with SMTP id k1mr450712wac.1183710635009;
        Fri, 06 Jul 2007 01:30:35 -0700 (PDT)
Received: by 10.114.108.4 with HTTP; Fri, 6 Jul 2007 01:30:34 -0700 (PDT)
Message-ID: <6849c8890707060130q79a2890eq51001b18fd21519f@mail.gmail.com>
Date:	Fri, 6 Jul 2007 09:30:34 +0100
From:	TJ <tj.trevelyan@gmail.com>
To:	"sknauert@wesleyan.edu" <sknauert@wesleyan.edu>,
	"Linux MIPS List" <linux-mips@linux-mips.org>
Subject: Re: Fwd: [RFC] SGI O2 MACE audio ALSA module
In-Reply-To: <43914.129.133.92.31.1183709449.squirrel@webmail.wesleyan.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6849c8890707020427q47704326od05ebb8241c3cf@mail.gmail.com>
	 <6849c8890707040125x34cb2b0jf7acfabfa0bf351f@mail.gmail.com>
	 <43914.129.133.92.31.1183709449.squirrel@webmail.wesleyan.edu>
Return-Path: <tj.trevelyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj.trevelyan@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 06/07/07, sknauert@wesleyan.edu <sknauert@wesleyan.edu> wrote:
> First off, thanks for your work on this.
>
> I tried to compile with 2.6.21.3 and Debian's gcc 4.1.1-27 cross-compiler.
> The kernel compiled, but make modules failed with the errors below.
> Something's definitely wrong with the typedefs and structs for use in a
> newer kernel.

The compile errors is because ALSA have removed all the typedefs for
their structures in the header files, while my module still uses the
typedefs. As a short term fix grab include/sound/typedefs.h from an
older kernel.

I can see the case against other uses of typedef, but I really do not
see why typedef struct is so bad. seeing 'struct mything_s *foo;'
doesn't really tell you anything more about foo then 'mything_t *foo;'
does. If a typedef was something other then a struct then I would want
it to have an obvious name that said such, eg 'u64'. (I really don't
like 'size_t')

>
> I also tried the linux-MIPS 2.6.19.7 and while the kernel compiles it
> doesn't boot.


I don't know why you can't get 2.6.19.7 to boot, did you make sure
that CONFIG_BUILD_ELF64 is 'n'? That's been an issue that bit me.

At the moment my crossdev env is broken, but once I fixed it I will
get the latest lm.o kernel version and update the alsa stuff in my
module so that it will build.

Thanks for looking at the patch.

Thorben
