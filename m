Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Feb 2003 03:56:21 +0000 (GMT)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:3817
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225205AbTB1D4U>; Fri, 28 Feb 2003 03:56:20 +0000
Received: from pudding.montavista.co.jp ([10.200.0.40])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id h1S43744031277;
	Fri, 28 Feb 2003 13:03:07 +0900
Date: Fri, 28 Feb 2003 12:50:16 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: yoichi_yuasa@montavista.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: Change -mcpu option for VR41xx
Message-Id: <20030228125016.4fc89c3f.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <Pine.GSO.3.96.1030227140134.19733F-100000@delta.ds2.pg.gda.pl>
References: <20030227213707.5d8eb02a.yoichi_yuasa@montavista.co.jp>
	<Pine.GSO.3.96.1030227140134.19733F-100000@delta.ds2.pg.gda.pl>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

On Thu, 27 Feb 2003 14:07:21 +0100 (MET)
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:

> On Thu, 27 Feb 2003, Yoichi Yuasa wrote:
> 
> > >  Ah, I see how it happens now -- "-mipsN" has a higher priority than
> > > "-mcpu=" (but lower than "-march=") so in this case "-mips2" overrides
> > > "-mcpu=vr4100".  How about:
> > > 
> > > GCCFLAGS	+= -mcpu=vr4100 -Wa,--trap
> > > 
> > > then?
> > 
> > That is fine.
> > However, the following warning is displayed.
> > 
> > Warning: The -mcpu option is deprecated.  Please use -march and -mtune instead.
> 
>  Does is disappear with "-m4100"?

Yes it does.

>  That would be strange.  And "-mcpu=" is
> indeed deprecated, but it works for most versions and "-march=" and
> "-mtune=" are too new to be used by everyone.  But as I wrote, we will end
> with a test for these options eventually as "-mcpu=" is already removed
> from the trunk.  As a result the warning will disappear.

binutils-2.12.90.0.1/gas/config/tc-mips.c has a following part.

  if (mips_arch == CPU_UNKNOWN && mips_cpu != CPU_UNKNOWN)
    {
      ci = mips_cpu_info_from_cpu (mips_cpu);
      assert (ci != NULL);
      mips_arch = ci->cpu;
      as_warn (_("The -mcpu option is deprecated.  Please use -march and "
                 "-mtune instead."));
    }

When I set up following GCCFLAGS,

GCCFLAGS	+= -mcpu=vr4100 -Wa,--trap

the mips_arch is CPU_UNKNOWN and the mips_cpu is CPU_VR4100.
The gas print out warnning.

Yoichi
