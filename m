Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Mar 2005 11:56:53 +0000 (GMT)
Received: from sorrow.cyrius.com ([IPv6:::ffff:65.19.161.204]:32782 "EHLO
	sorrow.cyrius.com") by linux-mips.org with ESMTP
	id <S8224908AbVCTL4i>; Sun, 20 Mar 2005 11:56:38 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 6EB3E64D3D; Sun, 20 Mar 2005 11:56:35 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 175354ECF5; Sun, 20 Mar 2005 11:56:25 +0000 (GMT)
Date:	Sun, 20 Mar 2005 11:56:25 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Stuart Longland <stuartl@longlandclan.hopto.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Netbooting CoLo on the Cobalt RaQ1
Message-ID: <20050320115624.GB20242@deprecation.cyrius.com>
References: <423AD5A2.3060200@longlandclan.hopto.org> <20050318141208.GA26486@deprecation.cyrius.com> <423C3787.6090107@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423C3787.6090107@longlandclan.hopto.org>
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Stuart Longland <stuartl@longlandclan.hopto.org> [2005-03-20 00:30]:
> When this user tries to boot, the system reports back "Unknown
> Compression Method".  A full log from the serial console is here:
> <http://www.gurlinet.dk/upload/minicom.cap>.  I suspect the system, as
> the colo-chain.elf is simply gzipped and named 'vmlinux.gz'.

Yes, gzipped with -9 (although I'm not sure whether this is a
requirement or just used to save space).

> 	We also get the same error message when using the Debian netboot 
> 	images
> -- which is interesting to say the least.  I've looked around but
> haven't seen any comments regarding Gentoo or Debian on a RaQ1.  Has
> anyone tried installing a modern Linux distribution on these boxes?

I don't know anyone who explicitly said they're running on a RaQ1 but
I've never heard of problems either (until now).  A Debian person
might be getting a RaQ1 soon so we'll see whether it works for him.
-- 
Martin Michlmayr
http://www.cyrius.com/
