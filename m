Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KGwaEC000405
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 09:58:36 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KGwa2r000404
	for linux-mips-outgoing; Tue, 20 Aug 2002 09:58:36 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KGwREC000395
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 09:58:28 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA04591
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 10:02:11 -0700 (PDT)
	mail_from (ppopov@mvista.com)
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA03936;
	Tue, 20 Aug 2002 09:56:08 -0700
Subject: Re: Mips cross toolchain
From: Pete Popov <ppopov@mvista.com>
To: Joe George <joeg@clearcore.net>
Cc: Lyle Bainbridge <lyle@zevion.com>, linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <3D626E61.3010505@clearcore.net>
References: <NCBBKGDBOEEBDOELAFOFKEGGCPAA.lyle@zevion.com> 
	<3D626E61.3010505@clearcore.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 20 Aug 2002 09:57:45 -0700
Message-Id: <1029862665.11391.5.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Tue, 2002-08-20 at 09:29, Joe George wrote:
> I don't know of anyone using big endian with Alchemy at this point.
> There may be some and I'd like to hear from them.
 
> The OSS tree is actually not that far out of date now.  I have been
> submitting patches and the basics work now (at least on my board).

Where those patches created from the sourceforge tree or you created
them independently?  I would hate to see the two ports diverge.

> I am currently working on the 36-bit support. 

I already sent Ralf a patch for the 36bit support.  He told me the patch
looks fine but it doesn't seem like he's had time to merge it in.  The
code is in sourceforge.net

> The 36-bit support only
> works for little endian currently afaics.  I'm working to solve the endian
> problems now.

Again, I've done some work for big endian support and pushed it out in
sourceforge.net because I have write access there.  Most drivers work
just fine in BE mode.  The exception right now is the epson 1356/1386
video controller.  There might be some others but I don't remember.
Certainly all the SOC peripherals work fine.
 
> Check out the howto at http://www.linux-mips.org/.  There are 3 of
> us doing Alchemy work who hang out on the #mipslinux irc channel
> on irc.openprojects.net you're welcome to join us.

If you're submitting patches in oss, please take the latest work in
sourceforge.net first to sync up the two.  First, you might save
yourself some work. Second, it will keep the two ports from diverging.

Pete
