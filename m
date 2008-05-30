Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2008 14:02:58 +0100 (BST)
Received: from p549F7A8A.dip.t-dialin.net ([84.159.122.138]:45770 "EHLO
	p549F7A8A.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20022524AbYE3NCz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 May 2008 14:02:55 +0100
Received: from yx-out-1718.google.com ([74.125.44.158]:14524 "EHLO
	yx-out-1718.google.com") by lappi.linux-mips.net with ESMTP
	id S1109673AbYE3MtL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 May 2008 14:49:11 +0200
Received: by yx-out-1718.google.com with SMTP id 36so393687yxh.24
        for <linux-mips@linux-mips.org>; Fri, 30 May 2008 05:48:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sN9He74Rspjf0K6WlCe6GlcU+HZFUNQ3C0afQrK6S3w=;
        b=FGmH/TC0lUpx22HkUy0Segtn83XtvoA23nai1i9BTxjr5ijBq/MQLY3vvIYP3WgGZTm0IEMqwmrJ4gzuTWoaHY6qx99H5DH0jsB2BLqyYGXfvva0BKTEKJBN1FQ3sEyrvL7Gh+Z/jzo1gjUSg9fWK7jj3Ghg2cfOVdrUsY9eJfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=etR8Rol4jUJtCqOryjsYlSBPV1ommirbevJSkTmdPi5P2Ej09o587JCEpE3nnyPXwtQ6E+j35j06MGHOpeB7C98AU505XQPxWRRTg/CL5NeHTHrgeG9T2qDJhYC8F8DITYLBjjdYpbRGW6ftkjLcwrC+4grArg6/8aW30tkUB24=
Received: by 10.150.78.41 with SMTP id a41mr6301290ybb.181.1212151728304;
        Fri, 30 May 2008 05:48:48 -0700 (PDT)
Received: by 10.150.140.6 with HTTP; Fri, 30 May 2008 05:48:48 -0700 (PDT)
Message-ID: <90edad820805300548l63765258jd21493b8f2318f95@mail.gmail.com>
Date:	Fri, 30 May 2008 15:48:48 +0300
From:	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>, ralf@linux-mips.org
Subject: Re: Malta build errors with 2.6.26-rc1
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080528071240.GB10393@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080512163107.GA19052@deprecation.cyrius.com>
	 <90edad820805121246o328d1cdaide88594ce9d328b7@mail.gmail.com>
	 <20080528071240.GB10393@deprecation.cyrius.com>
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

> Is there a maintainer for Malta?

Well, I think I can volunteer. At least, I have the hardware and am
pretty much interested in working with this platform. Ralf, what do
you think?

Dmitri

> --
> Martin Michlmayr
> http://www.cyrius.com/
>
