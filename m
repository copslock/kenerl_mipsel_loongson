Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 16:27:24 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.202]:17830 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133642AbWAZQ05 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 16:26:57 +0000
Received: by zproxy.gmail.com with SMTP id l8so405284nzf
        for <linux-mips@linux-mips.org>; Thu, 26 Jan 2006 08:31:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NyG0GsrtYNZW9ADr10xYmsQoWmESjgQgzkj941ybHG1+QST0C84h9brdojIbe/iwXNL4D2xfjYXQ7X7BvVzzujJQG71UXWHbpChAt1LzObOXiGiO6RNXo77/IFt12fEoNou2eiFEmlVywqq3uN77nYSmxmFow59yUr8QAhVkFYE=
Received: by 10.37.22.73 with SMTP id z73mr1588810nzi;
        Thu, 26 Jan 2006 08:31:27 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Thu, 26 Jan 2006 08:31:27 -0800 (PST)
Message-ID: <cda58cb80601260831i61167787g@mail.gmail.com>
Date:	Thu, 26 Jan 2006 17:31:27 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	Nigel Stephens <nigel@mips.com>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <43D8F000.9010106@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <43D78725.6050300@mips.com> <20060125141424.GE3454@linux-mips.org>
	 <cda58cb80601250632r3e8f7b9en@mail.gmail.com>
	 <20060125150404.GF3454@linux-mips.org>
	 <cda58cb80601251003m6ba4379w@mail.gmail.com>
	 <43D7C050.5090607@mips.com>
	 <cda58cb80601260702wf781e70l@mail.gmail.com>
	 <005101c6228c$6ebfb0a0$10eca8c0@grendel> <43D8F000.9010106@mips.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/26, Nigel Stephens <nigel@mips.com>:
>
>
> Kevin D. Kissell wrote:
>
> >Could you please post your mipsel-linux-gcc -v output?   It might help.
> >I've never tried building Linux with any of the Sc/Sd/SmartMIPS options,
> >so I really don't know what you could be experiencing.  One thought that
> >comes to mind is that the -march=4ksd option may be treated as a hint to
> >generate compact code (for smart cards) in a way that -march=mips32r2
> >is not.  I'll ask around...
> >
> >
>
> Assuming that this is the SDE compiler, then I think that the only

yes it is (see my previous post)

> significant thing which -march=4ksd will do differently from
> -march=mips32r2 is to allow the compiler to generate branch-likely
> instructions -- they're deprecated for generic mips32 code but carry no
> penalty on the 4K core. It will also cause the compiler's "4kc" pipeline
> description to be used for instruction scheduling, instead of the
> default "24kc", but that should only change the order of instructions

Do you mean that the code can be run faster when using -march=4ksd ?

> and shouldn't really make a significant difference to the code size.
>

yes but I have :(

Thanks
--
               Franck
