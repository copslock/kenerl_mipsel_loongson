Received:  by oss.sgi.com id <S42249AbQIYUCh>;
	Mon, 25 Sep 2000 13:02:37 -0700
Received: from u-53.karlsruhe.ipdial.viaginterkom.de ([62.180.20.53]:3846 "EHLO
        u-53.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S42201AbQIYUCG>; Mon, 25 Sep 2000 13:02:06 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869558AbQIYQ2x>;
        Mon, 25 Sep 2000 18:28:53 +0200
Date:   Mon, 25 Sep 2000 18:28:53 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux-kernel@vger.kernel.org,
        SGI-MIPS List <linux-mips@oss.sgi.com>
Subject: Re: [patch] 2.4.0-test8: Alpha RTC clean-ups
Message-ID: <20000925182853.B9730@bacchus.dhis.org>
References: <20000922232950.A25561@lug-owl.de> <Pine.GSO.3.96.1000925112647.3247A-100000@delta.ds2.pg.gda.pl> <20000925125006.B28011@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000925125006.B28011@lug-owl.de>; from jbglaw@lug-owl.de on Mon, Sep 25, 2000 at 12:50:06PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Sep 25, 2000 at 12:50:06PM +0200, Jan-Benedict Glaw wrote:

> On Mon, Sep 25, 2000 at 11:35:35AM +0200, Maciej W. Rozycki wrote:
> > On Fri, 22 Sep 2000, Jan-Benedict Glaw wrote:
> > 
> > > Instead of having hard-coded values, we should maybe do something
> > > more variable like:
> > >  if (year >= (20 + YEARS_SINCE_2000) && year < (48 + YEARS_SINCE_2000)
> > > 	...
> > 
> >  This looks reasonable.
> > 
> > > This applies to other platforms using different epoch vaules as
> > > well, of course...
> > 
> >  Alpha appears to be the only one.
> 
> ./driver/char/rtc.c:rtc_init()
> #if defined(__alpha__) || defined(__mips__)
> [...]
> 
> MIPS does that as well _in the wrong way_ compared to rtc.c:
> ./arch/mips/dev/time.c:time_init()
>     /*
>      * The DECstation RTC is used as a TOY (Time Of Year).
>      * The PROM will reset the year to either '70, '71 or '72.
>      * This hack will only work until Dec 31 2001.
>      */
>     year += 1928;

This has already been fixed.  In any case the DECstation RTC stuff is so
weird, don't try to explain it rationally ...

> Fehler eingestehen, Größe zeigen: Nehmt die Rechtschreibreform zurück!!!

Rechtschreibdeformation ...

  Ralf
