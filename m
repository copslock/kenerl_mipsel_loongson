Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g69NqXRw005925
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 9 Jul 2002 16:52:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g69NqWRP005924
	for linux-mips-outgoing; Tue, 9 Jul 2002 16:52:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (penta89-d28.dialo.tiscali.de [62.246.28.89] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g69NqQRw005915
	for <linux-mips@oss.sgi.com>; Tue, 9 Jul 2002 16:52:28 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g69NuSK19796;
	Wed, 10 Jul 2002 01:56:28 +0200
Date: Wed, 10 Jul 2002 01:56:28 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: p2@mind.be, geert@linux-m68k.org, wim@sonycom.com, lionel@sonycom.com,
   thomasv@sonycom.com, Nico.DeRanter@sonycom.com, tea@sonycom.com,
   joel@sonycom.com, michiels@CoWare.com, gds@denayer.wenk.be,
   linux-mips@oss.sgi.com
Subject: Re: [PATCH] DDB5074 support
Message-ID: <20020710015628.A19778@dea.linux-mips.net>
References: <20020709133630.GB9075@mind.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020709133630.GB9075@mind.be>; from p2@mind.be on Tue, Jul 09, 2002 at 03:36:30PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.0 required=5.0 tests=IN_REP_TO,MAY_BE_FORGED,PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 09, 2002 at 03:36:30PM +0200, Peter De Schrijver wrote:

> The attached patch adds support for the NEC DDB-5074 board.

Something went wrong with this patch, looks like you were manually editing
it or so.  When trying to apply it I get:

patch: **** malformed patch at line 1501: diff -r -N -u -w oss-2.4/linux/include/asm-mips/ddb5xxx/ddb5074.h oss-2.4-ddb5074/linux/include/asm-mips/ddb5xxx/ddb5074.h

Can you re-diff?

  Ralf
