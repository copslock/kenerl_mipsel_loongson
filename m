Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78EHIg04956
	for linux-mips-outgoing; Wed, 8 Aug 2001 07:17:18 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78EHHV04951
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 07:17:17 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id A0A05125C3; Wed,  8 Aug 2001 07:17:16 -0700 (PDT)
Date: Wed, 8 Aug 2001 07:17:16 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Eric Christopher <echristo@redhat.com>
Cc: gcc-patches@gcc.gnu.org, linux-mips@oss.sgi.com
Subject: Re: PATCH: Clean up Linux/mips.
Message-ID: <20010808071716.A26704@lucon.org>
References: <20010807084236.A5550@lucon.org> <997278707.1290.41.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <997278707.1290.41.camel@ghostwheel.cygnus.com>; from echristo@redhat.com on Wed, Aug 08, 2001 at 02:51:45PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 02:51:45PM +0100, Eric Christopher wrote:
> Ok, with one question:
> 
> > 	* config/mips/little.h: New. Generic little endian mips
> > 	targets.
> 
> Did you convert the other *el ports to use this?  It doesn't look like
> it.

No. I will let their maintainers decide what to do. Personally, I think they
should use it :-(. But it may require additional changes.


H.J.
