Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g79DfKRw006516
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 9 Aug 2002 06:41:20 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g79DfKu0006515
	for linux-mips-outgoing; Fri, 9 Aug 2002 06:41:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g79DfGRw006506
	for <linux-mips@oss.sgi.com>; Fri, 9 Aug 2002 06:41:16 -0700
Received: from merry.physik.uni-konstanz.de (merry.physik.uni-konstanz.de [134.34.144.91])
	by gandalf.physik.uni-konstanz.de (Postfix) with ESMTP
	id 7581A8D35; Fri,  9 Aug 2002 15:43:25 +0200 (CEST)
Received: from agx by merry.physik.uni-konstanz.de with local (Exim 3.35 #1 (Debian))
	id 17dA33-00075T-00; Fri, 09 Aug 2002 15:43:25 +0200
Date: Fri, 9 Aug 2002 15:43:25 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: ip22 build fix
Message-ID: <20020809134325.GA27234@merry>
Mail-Followup-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@oss.sgi.com
References: <20020809124745.GA32507@bogon.ms20.nix> <Pine.GSO.3.96.1020809150817.3290A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020809150817.3290A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.28i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 09, 2002 at 03:14:07PM +0200, Maciej W. Rozycki wrote:
> On Fri, 9 Aug 2002, Guido Guenther wrote:
>  Well, $(CONFIG_ARC_MEMORY) equals to "y" for IP22, so please check you
> haven't got your configuration messed up.
Hmmm...another "make oldconfig" fixed it and defines
CONFIG_ARC_MEMORY=y while the first one didn't - weird. Forget about the
patch then.
Judging from the notes in memory.c maybe the option should correctly be
called CONFIG_ARCS_MEMORY instead or will any subarch using ARC ever use
it?
Thanks,
 -- Guido
