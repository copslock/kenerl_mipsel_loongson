Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2MB6IA16202
	for linux-mips-outgoing; Fri, 22 Mar 2002 03:06:18 -0800
Received: from holly.csn.ul.ie (holly.csn.ul.ie [136.201.105.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2MB6Eq16199
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 03:06:14 -0800
Received: from skynet.csn.ul.ie (skynet [136.201.105.2])
	by holly.csn.ul.ie (Postfix) with ESMTP
	id A0F6D2B303; Fri, 22 Mar 2002 11:08:27 +0000 (GMT)
Received: by skynet.csn.ul.ie (Postfix, from userid 2139)
	id 6F5FEE95F; Fri, 22 Mar 2002 11:08:27 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by skynet.csn.ul.ie (Postfix) with ESMTP
	id 6DFD97243; Fri, 22 Mar 2002 11:08:27 +0000 (GMT)
Date: Fri, 22 Mar 2002 11:08:27 +0000 (GMT)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender:  <airlied@skynet>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, <linux-mips@fnet.fr>,
   <linux-mips@oss.sgi.com>
Subject: Re: [patch] linux: declance multicast filter fixes
In-Reply-To: <Pine.GSO.3.96.1020321185116.22279D-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.32.0203221107170.1949-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I've created declance_2_4.c on http://www.csn.ul.ie/~airlied/mips

for the DS5000/200 series of DecStations..

it only required the BE -> LE and the additional zeroing of the filter, it
already did the mcast_table access correctly... (by luck rather than
design :-)

un-compiled and untested but it should work ..

Dave.

On Thu, 21 Mar 2002, Maciej W. Rozycki wrote:

> Hello,
>
>  Following are a few trivial fixes for the DECstation's LANCE driver
> needed for the chip's multicast filter to be set up correctly.  The patch
> is needed for multicast reception to work, in particular for the IPv6's
> neighbor discovery.  The CRC generation was verified using the AMD's
> reference code and it was checked at the run time for selected multicast
> addresses as well.  Please apply.
>
>  Maciej
>
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person
