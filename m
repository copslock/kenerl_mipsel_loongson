Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78EZCM07073
	for linux-mips-outgoing; Wed, 8 Aug 2001 07:35:12 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78EZBV07056
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 07:35:11 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id D07D0125C3; Wed,  8 Aug 2001 07:35:09 -0700 (PDT)
Date: Wed, 8 Aug 2001 07:35:09 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Eric Christopher <echristo@redhat.com>, mark@codesourcery.com
Cc: gcc-patches@gcc.gnu.org, linux-mips@oss.sgi.com
Subject: Re: PATCH: Clean up Linux/mips.
Message-ID: <20010808073509.A26983@lucon.org>
References: <20010807084236.A5550@lucon.org> <997278707.1290.41.camel@ghostwheel.cygnus.com> <20010808071716.A26704@lucon.org> <997280370.1290.43.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <997280370.1290.43.camel@ghostwheel.cygnus.com>; from echristo@redhat.com on Wed, Aug 08, 2001 at 03:19:28PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 03:19:28PM +0100, Eric Christopher wrote:
> 
> > 
> > No. I will let their maintainers decide what to do. Personally, I think they
> > should use it :-(. But it may require additional changes.
> > 
> 
> *sigh* That'd be me then.  Ok.  Make sure your changelog entry states
> that mipsel*-linux-* is the only one using it then.
> 

I changed it to

        * config/mips/little.h: New. Generic little endian mips
        targets. Only mips*-*-linux* is converted to use it so far. 

BTW, let me know if it is ok to check in. Also, I'd like to check it
into gcc 3.0.1 if it is approved for the trunk.

Thanks.


H.J.
