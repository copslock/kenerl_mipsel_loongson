Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FGRwK26674
	for linux-mips-outgoing; Fri, 15 Feb 2002 08:27:58 -0800
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FGRi926670;
	Fri, 15 Feb 2002 08:27:45 -0800
Received: from js by hell with local (Exim 3.33 #1 (Debian))
	id 16bkGv-0002Is-00; Fri, 15 Feb 2002 16:27:37 +0100
Date: Fri, 15 Feb 2002 16:27:37 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Adrian.Hulse@taec.toshiba.com, linux-mips@oss.sgi.com
Subject: Re: Tools issue
Message-ID: <20020215152737.GA8809@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Ralf Baechle <ralf@oss.sgi.com>, Adrian.Hulse@taec.toshiba.com,
	linux-mips@oss.sgi.com
References: <OF7ACD949C.CF1ABCAF-ON88256B60.00728091@taec.com> <20020215034958.C21011@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020215034958.C21011@dea.linux-mips.net>
User-Agent: Mutt/1.3.27i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 15, 2002 at 03:49:58AM +0100, Ralf Baechle wrote:
> On Thu, Feb 14, 2002 at 01:42:31PM -0800, Adrian.Hulse@taec.toshiba.com wrote:
> 
> > int-handler.s:59: Error: missing ')'
> > int-handler.s:59: Error: illegal operands `lui'
> > int-handler.s:60: Error: missing ')'
> > int-handler.s:60: Error: illegal operands `sb'
> > make[1]: *** [ int-handler.o ] Error 1 
...
> > int-handler.S
> > <l59>     lui  t1, %hi(TSDB_LED_ADDR)
> > <l60>     sb   t0, %lo(TSDB_LDE_ADDR)(t1)
> > 
> > Failed define :
> > #define   TSDB_LED_ADDR  (KSEG1 + TSDB_LB_PCU_APERTURE + 0x05100020)
> > 
> > Compilable define :
> > #define   TSDB_LED_ADDR  KSEG1 + TSDB_LB_PCU_APERTURE + 0x05100020
...
> > Anyone else seen anything like this and know of a solution to the problem ?
> > Or to paraphrase Dominic Sweetman, maybe i should just stay with the "pick
> > your own version folklore" method of picking tools :).

I had a similar problem with binutils-2.11.92.0.12.3, but
Thiemo Seufer posted a patch on the binutils mailing list.
Should be fixed in binutils CVS.
It seems that it worked with the binutils-2.10.91.0.2 recommended
here: http://www.junsun.net/linux/porting-howto/

> I hope that for binutils we can solve that problem when 2.9.12 gets
> released; as for gcc it seems Maciej's 2.95.3 version is already pretty
> close to what we want.  C++ users may disagree ;-)  Somewhat longer term
> Algorithmics's toolchain should resolve the situation.

;-)

Regards,
Johannes
