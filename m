Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6LHg3V26460
	for linux-mips-outgoing; Sat, 21 Jul 2001 10:42:03 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6LHfkV26452;
	Sat, 21 Jul 2001 10:41:46 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 6B50E125BA; Sat, 21 Jul 2001 10:41:44 -0700 (PDT)
Date: Sat, 21 Jul 2001 10:41:44 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Greg Satz <satz@ayrnetworks.com>, linux-mips@oss.sgi.com
Subject: Re: SHN_MIPS_SCOMMON
Message-ID: <20010721104144.A17894@lucon.org>
References: <20010721033019.A22637@bacchus.dhis.org> <B77EA5E8.883E%satz@ayrnetworks.com> <20010721141119.A25053@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010721141119.A25053@bacchus.dhis.org>; from ralf@oss.sgi.com on Sat, Jul 21, 2001 at 02:11:20PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 21, 2001 at 02:11:20PM +0200, Ralf Baechle wrote:
> Only if you don't compile / assemble / link with -G 0.
> 
> .scommon shouldn't ever be in a kernel object.  It seems that ld started
> to move .common objects to .scommon from a certain version on, so 2.4.5

Send me a testcase. I will fix the linker.


H.J.
