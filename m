Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2005 14:21:27 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.199]:52012 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3465666AbVJENVK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Oct 2005 14:21:10 +0100
Received: by zproxy.gmail.com with SMTP id j2so95318nzf
        for <linux-mips@linux-mips.org>; Wed, 05 Oct 2005 06:20:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WTCNu1jze6HvHhxT1/om2R18JfKQ2CdOQX3kunIVPlgUYFW1+q+v/d/tixasiwIMfXsSTUnMBk7f1BU04PXVjaZdetDX/hxOaYTeDGOx8BxsnalBuaIjDu/x1ghQ8wk5whX2evUqP1ZySf6jM4fnAUSOepW0BLUH+uJ20aqowHs=
Received: by 10.36.252.78 with SMTP id z78mr520494nzh;
        Wed, 05 Oct 2005 06:20:59 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Wed, 5 Oct 2005 06:20:59 -0700 (PDT)
Message-ID: <cda58cb80510050620m693040e0o@mail.gmail.com>
Date:	Wed, 5 Oct 2005 15:20:59 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: [PATCH] Add support for 4KS cpu.
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <4343A0FE.9080808@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80510040149p690397afo@mail.gmail.com>
	 <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>
	 <434277D5.1090603@mips.com>
	 <cda58cb80510050000r1baea5c7k@mail.gmail.com>
	 <4343A0FE.9080808@mips.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2005/10/5, Kevin D. Kissell <kevink@mips.com>:
> I'm personally not a big believer in security-through-obscurity,
> but there are those, both inside and outside MIPS, who felt that
> the security of SmartMIPS cores would be enhanced if we didn't
> give away all of the details.  As a consequence, we put off
> publishing the nitty-gritty details of SmartMIPS for quite a while.
> I note that we now have the programmers' manual on-line at www.mips.com,
> so I guess I'm implicitly cleared to discuss it in at least that level
> of detail.
>

well, I agree with you on "security-through-obscurity" point. From
outside, I feel like MIPS has a lot of things to _hide_ athough that's
not a good feeling for security systems. Anyways...

> A key element of SmartMIPS that allows for a ~2x speedup for
> crypto codes that rely on extended precision math (RSA, ECC)
> is the combination of an extension to the Hi/Lo accumulator
> (called "ACX") with a special extract-and-reduce instruction
> ("MFLHXU").  If one wants to use that in Linux - or at least,
> if one wants to allow more than one thread to be able to use
> it at a time - one needs to save/restore ACX on the kernel
> stackframe, along with Hi and Lo.
>

Correct. I must at least add this in the patch. I'll do it soon.

Thanks for enlight this.
--
               Franck
