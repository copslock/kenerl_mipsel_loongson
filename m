Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6TGCDRw016463
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 29 Jul 2002 09:12:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6TGCDgB016462
	for linux-mips-outgoing; Mon, 29 Jul 2002 09:12:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6TGC8Rw016452
	for <linux-mips@oss.sgi.com>; Mon, 29 Jul 2002 09:12:08 -0700
Received: from hell (buserror-extern.convergence.de [212.84.236.66]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA03117
	for <linux-mips@oss.sgi.com>; Mon, 29 Jul 2002 09:14:02 -0700 (PDT)
	mail_from (js@convergence.de)
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17ZCyu-0000jd-00; Mon, 29 Jul 2002 18:02:48 +0200
Date: Mon, 29 Jul 2002 18:02:48 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] Oops and magic SysRq stack dump clean-ups
Message-ID: <20020729160248.GA2800@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
	linux-mips@oss.sgi.com
References: <Pine.GSO.3.96.1020725114648.27463B-100000@delta.ds2.pg.gda.pl> <Pine.GSO.3.96.1020729150226.22288D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020729150226.22288D-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 29, 2002 at 03:25:53PM +0200, Maciej W. Rozycki wrote:
>  I've reviewed the stack dumping code more thoroughly and here is the
> result.  Please check if it's OK for you.  Tested visually with oopses and
> <SysRq>+<t> on MIPS/Linux and MIPS64/Linux.  The idea is to fit as much
> data as possible in as little space as possible and at the same time lay
> the numbers out visually nicely so that manual copying of output from a
> terminal for ksymoops analysis is easier for a reader.  Tools ignore
> spacing when processing such output anyway.
> 
>  Based somewhat on the i386 port.  Addresses cast to signed longs, since
> they are such on MIPS (additionally, the code doesn't care anyway but the
> resulting source is smaller).  Any objections? 

Nope, patch and its output look good to me.


Johannes
