Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8CGoEX13441
	for linux-mips-outgoing; Wed, 12 Sep 2001 09:50:14 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8CGoCe13438
	for <linux-mips@oss.sgi.com>; Wed, 12 Sep 2001 09:50:12 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 69D9A125C3; Wed, 12 Sep 2001 09:50:11 -0700 (PDT)
Date: Wed, 12 Sep 2001 09:50:11 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Sun, Lei" <lsun@3eti.com>
Cc: "'Zhang Fuxin'" <fxzhang@ict.ac.cn>, linux-mips@oss.sgi.com
Subject: Re: RE: _gp_disp
Message-ID: <20010912095011.A4551@lucon.org>
References: <32CC5B62AF0BD2119E4C00A0C9663E226F8E29@MAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <32CC5B62AF0BD2119E4C00A0C9663E226F8E29@MAIL>; from lsun@3eti.com on Wed, Sep 12, 2001 at 12:48:57PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Sep 12, 2001 at 12:48:57PM -0400, Sun, Lei wrote:
> Hi:
>   Unfortunately, make clean didn't work, the linking problem still sit
> there!
> 

Please check the kernel source how to build the mips kernel modules.

# make modules

should give you a clue.


H.J.
