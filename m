Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DFiIJ12295
	for linux-mips-outgoing; Wed, 13 Jun 2001 08:44:18 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DFiHP12292
	for <linux-mips@oss.sgi.com>; Wed, 13 Jun 2001 08:44:17 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 97FB5125BA; Wed, 13 Jun 2001 08:44:16 -0700 (PDT)
Date: Wed, 13 Jun 2001 08:44:16 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: A new mips toolchain is available
Message-ID: <20010613084416.A10334@lucon.org>
References: <20010613082417.C9739@lucon.org> <Pine.GSO.3.96.1010613173820.9854M-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010613173820.9854M-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jun 13, 2001 at 05:39:08PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 13, 2001 at 05:39:08PM +0200, Maciej W. Rozycki wrote:
> On Wed, 13 Jun 2001, H . J . Lu wrote:
> 
> > I don't have problem with 2.4.0-test11. It is the change in 2.4.3
> > which breaks glibc.
> 
>  You mean someone changed sysmips() in an incompatible way?  Aaarghh... 

I don't remeber the detail, it is eithet kernel crash or glibc crash.
I switched to mips II for glibc as the result.


H.J.
