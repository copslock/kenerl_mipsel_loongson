Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6EE3PRw010828
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 14 Jul 2002 07:03:25 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6EE3PYV010827
	for linux-mips-outgoing; Sun, 14 Jul 2002 07:03:25 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6EE3KRw010818
	for <linux-mips@oss.sgi.com>; Sun, 14 Jul 2002 07:03:21 -0700
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id DBE9A8D36; Sun, 14 Jul 2002 16:08:06 +0200 (CEST)
Date: Sun, 14 Jul 2002 16:08:06 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: mike.martin@cogeco.ca
Cc: linux-mips@oss.sgi.com
Subject: Re: New Debian Indy...
Message-ID: <20020714160806.A31002@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: mike.martin@cogeco.ca, linux-mips@oss.sgi.com
References: <20020714094331.5207794b.mike@overlord.linux-dude.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020714094331.5207794b.mike@overlord.linux-dude.com>; from mike@overlord.linux-dude.com on Sun, Jul 14, 2002 at 09:43:31AM -0400
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g6EE3LRw010819
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Mike,
On Sun, Jul 14, 2002 at 09:43:31AM -0400, Mike Martin wrote:
[..snip..] 
> Things that don't work:
> X in 24 bit mode (I have the XL-24, 8 bit X works great)
Not supported in the debian packages but flaky support in XFree86
4.2.0. See
 http://honk.physik.uni-konstanz.de/linux-mips/x/x.html
for details.

> Indy Cam
Not supported yet.

> Sound
Install at least the kernel-image-2.4.17-r4k-ip22 package and load the
HAL module.
Regards,
 -- Guido
