Received:  by oss.sgi.com id <S554085AbRAZRVf>;
	Fri, 26 Jan 2001 09:21:35 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:45070 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S554082AbRAZRVY>;
	Fri, 26 Jan 2001 09:21:24 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C95897FE; Fri, 26 Jan 2001 18:21:21 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 639C0EE9C; Fri, 26 Jan 2001 18:21:55 +0100 (CET)
Date:   Fri, 26 Jan 2001 18:21:55 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Carsten Langgaard <carstenl@mips.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: RedHat 7.0 ?
Message-ID: <20010126182155.C23839@paradigm.rfc822.org>
References: <3A71B011.4B82F6C3@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A71B011.4B82F6C3@mips.com>; from carstenl@mips.com on Fri, Jan 26, 2001 at 06:12:49PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 06:12:49PM +0100, Carsten Langgaard wrote:
> 
> Has anyone put together an easy-to-install tar file, similar to the old
> hard-hat 5.1 tarfile, where you could install everything though an
> install program running on a nfs server ?
> I really like the old hard-hat approach, it was easy to install and
> everything seems to work, but it would be nice to have a newer release.
> The old hard-hat install program doesn't work with the new 2.4.0 kernel.
> 

There is a big endian glibc 2.2 debian base - Look at
ftp.uni-mainz.de/pub/debian-local/mips. I hope to produce something similar
for mipsel with the next days.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
