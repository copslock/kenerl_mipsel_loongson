Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2007 22:31:24 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.230]:30022 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022465AbXH2VbQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Aug 2007 22:31:16 +0100
Received: by nz-out-0506.google.com with SMTP id n1so234167nzf
        for <linux-mips@linux-mips.org>; Wed, 29 Aug 2007 14:30:56 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GGSRKLt/1wWPXwmpEEI5h93Sh5g8hwZo9k1TWWOUWzwsyun1f3yEyYR+Iv9KKWc3tQUN7oW11NAwesx6RDZTBCFQExy60KA8ca4g1Hj1Dq+P75a7jAMl2ukcLXNPYDtJImJjZ9gVuu7VsSwNrQVCuXlUwGa4jO6V8Vvwy1n1iSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EdbggQMfhTqCzrf56Wy8v0xxOugOZmo+mOAq5JM0eCr4zaaHotVc6PWLBCmmO1Dpvx7NVehKCU/sYOot103fFRGzVKI2jfyhS7OZCFs3XO//pooxjK5/5fqmeIXsK/zdgXwZRePOpRcO5Pq0GlPj6jcypINjJY9cLqCx797SbtQ=
Received: by 10.141.171.6 with SMTP id y6mr573992rvo.1188423056046;
        Wed, 29 Aug 2007 14:30:56 -0700 (PDT)
Received: by 10.141.189.13 with HTTP; Wed, 29 Aug 2007 14:30:56 -0700 (PDT)
Message-ID: <816d36d30708291430s191dc200q15bf3a6eff4ee7b5@mail.gmail.com>
Date:	Wed, 29 Aug 2007 17:30:56 -0400
From:	"Ricardo Mendoza" <mendoza.ricardo@gmail.com>
To:	"Markus Gothe" <markus.gothe@27m.se>
Subject: Re: Exception while loading kernel
Cc:	"Giuseppe Sacco" <giuseppe@eppesuigoccas.homedns.org>,
	linux-mips@linux-mips.org
In-Reply-To: <46D5A42F.4090503@27m.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1188030215.13999.14.camel@scarafaggio>
	 <1188196563.2177.13.camel@scarafaggio> <46D2CB0F.7020505@27m.se>
	 <1188321514.6882.3.camel@scarafaggio>
	 <F288AA63-099B-4140-81B2-6A8E21887057@27m.se>
	 <20070829084622.156798b4.giuseppe@eppesuigoccas.homedns.org>
	 <816d36d30708290133w677756bbla8b8b2b25fe005f1@mail.gmail.com>
	 <1188377693.7270.1.camel@scarafaggio>
	 <816d36d30708290305i4b34ae11s4b469cc48fb999aa@mail.gmail.com>
	 <46D5A42F.4090503@27m.se>
Return-Path: <mendoza.ricardo@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mendoza.ricardo@gmail.com
Precedence: bulk
X-list: linux-mips

On 8/29/07, Markus Gothe <markus.gothe@27m.se> wrote:

> You're all wrong build it with -g (i.e. enable 'Kernel
> Hacking'-options), then strip it and saved the copy with debugging
> symbols. Then you run gdb on the one with debugging symbols and voila
> you get the function.

I am talking ip32 specific here, ELF64 is a no go there. The exception
thrown is the same as when an ELF64 binary attempts to be loaded on my
ip32. I am sure his problem is not with code because ip32 works; even
less with that much of an early code (I hope you can see linux
exception vectors are not even installed).

Try that then do all the debugging you want ;)


     Ricardo
