Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2007 02:14:41 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.227]:49280 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021982AbXGZBOi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jul 2007 02:14:38 +0100
Received: by nz-out-0506.google.com with SMTP id n1so297197nzf
        for <linux-mips@linux-mips.org>; Wed, 25 Jul 2007 18:14:20 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gdb8ccS3vv9MLm9VtSgMBjw5LCm3wbylYzel2EE8gEwSVEGJJECGPQ1Ftz2wOg8EltmQY9GHwt1MJfLXPYATXJTYS5/vZzHRRyYYDZiE72OQ3+R4cMY5TdgLyYXIEuluPsECW3tCQb/+c2rVE6ZGUBVbNS0uvVwIBs7zwhFXJwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R+HwjWLgcG2QVbZ5AQgrZ6rimpMD7cY7QHEXHQ64PZbYIuN95eIs9wxUnNV52fmWacA6NR4A2mxB7dbt0pXgsiDmtiAvn7fnJF17bWIk+Oqr2oARuEO3iEB/AgVyqmIryjlxo90RwCt5byotUg9P8X2c4QfQ8ls3tjO1xuns5Nw=
Received: by 10.114.209.1 with SMTP id h1mr1209612wag.1185412459970;
        Wed, 25 Jul 2007 18:14:19 -0700 (PDT)
Received: by 10.114.67.6 with HTTP; Wed, 25 Jul 2007 18:14:14 -0700 (PDT)
Message-ID: <5861a7880707251814q4b6876a1u4291d068e201488c@mail.gmail.com>
Date:	Thu, 26 Jul 2007 05:14:14 +0400
From:	"Dajie Tan" <jiankemeng@gmail.com>
To:	"John Levon" <levon@movementarian.org>
Subject: Re: [PATCH] Add support for profiling Loongson 2E
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>, phil.el@wanadoo.fr,
	oprofile-list@lists.sourceforge.net
In-Reply-To: <20070725125235.GD8454@totally.trollied.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5861a7880707240220g5d8129anc95e10bea833e323@mail.gmail.com>
	 <20070724144051.GA17256@linux-mips.org>
	 <5861a7880707242041w32811dal6e2765747cbada32@mail.gmail.com>
	 <20070725125235.GD8454@totally.trollied.org.uk>
Return-Path: <jiankemeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiankemeng@gmail.com
Precedence: bulk
X-list: linux-mips

2007/7/25, John Levon <levon@movementarian.org>:
> On Wed, Jul 25, 2007 at 07:41:21AM +0400, Dajie Tan wrote:
>
> > >Why do you need this change?  It almost looks as if you're papering over
> > >a bug where add_sample should not be called at all.
> >
> > Yeah,this change is to enhance the robust of oprofile. When using
> > performace counter manually(writting control register in a module, no
> > need to use the oprofile),I usually make kernel panic if I do not
> > initialize the oprofile and enable the overflow interrupt carelessly.
> > So, this change can avoid this panic. :D
>
> This panic is good and should stay. It shows that you've made a mistake.
>
> john
>

This panic is caused by accessing a null pointer.Do you think that
accessing a null
pointer is allowed in a robust system ?
