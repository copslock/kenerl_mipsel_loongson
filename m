Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DFEru08746
	for linux-mips-outgoing; Thu, 13 Sep 2001 08:14:53 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DFEpe08743
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 08:14:51 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 7691C125C3; Thu, 13 Sep 2001 08:14:50 -0700 (PDT)
Date: Thu, 13 Sep 2001 08:14:50 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Update for RedHat 7.1
Message-ID: <20010913081450.B24910@lucon.org>
References: <20010907230009.A1705@lucon.org> <3BA0CB8D.ED5AB42B@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA0CB8D.ED5AB42B@mips.com>; from carstenl@mips.com on Thu, Sep 13, 2001 at 05:06:53PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Sep 13, 2001 at 05:06:53PM +0200, Carsten Langgaard wrote:
> I now tried to installing the bigendian RedHat7.1 RPMs and I noticed the
> following.
> 
> /etc/localtime is lacking in glibc-2.2.4-11.2.mips.rpm (but it's contain
> in the little endian version).
> All the timezone information is lacking under /usr/share/zoneinfo in
> glibc-common-2.2.4-11.2 (but it's in the little endian version).

Everything is cross compiled. Since x86 is little endian, I don't
cross compile big endian data files, like locale and timezone. You
can rebuild glibc natively to get all those data files.

> 
> I can't changes the root password, I get the following:
> # passwd root
> Changing password for user root
> New UNIX password:
> /usr/lib/cracklib_dict: magic mismatch
> PWOpen: Success
> 

It may be the endian issue. Please recompile cracklib natively and let
me know if it fixes the problem for you.


H.J.
