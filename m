Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62K3tRw019156
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 13:03:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62K3tFx019155
	for linux-mips-outgoing; Tue, 2 Jul 2002 13:03:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-157.ka.dial.de.ignite.net [62.180.196.157])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62K3oRw019135
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 13:03:51 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g62K7Xg09848;
	Tue, 2 Jul 2002 22:07:33 +0200
Date: Tue, 2 Jul 2002 22:07:33 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Sam <iskoo@ms45.hinet.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: # trap handler example
Message-ID: <20020702220733.C9566@dea.linux-mips.net>
References: <000901c221ae$2a9a0c00$780411ac@sam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000901c221ae$2a9a0c00$780411ac@sam>; from iskoo@ms45.hinet.net on Tue, Jul 02, 2002 at 05:52:22PM +0800
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 02, 2002 at 05:52:22PM +0800, Sam wrote:

>     I want to write a trap handler for unalignment memory read/write error.

arch/mips/kernel/unaligned.c.

  Ralf
