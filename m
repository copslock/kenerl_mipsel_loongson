Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3G9E08d021563
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Apr 2002 02:14:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3G9E0xu021562
	for linux-mips-outgoing; Tue, 16 Apr 2002 02:14:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3G9Du8d021551
	for <linux-mips@oss.sgi.com>; Tue, 16 Apr 2002 02:13:57 -0700
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id B713F8D35; Tue, 16 Apr 2002 11:14:49 +0200 (CEST)
Date: Tue, 16 Apr 2002 11:14:49 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: head.S and init_task.c vs addinitrd
Message-ID: <20020416111449.A18886@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@oss.sgi.com
References: <20020415181743.A24174@gandalf.physik.uni-konstanz.de> <Pine.GSO.3.96.1020415201017.19735Q-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020415201017.19735Q-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Apr 15, 2002 at 08:13:42PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 15, 2002 at 08:13:42PM +0200, Maciej W. Rozycki wrote:
> On Mon, 15 Apr 2002, Guido Guenther wrote:
>
> > Are you telling me the only reason for the changes in
> > init_task.c/head.S
> > were made to break the elf2ecoff/addinitrd "hack"? Where exactly was
> > there a hack in head.S/init_task.c. Please point me to the line of
> > code
> > since I don't understand enough about the kernel to see it.
>
>  I meant it stopped working because it is an ugly hack.  It is too
>  fragile
> to work in all cases.
I admit it's fragile but I'm still puzzled why the changes broke it and
if we can revert those changes on the linux_2_4 branch.
 -- Guido
