Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64BPQRw000962
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 04:25:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64BPQ00000961
	for linux-mips-outgoing; Thu, 4 Jul 2002 04:25:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (dialinpool.tiscali.de [62.246.28.123] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64BPKRw000952
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 04:25:21 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g64BTGb26998;
	Thu, 4 Jul 2002 13:29:16 +0200
Date: Thu, 4 Jul 2002 13:29:16 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
Cc: linux-mips@oss.sgi.com
Subject: Re: lib/Config.in missing in CVS HEAD ?
Message-ID: <20020704132916.A26943@dea.linux-mips.net>
References: <Pine.LNX.4.21.0207041317070.1601-200000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0207041317070.1601-200000@melkor>; from vivien.chappelier@enst-bretagne.fr on Thu, Jul 04, 2002 at 01:21:48PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.2 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK,MAY_BE_FORGED version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 04, 2002 at 01:21:48PM +0200, Vivien Chappelier wrote:

> 	arch/mips64/config.in includes lib/Config.in which is
> missing. Please either put that file on CVS HEAD if it exists and is
> needed, or update arch/mips64/config.in with the following patch.
> 	Currently, 'make menuconfig ARCH=mips64' crashes because of this.

Now you know that I'm not using menuconfig :-)  Patch applied.

Btw, do me a favor, send patches inline, not as attachment unless your
mailer does funny things to them.

  Ralf
