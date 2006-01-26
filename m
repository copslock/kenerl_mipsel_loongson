Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 14:58:23 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.197]:14105 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133530AbWAZO6F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 14:58:05 +0000
Received: by zproxy.gmail.com with SMTP id l8so380846nzf
        for <linux-mips@linux-mips.org>; Thu, 26 Jan 2006 07:02:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MqSGZrX4HUMSaSVYFOUzzDbWavfojgNq667PoElkNvxRdVspHgONLRFOuodjArL6xEnbwvSxbHJ1V+Dslb4MM2OL37utEossOlhlc7uAqdBp2KRC4D/RbRIzt2smczSWpWJGwxf79cM03xkz7YhPUB6qkj/g75jsJnq9jVwKmfk=
Received: by 10.36.128.5 with SMTP id a5mr1536426nzd;
        Thu, 26 Jan 2006 07:02:35 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Thu, 26 Jan 2006 07:02:35 -0800 (PST)
Message-ID: <cda58cb80601260702wf781e70l@mail.gmail.com>
Date:	Thu, 26 Jan 2006 16:02:35 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	linux-mips@linux-mips.org
In-Reply-To: <43D7C050.5090607@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <20060125124738.GA3454@linux-mips.org>
	 <cda58cb80601250534r5f464fd1v@mail.gmail.com>
	 <43D78725.6050300@mips.com> <20060125141424.GE3454@linux-mips.org>
	 <cda58cb80601250632r3e8f7b9en@mail.gmail.com>
	 <20060125150404.GF3454@linux-mips.org>
	 <cda58cb80601251003m6ba4379w@mail.gmail.com>
	 <43D7C050.5090607@mips.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Kevin

2006/1/25, Kevin D. Kissell <kevink@mips.com>:
> Not really.  As we discussed at the time, the 4KSc is a superset of
> MIPS32 which includes some, but not all MIPS32R2 features (plus other
> stuff), and the 4KSd is a strict superset of MIPS32R2.  So some additional
> information is required to express the desired support.  I was just pointing
> out, in the case of the SWAB optimizations, that there was no need to invent
> yet another way of describing MIPS32R2.
>

I'm trying to use CPU_MIPS32_R2 instead of CPU_4KD in order to get rid
of the last macro. So now to compile the kernel I'm using somthing
like:

        mipsel-linux-gcc -march=mips32r2 -Wa,-32 -Wa,-mips32r2 -msmartmips

instead of

        mipsel-linux-gcc -march=4ksd -Wa,-32 -Wa,-mips32r2 -msmartmips

Now the size of the kernel code is 33Ko bigger ! I have no idea
why...I tried to add -mips16e option but it fails to compile...Do you
have an idea ?

Thanks
--
               Franck
