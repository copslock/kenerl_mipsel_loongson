Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5O8B6nC021673
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 01:11:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5O8B576021672
	for linux-mips-outgoing; Mon, 24 Jun 2002 01:11:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-16.ka.dial.de.ignite.net [62.180.196.16])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5O8B0nC021669
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 01:11:02 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5O8BNQ23375;
	Mon, 24 Jun 2002 10:11:23 +0200
Date: Mon, 24 Jun 2002 10:11:23 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Guido Guenther <agx@sigxcpu.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: 2.4.18: pgtable.h compile fix
Message-ID: <20020624101123.A15988@dea.linux-mips.net>
References: <20020623125811.GA24851@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020623125811.GA24851@bogon.ms20.nix>; from agx@sigxcpu.org on Sun, Jun 23, 2002 at 02:58:11PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jun 23, 2002 at 02:58:11PM +0200, Guido Guenther wrote:

> Hi,
> I need the following to make head.S compile again for IP22 on the 
> current linux_2_4 branch:

> Is there a reason why the "_LANGUAGE_ASSEMBLY" ifdefs were removed?
> Mips64 still has these #ifdefs though.

The necessity for these was believed to be removed.  What are you trying
to do when you run into this problem?

  Ralf
