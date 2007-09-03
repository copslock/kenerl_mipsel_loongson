Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2007 23:13:21 +0100 (BST)
Received: from hu-out-0506.google.com ([72.14.214.229]:64530 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20024418AbXICWNN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Sep 2007 23:13:13 +0100
Received: by hu-out-0506.google.com with SMTP id 31so1444047huc
        for <linux-mips@linux-mips.org>; Mon, 03 Sep 2007 15:12:55 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Y6mvfxamaLdwgw+/6t4/vd3oPKoGFwOT6scAXqZKIOvoruK0wQuhaglRXB9oP9FIlWOTV12xGwBGaSzAyundfn0R0tFxM3GPpdprUlQwxW5LgkkbSE9J11clC73Jr55e7hXEbyeju3gUILyHZbfJxokefU1+WoegBwz8y24ixTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=szJDdRUHS0RDPwHsPZIdDQ9gtRhhsLr5PK5RBxCgBnSJCeaII5LG/nka3TvikKkj3YSy0naokcPt+/5gH0IcGWXM6il0gkH5zQRl+/bZ3iZ3f2AR1g5iegBd8uaOR8apYlik7644IeMt9qMzcsRlJpGO9biFPj0Q+Mjo7ctkFs0=
Received: by 10.70.73.12 with SMTP id v12mr8667973wxa.1188857573313;
        Mon, 03 Sep 2007 15:12:53 -0700 (PDT)
Received: from raver.cocorico ( [87.11.114.203])
        by mx.google.com with ESMTPS id i16sm3767608wxd.2007.09.03.15.12.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Sep 2007 15:12:52 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/7] AR7: core support
Date:	Tue, 4 Sep 2007 00:12:49 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070824.704228)
References: <40101cc30709030623r4fb2d3caw146fa6dec16b283e@mail.gmail.com> <20070903150444.GC29574@networkno.de>
In-Reply-To: <20070903150444.GC29574@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709040012.49538.technoboy85@gmail.com>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Il Monday 03 September 2007 17:04:44 hai scritto:
> > +static int gcd(int x, int y)
> > +{
> > +	if (x > y)
> > +		return (x % y) ? gcd(y, x % y) : y;
> > +	return (y % x) ? gcd(x, y % x) : x;
> > +}
> > +
> > +static inline int ABS(int x)
> > +{
> > +	return (x >= 0) ? x : -x;
> > +}
>
> Isn't that already available in the generic kernel code?

abs() is, but gcd() is not globally accessible. Should I copy it from the non 
recursive from other kernel code?

Matteo
