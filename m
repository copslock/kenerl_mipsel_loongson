Received:  by oss.sgi.com id <S553715AbQLMNID>;
	Wed, 13 Dec 2000 05:08:03 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:5395 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553699AbQLMNHm>;
	Wed, 13 Dec 2000 05:07:42 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B1E7B7FF; Wed, 13 Dec 2000 14:07:39 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 87D5B8F74; Wed, 13 Dec 2000 13:57:23 +0100 (CET)
Date:   Wed, 13 Dec 2000 13:57:23 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Olaf Zaplinski <olaf.zaplinski@web.de>
Cc:     linux-mips@oss.sgi.com
Subject: Re: FAQ/
Message-ID: <20001213135723.B3060@paradigm.rfc822.org>
References: <3A36AFFE.51C9F2B@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A36AFFE.51C9F2B@web.de>; from olaf.zaplinski@web.de on Wed, Dec 13, 2000 at 12:08:46AM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Dec 13, 2000 at 12:08:46AM +0100, Olaf Zaplinski wrote:
> Hi all,
> 
> can someone please point me to a Howto/FAQ? I'd like to put Linux on my SNI
> RM200 machine (R4600, 64MB). Can I use the Hardhat distribution, or does it
> run on SGIs only?

The RM200 was supported only in little endian mode with the Windows NT
firmware - Nobody knows (chance is little) if the tree will still work.

You will need the decstation root not the hardhat tarball as that
is strictly big endian.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
