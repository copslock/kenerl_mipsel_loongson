Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f5702MO00430
	for linux-mips-outgoing; Wed, 6 Jun 2001 17:02:22 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f5702Mh00426
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 17:02:22 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 74D1E125BA; Wed,  6 Jun 2001 17:02:21 -0700 (PDT)
Date: Wed, 6 Jun 2001 17:02:21 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Geoff Keating <geoffk@redhat.com>
Cc: binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: mips gas is horribly broken
Message-ID: <20010606170221.A30487@lucon.org>
References: <20010606091846.A21652@lucon.org> <200106061932.MAA01399@geoffk.org> <20010606131551.A25655@lucon.org> <200106062159.OAA01491@geoffk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106062159.OAA01491@geoffk.org>; from geoffk@geoffk.org on Wed, Jun 06, 2001 at 02:59:19PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 06, 2001 at 02:59:19PM -0700, Geoff Keating wrote:
> 
> First, redesign bfd_install_relocation so that it does the right thing
> (there are other cases where the bfd backends have to work around
> it).  Then, change all the users to match.  Then, test all the
> supported platforms.

Could you please tell me what you meant by "the right thing" and what
exactly is wrong with the current design? On mips, it is addend
which is handled incorrectly. Is this the only problem with
bfd_install_relocation?


H.J.
