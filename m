Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5H9VSZ24893
	for linux-mips-outgoing; Sun, 17 Jun 2001 02:31:28 -0700
Received: from dea.waldorf-gmbh.de (u-13-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.13])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5H9VOZ24862
	for <linux-mips@oss.sgi.com>; Sun, 17 Jun 2001 02:31:25 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5H9V1w03290;
	Sun, 17 Jun 2001 11:31:01 +0200
Date: Sun, 17 Jun 2001 11:31:01 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej Agaran' Pijanka" <agaran@team.pld.org.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: kernel 2.2.14 (cvs from oss.sgi.com) and compile problems
Message-ID: <20010617113100.B3216@bacchus.dhis.org>
References: <20010617025832.A18403@team.pld.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010617025832.A18403@team.pld.org.pl>; from agaran@team.pld.org.pl on Sun, Jun 17, 2001 at 02:58:32AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jun 17, 2001 at 02:58:32AM +0200, Maciej Agaran' Pijanka wrote:

> im trying to recompile 2.2.14 from cvs (khmm 10 h ago cvsed, branch
> linux_2_2 ) and have problem with make boot

There is a reason that DECstation is only selectable under
CONFIG_EXPERIMENTAL in 2.2.  I suggest to go for kernel 2.4 instead.

  Ralf
