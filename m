Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2007 14:49:31 +0000 (GMT)
Received: from rv-out-0910.google.com ([209.85.198.191]:1428 "EHLO
	rv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20026665AbXKMOtX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Nov 2007 14:49:23 +0000
Received: by rv-out-0910.google.com with SMTP id l15so1205225rvb
        for <linux-mips@linux-mips.org>; Tue, 13 Nov 2007 06:49:17 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yf4RU0KmsKQvklRVXHk4ecXqABOIXjXK9TqO0vcmzwk=;
        b=tjIe/iLwc+BCiUM40lr6eDOfv9Ug3axzAeJMWCJGMlsexGtxNJvrBtcKGfAzIZc/KZ3N6n1qlUqYnV8eazvC8Om7yGX8xzTDN0awJqjBQU4QySU6N0zYnLEF3PcF+R2+Ib6S8Wod/yjSBQD+lZtsaz5VU4rTvYCQf6SDOsDcdG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fe855liofhW+SW5dhlSq+zSLEr+v8sdcsamlBdAcvMLTEnGtJdcHMVeohhhLuSKXUtw6RHNtMeH2JEL2te+bMTnsl7nGQKi7WPP2cv8p+JzeTgUmJGmKzja+PG9gl9qmt9+MaLRpuUdtlkAMwBW/d1FQlxLZEc/TaYbIxCRxr/E=
Received: by 10.140.186.20 with SMTP id j20mr2850281rvf.1194965357094;
        Tue, 13 Nov 2007 06:49:17 -0800 (PST)
Received: by 10.35.80.12 with HTTP; Tue, 13 Nov 2007 06:49:16 -0800 (PST)
Message-ID: <cda58cb80711130649k7d215aefh37989712f0c6e30c@mail.gmail.com>
Date:	Tue, 13 Nov 2007 15:49:16 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: Cannot unwind through MIPS signal frames with ICACHE_REFILLS_WORKAROUND_WAR
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Andrew Haley" <aph-gcc@littlepinkcloud.com>,
	"David Daney" <ddaney@avtrex.com>, linux-mips@linux-mips.org,
	"Richard Sandiford" <rsandifo@nildram.co.uk>, gcc@gcc.gnu.org
In-Reply-To: <019e01c82602$f5463bf0$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <473957B6.3030202@avtrex.com>
	 <18233.36645.232058.964652@zebedee.pink>
	 <20071113121036.GA6582@linux-mips.org>
	 <cda58cb80711130514x16356ea3x4069616c9ee3caac@mail.gmail.com>
	 <019e01c82602$f5463bf0$10eca8c0@grendel>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On Nov 13, 2007 3:37 PM, Kevin D. Kissell <kevink@mips.com> wrote:
> Franck a dit:
> > > Another reason is to get rid of the classic trampoline the kernel installs
> > > on the stack.  On some multiprocessor systems it requires a cacheflush
> > > operation to be performed on all processors which is expensive.  Having
> > > the trampoline in a vDSO would solve that.
> > >
> >
> > And the stack wouldn't need to have exec permission anymore.
>
> True, though it should perhaps be noted that currently it's only on 4KSc/Sd
> systems (which I know you work on) where it's even possible for the stack
> *not* to have exec permissions, since the classical MIPS MMU gives
> execute permission to any page that is readable.
>

Well, the noexec stack is pretty usefull I think. I can't believe it
will be limited to these 2 systems in the near future...

-- 
               Franck
