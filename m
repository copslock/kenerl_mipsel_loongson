Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BHTEA13946
	for linux-mips-outgoing; Mon, 11 Feb 2002 09:29:14 -0800
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BHT9913943
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 09:29:09 -0800
Received: from js by hell with local (Exim 3.33 #1 (Debian))
	id 16aJJs-0000nH-00; Mon, 11 Feb 2002 17:28:44 +0100
Date: Mon, 11 Feb 2002 17:28:44 +0100
From: Johannes Stezenbach <js@convergence.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: gcc include strangeness
Message-ID: <20020211162844.GD2918@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
References: <20020211142708.GA2577@convergence.de> <Pine.GSO.3.96.1020211155920.18917F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020211155920.18917F-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.27i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 11, 2002 at 04:10:34PM +0100, Maciej W. Rozycki wrote:
> 
>  Is gcc 3.x already stable enough to be used by people not directly
> involved in gcc development?  More specifically for MIPS/Linux and
> i386/Linux, for both the kernel and the userland?  I'm told it is not.

I'm reading about gcc 3.x code generation bugs every now and then,
but so far I did not hit any of them.
I would prefer gcc 2.95.x though, if I only could get it
to work on MIPS.

>  Gcc 2.95.x as distributed certainly doesn't work.  With a set of patches
> it appears rock solid.  For MIPS/Linux I'm using it for over two years for
> both the kernel and the userland.  The last time I found bug and needed to
> apply a fix to gcc 2.95.3 for MIPS/Linux was in April 2001. 

I would certainly be interested in getting my hands on those
patches. Do you mind if I ask why they did not go into
gcc-2_95-branch CVS?


Regards,
Johannes
