Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0T3Y0l14199
	for linux-mips-outgoing; Mon, 28 Jan 2002 19:34:00 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0T3XtP14185
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 19:33:55 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA04393
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 18:32:29 -0800 (PST)
	mail_from (ppopov@pacbell.net)
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0T2QwB24696;
	Mon, 28 Jan 2002 18:26:58 -0800
Subject: RE: Help with OOPSes, anyone?
From: Pete Popov <ppopov@pacbell.net>
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIIEBLCFAA.mdharm@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIIEBLCFAA.mdharm@momenco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 28 Jan 2002 18:29:22 -0800
Message-Id: <1012271362.8518.219.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> And 2.4.17 with the wait instruction turned off still crashes.
 
> The Montavista kernel (which claims to be 2.4.0 #5 build by jsun)
> seems to work...  

Strange, that must have been some interim build Jun did.

> I've done several recompiles on it, and lots of I/O
> traffic with no problems.  Unfortunatly, I don't have the source code
> to this particular kernel... tho I believe that Montavista is required
> to release their source cod by the GPL.

All of the open source work we do we push out to the community tree 
immediately.  That's a rule we live by and there's no exceptions.  The Ocelot 
code was pushed out back then. Since then I've seen lots of additions to that 
directory and obviously something got broke.

QED did receive an Alliance CD with the Ocelot LSP on it, so they should
be able to provide you with a copy of the cdimage, including the
source.  But the kernel will be 2.4.2 based though -- I don't know where
the 2.4.0 came from.
 
> Tho here's a question:  What is the best compiler to build a kernel
> with?  I've built all mine with egcs-2.91.66 which I downloaded from
> oss.sgi.com a while ago.

MontaVista's, but I'm biased ;-)  The toolchain will be on the CD as
well.

Pete
