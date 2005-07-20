Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jul 2005 10:18:38 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.205]:20654 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8224904AbVGTJSV> convert rfc822-to-8bit;
	Wed, 20 Jul 2005 10:18:21 +0100
Received: by zproxy.gmail.com with SMTP id 14so1383568nzn
        for <linux-mips@linux-mips.org>; Wed, 20 Jul 2005 02:20:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kJezhNdbiNJTXfvF6AvuJMv/yd2rJfzheZLKMMkiclJ/5oEgBzjTIxrc085L7cLkRCsCMr0XchL4LHkiiY48bKXHZ60W6Wltm/JoiTp/DC+olufnnWP0T5pKwEVrAmpPefV3F4WbjqFom87nB4z7JciOHtDA5WN71PsXHAuDZ4A=
Received: by 10.36.132.20 with SMTP id f20mr13550nzd;
        Wed, 20 Jul 2005 02:19:40 -0700 (PDT)
Received: by 10.36.47.11 with HTTP; Wed, 20 Jul 2005 02:19:40 -0700 (PDT)
Message-ID: <f07e6e05072002197b529b72@mail.gmail.com>
Date:	Wed, 20 Jul 2005 14:49:40 +0530
From:	Kishore K <hellokishore@gmail.com>
Reply-To: Kishore K <hellokishore@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: bal instruction in gcc 3.x
Cc:	Pete Popov <ppopov@embeddedalley.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <Pine.LNX.4.61L.0507200955390.30702@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <f07e6e05071909301c212ab4@mail.gmail.com>
	 <20050719164427.GB8758@linux-mips.org>
	 <f07e6e05071910194bab9b16@mail.gmail.com>
	 <1121802786.7285.88.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0507200955390.30702@blysk.ds.pg.gda.pl>
Return-Path: <hellokishore@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hellokishore@gmail.com
Precedence: bulk
X-list: linux-mips

On 7/20/05, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Tue, 19 Jul 2005, Pete Popov wrote:
> 
> > Try the attached patch instead.
> 
>  Apart from other changes why not simply s/bal/jal/?  Your proposed code
> is bad if ever to be built to a 64-bit object.
> 
In the case of s/bal/jal, I get the warning "No .cprestore pseudo-op
used in PIC code".
Is it safe to ignore this warning ?

On the other hand, if I replace 

bal jump_to_label   

by 

la t9, jump_to_label
jalr t9

I don't see any warning. What could be the reason ?

Can you suggest, what should be done to make the code safe for
building on 64 bit processor.

--kishore
