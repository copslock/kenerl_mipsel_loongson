Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1P3lx529625
	for linux-mips-outgoing; Sun, 24 Feb 2002 19:47:59 -0800
Received: from dtla2.teknuts.com (adsl-66-125-62-110.dsl.lsan03.pacbell.net [66.125.62.110])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1P3lt929605
	for <linux-mips@oss.sgi.com>; Sun, 24 Feb 2002 19:47:55 -0800
Received: from delllaptop ([208.187.134.59])
	(authenticated)
	by dtla2.teknuts.com (8.11.3/8.10.1) with ESMTP id g1P2llP09699;
	Sun, 24 Feb 2002 18:47:49 -0800
From: "Robert Rusek" <robru@teknuts.com>
To: "'Florian Lohoff'" <flo@rfc822.org>
Cc: <linux-mips@oss.sgi.com>
Subject: RE: Latest kernel?
Date: Sun, 24 Feb 2002 18:43:17 -0800
Message-ID: <001401c1bda6$352f7d10$6601a8c0@delllaptop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20020220221507.GC29624@paradigm.rfc822.org>
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Florian,

I checked the oss.sgi.com cvs and they do not seem to have linux_2_4
only linux-2.4-xfs.  Is that what I am looking for?  Will that give me a
working 2.4.x kernel?

Thanks in advance,
Rob.

-----Original Message-----
From: owner-linux-mips@oss.sgi.com [mailto:owner-linux-mips@oss.sgi.com]
On Behalf Of Florian Lohoff
Sent: Wednesday, February 20, 2002 2:15 PM
To: Robert Rusek
Cc: linux-mips@oss.sgi.com
Subject: Re: Latest kernel?


On Wed, Feb 20, 2002 at 02:00:36PM -0800, Robert Rusek wrote:
> Where can I obtain the latest stable build of the kernel.  I need it 
> to work on my SGI IP22.  If possible I do not want to use CSV since I 
> do not have a high speed internet connection.  Any help would be 
> greatly appreciated.

I dont think there are regular tarballs - Take the pain once - checkout
the kernel and before modifying make a tarball. Then you can just

cvs -z3 update -Pd 

Your tarball all the time. BTW: You should checkout -r linux_2_4 as i
dont think 2.5 has success reports on mips already.

Flo
-- 
Florian Lohoff                  flo@rfc822.org
+49-5201-669912
Nine nineth on september the 9th              Welcome to the new
billenium
