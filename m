Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3K8H9814734
	for linux-mips-outgoing; Fri, 20 Apr 2001 01:17:09 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3K8H7M14730
	for <linux-mips@oss.sgi.com>; Fri, 20 Apr 2001 01:17:07 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 1F7FB7F7; Fri, 20 Apr 2001 10:17:05 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id B7685F383; Fri, 20 Apr 2001 10:16:33 +0200 (CEST)
Date: Fri, 20 Apr 2001 10:16:33 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Dave Gilbert <gilbertd@treblig.org>
Cc: Guido Guenther <guido.guenther@gmx.net>, linux-mips@oss.sgi.com
Subject: Re: Passing kernel args
Message-ID: <20010420101633.A8281@paradigm.rfc822.org>
References: <20010419224030.A19856@bilbo.physik.uni-konstanz.de> <Pine.LNX.4.10.10104192336540.894-100000@tardis.home.dave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.10.10104192336540.894-100000@tardis.home.dave>; from gilbertd@treblig.org on Thu, Apr 19, 2001 at 11:45:08PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Apr 19, 2001 at 11:45:08PM +0100, Dave Gilbert wrote:
>     So if you:
> 
>        setenv OSLoadOptions "root=/dev/sda1 ro"
> 
>     The kernel actually sees:
>        OSLoadOptions=root=/dev/sda1 ro
> 
>     So I had to do:
> 
>        setenv OSLoadOptions " root=/dev/sda1 ro"
> 
>     Which works like a dream. (Note the trailing space after the first " )

This sounds like a ARC firmware bug. The patch Guido produced 2
weeks ago now in the kernel worked for me on multiple indys and indigo2s
up to now without the leading space.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
