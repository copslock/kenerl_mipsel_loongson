Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2005 11:15:40 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.198]:53850 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8226025AbVE0KPV> convert rfc822-to-8bit;
	Fri, 27 May 2005 11:15:21 +0100
Received: by zproxy.gmail.com with SMTP id 13so1390249nzp
        for <linux-mips@linux-mips.org>; Fri, 27 May 2005 03:15:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jy4nJr/yDJe+E1jiVaWCSxITziao/z6CWBsVGqakyU7dnxrn/iugAc65+hxikHEhwCTYTT0Ibmy5AK/2KSY3HAw/s7pci/SzoFO0aF2mbu4pY343IuA9T1JFeyNfQUnd5+KNRRN2ssqynWFR5sL9xXfZNXPJ5ju3B/bKfBF/z2Y=
Received: by 10.36.55.20 with SMTP id d20mr977475nza;
        Fri, 27 May 2005 03:15:13 -0700 (PDT)
Received: by 10.36.68.6 with HTTP; Fri, 27 May 2005 03:15:13 -0700 (PDT)
Message-ID: <6097c4905052703152b50f717@mail.gmail.com>
Date:	Fri, 27 May 2005 14:15:13 +0400
From:	Maxim Osipov <maxim.osipov@gmail.com>
Reply-To: maxim@mox.ru
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: glibc-2.3.4 mips64 compilation failure
Cc:	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.61L.0505261815330.29423@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <6097c4905052609326a4c1232@mail.gmail.com>
	 <20050526170603.GA13272@nevyn.them.org>
	 <Pine.LNX.4.61L.0505261815330.29423@blysk.ds.pg.gda.pl>
Return-Path: <maxim.osipov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxim.osipov@gmail.com
Precedence: bulk
X-list: linux-mips

Hmm... I don't know. Both 2.4.26 and 2.6.10 headers do not contain
this call number in unistd.h for N64, but glibc tries to generate a
stub referencing to undefined __NR_sendfile64, and I got this
assembler error.

I tried various kernel/glibc configurations and result is the same -
we fail on sendfile64 or time.

Do anyone have a clue what is happening? AFAIK, some people already
had success building glibc for mips64. Probably I miss something?

Best regards,
Maxim


On 5/26/05, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Thu, 26 May 2005, Daniel Jacobowitz wrote:
> 
> > > I am trying to build glibc-2.3.4 using binutils-2.15 and gcc-3.4.3
> > > from ftp://ftp.linux-mips.org/pub/linux/mips/crossdev/i386-linux/mips64-linux.
> > > Compilation fails with following messages:
> >
> > Looks like your kernel headers are too old.
> 
>  Or too new, sigh...  See:
> "http://sources.redhat.com/bugzilla/show_bug.cgi?id=758".  Unfortunately
> it's not clear to me what "the 2.3 branch inclusion criteria" are and it's
> a pity the MIPS port of glibc is unmaintained these days...
> 
>   Maciej
> 
>
