Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5J9CrnC012839
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 02:12:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5J9CrSg012838
	for linux-mips-outgoing; Wed, 19 Jun 2002 02:12:53 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-131.ka.dial.de.ignite.net [62.180.196.131])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5J9CanC012835
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 02:12:47 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5J91xk21715;
	Wed, 19 Jun 2002 11:01:59 +0200
Date: Wed, 19 Jun 2002 11:01:59 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: 64-bit kernel
Message-ID: <20020619110159.A21533@dea.linux-mips.net>
References: <3D0F28AE.7B0D822B@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D0F28AE.7B0D822B@mips.com>; from carstenl@mips.com on Tue, Jun 18, 2002 at 02:33:50PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 18, 2002 at 02:33:50PM +0200, Carsten Langgaard wrote:

> I don't know if anymore has a interest in the 64-bit kernel, but I just
> found this bug (see patch below).
> It would be nice to know, how many are interested in the 64-bit kernel
> and who actually got something running.
> So please rise you voice.

More and more systems run into the limits of system memory so once it's
practically unavoidable.  Take the existence of highmem as a proof for
it.

  Ralf
