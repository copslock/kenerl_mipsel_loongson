Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2HHdQ629530
	for linux-mips-outgoing; Sat, 17 Mar 2001 09:39:26 -0800
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2HHdPM29527
	for <linux-mips@oss.sgi.com>; Sat, 17 Mar 2001 09:39:25 -0800
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id AB552109CE; Sat, 17 Mar 2001 09:39:47 -0800 (PST)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 1F81A1F429; Sat, 17 Mar 2001 09:39:20 -0800 (PST)
Date: Sat, 17 Mar 2001 09:39:19 -0800
From: Keith M Wesolowski <wesolows@foobazco.org>
To: David Jez <dave.jez@seznam.cz>
Cc: Karel van Houten <K.H.C.vanHouten@kpn.com>, linux-mips@oss.sgi.com
Subject: Re: rpm crashing on RH 7.0 indy
Message-ID: <20010317093919.A19754@foobazco.org>
References: <200103171051.LAA04852@pandora.research.kpn.com> <20010317164726.B86495@stud.fee.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010317164726.B86495@stud.fee.vutbr.cz>; from dave.jez@seznam.cz on Sat, Mar 17, 2001 at 04:47:26PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Mar 17, 2001 at 04:47:26PM +0100, David Jez wrote:

> > This is a static rpm binary, so I don't understand why it tries
> > do dynaload anything at all...
>   Hi,
> 
> Ooops, i think: haven't you got broken rpm? Have you downloaded the rpm
> complete? Try checksum or md5.

That's not the problem.  The problem is that static binaries which use
libdl used to be (and perhaps still are) broken.  The reason it's
using libdl is that the nss libraries are never truly static, unless
you compile glibc with a special non-recommended option.  I have
indications that this may be fixed in glibc 2.2.2 using my current
toolchain, but my information is not complete.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
"I should have crushed his marketing-addled skull with a fucking bat."
