Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g29JGKB04530
	for linux-mips-outgoing; Sat, 9 Mar 2002 11:16:20 -0800
Received: from mta7.pltn13.pbi.net (mta7.pltn13.pbi.net [64.164.98.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g29JGH904524
	for <linux-mips@oss.sgi.com>; Sat, 9 Mar 2002 11:16:17 -0800
Received: from localhost ([63.194.214.47])
 by mta7.pltn13.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GSP00KR4XF4FY@mta7.pltn13.pbi.net> for linux-mips@oss.sgi.com;
 Sat, 09 Mar 2002 10:16:17 -0800 (PST)
Date: Sat, 09 Mar 2002 10:12:42 -0800
From: Pete Popov <ppopov@mvista.com>
Subject: Re: xfs
In-reply-to: <7338.1015665420@ocs3.intra.ocs.com.au>
To: Keith Owens <kaos@sgi.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Message-id: <1015697562.1199.1.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution/1.0.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <7338.1015665420@ocs3.intra.ocs.com.au>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 2002-03-09 at 01:17, Keith Owens wrote:
> On 08 Mar 2002 10:22:07 -0800, 
> Pete Popov <ppopov@mvista.com> wrote:
> >I see on SGI's web site that XFS is supported only on x86 and IA64. Has
> >anyone tried it on mips?
> 
> Anybody wanting to port XFS to new architectures should start with
>   ftp://oss.sgi.com/projects/xfs/download/patches/2.4.18
> I split the XFS patches up so people can pick and choose which
> components they use, it makes it easier to exclude code like kdb,
> kbuild 2.5 or ia64 from the port.  Note the ia64 patch, you will need a
> MIPS equivalent.

Great, thank you.
 
> When you get it working, send us the changes from the split patches.

I will, if I get to work on it.

Pete
 
