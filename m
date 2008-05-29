Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2008 01:24:51 +0100 (BST)
Received: from p549F5155.dip.t-dialin.net ([84.159.81.85]:62128 "EHLO
	p549F5155.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20046013AbYE2IWM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 May 2008 09:22:12 +0100
Received: from yw-out-1718.google.com ([74.125.46.157]:29788 "EHLO
	yw-out-1718.google.com") by lappi.linux-mips.net with ESMTP
	id S1105838AbYE2GZz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 May 2008 08:25:55 +0200
Received: by yw-out-1718.google.com with SMTP id 9so1781655ywk.24
        for <linux-mips@linux-mips.org>; Wed, 28 May 2008 23:25:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YZUP72awik3Ta9l/m/RLf/XopbUh+VLLzGkUYDl3tUw=;
        b=sBY4rI9L7RsYRyV1jOZnXRs4CMN4Z/QV87TC2/3x5nXy2+afovzdqQAL6JYN4jZOeHSjdDIkfJux4BXDsnfjpG3xOirTGPGhdOBfFALgIfrXmk6d3xNzv1Y6nhE6ZYMWUkAm/EU1og0+QMtwXWW9CMNVPp3JS2HMAD8bC+CZusQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IMuIQRKqiLZgquqikxftmqF4pZXddzXK32c8K0jLPni3O5PTQWbgo+JEGXSqygN09l3LCIRwm/JlrTi9Ek/So/MU7dZU2B4bJF4aPpP9GTlE51o4S2apqT/gLr834giT8iH42gaFQZv2Ysh7m+Fv5cE8rNZ70+a8Lx3rUax1U0Q=
Received: by 10.150.83.22 with SMTP id g22mr6012721ybb.140.1212042330006;
        Wed, 28 May 2008 23:25:30 -0700 (PDT)
Received: by 10.150.140.6 with HTTP; Wed, 28 May 2008 23:25:29 -0700 (PDT)
Message-ID: <90edad820805282325l41ac4f50sb35e89f5cb1287c4@mail.gmail.com>
Date:	Thu, 29 May 2008 09:25:29 +0300
From:	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>
To:	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: Re: Malta build errors with 2.6.26-rc1
Cc:	"Martin Michlmayr" <tbm@cyrius.com>, linux-mips@linux-mips.org
In-Reply-To: <20080528085033.GA6250@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080512163107.GA19052@deprecation.cyrius.com>
	 <90edad820805121246o328d1cdaide88594ce9d328b7@mail.gmail.com>
	 <20080528071240.GB10393@deprecation.cyrius.com>
	 <20080528085033.GA6250@alpha.franken.de>
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

> I didn't fix the problems above. The change to traps.c only fixes
> traps.c for 64bit builds and it's a totally different issue. Looking
> at the warning/errors someone needs to fix some data types and use
> CKSEG0ADDR(). I don't have the hardware, so I could only provide
> an untested patch, if no one else steps forward...

Please provide an untested patch. I have hardware here, so I can
perform the test for you.

Thanks,
Dmitri

>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessary a
> good idea.                                                [ RFC1925, 2.3 ]
>
