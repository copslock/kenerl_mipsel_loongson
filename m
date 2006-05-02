Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 18:48:56 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.192]:51781 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133753AbWEBRsm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 May 2006 18:48:42 +0100
Received: by nz-out-0102.google.com with SMTP id j2so2633104nzf
        for <linux-mips@linux-mips.org>; Tue, 02 May 2006 10:48:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oTjLmKCpqcD6oGOvHoem4f48R6jemjA/EVSeVO4qDzUqbNU6clrcMK+i9O/jWsIXqJ4IqJMysgLJ9AvC7vwRY/T1jYK5Bcd/lNJ4cRgssPH3fqKh1Iy9NgycYJ1FGjkw1YxUKwzlEPYDkDnFztjM6oV6S4cXdo1CJ4EXbmX7kw8=
Received: by 10.36.118.9 with SMTP id q9mr1718173nzc;
        Tue, 02 May 2006 10:48:38 -0700 (PDT)
Received: by 10.36.49.2 with HTTP; Tue, 2 May 2006 10:48:38 -0700 (PDT)
Message-ID: <cda58cb80605021048n14ec2aa5ldd27e0f9a6fceb8e@mail.gmail.com>
Date:	Tue, 2 May 2006 19:48:38 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Thiemo Seufer" <ths@networkno.de>
Subject: Re: [PATCH] Make interrupt handler works for all cases
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20060502104441.GA5004@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80605020055r2597bf3ds9fb380aab8cbf7b3@mail.gmail.com>
	 <20060502094123.GB4301@linux-mips.org>
	 <cda58cb80605020330hfd0352ds11f7f80603092cde@mail.gmail.com>
	 <20060502104441.GA5004@networkno.de>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/5/2, Thiemo Seufer <ths@networkno.de>:
> Franck Bui-Huu wrote:
> > 2006/5/2, Ralf Baechle <ralf@linux-mips.org>:
> > >On Tue, May 02, 2006 at 09:55:51AM +0200, Franck Bui-Huu wrote:
> > >
> > >> specially when the kernel is mapped.
> > >
> > >At which time you're on very fragile ice because TLB instructions should
> > >better be executed from an unmapped address ...
> > >
> >
> > well TLB entry used by the kernel is wired, so it should work fined,
> > shouldn't it ?
>
> The architecture spec doesn't guarantee it will.
>

having a quick look at the TLB handling code, it seems that the code
assumes it will...

--
               Franck
