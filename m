Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5B6ReZ01825
	for linux-mips-outgoing; Sun, 10 Jun 2001 23:27:40 -0700
Received: from dea.waldorf-gmbh.de (u-91-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.91])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5B6RaV01814
	for <linux-mips@oss.sgi.com>; Sun, 10 Jun 2001 23:27:37 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5B4gnO15489;
	Mon, 11 Jun 2001 06:42:49 +0200
Date: Mon, 11 Jun 2001 06:42:49 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays)
Message-ID: <20010611064249.A15039@bacchus.dhis.org>
References: <20010611000359.A25631@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010611000359.A25631@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Jun 11, 2001 at 12:03:59AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 11, 2001 at 12:03:59AM +0200, Florian Lohoff wrote:

> Hi,
> i just tried to boot an Indy of mine with the current cvs (from this
> morning) and it crashes 

> No modules in ksyms, skipping objects
> kernel BUG at semaphore.c:235!
> Unable to handle kernel paging request at virtual address 00000000, epc == 8800f02c, ra == 8800f02c

This is a known and yet unresolved problem.  Yet I'm surprised - so far
I've only seen this problem on mips64.

  Ralf
