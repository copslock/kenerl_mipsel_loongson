Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2ODnIi06702
	for linux-mips-outgoing; Sun, 24 Mar 2002 05:49:18 -0800
Received: from holly.csn.ul.ie (holly.csn.ul.ie [136.201.105.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2ODnBq06699
	for <linux-mips@oss.sgi.com>; Sun, 24 Mar 2002 05:49:11 -0800
Received: from skynet.csn.ul.ie (skynet [136.201.105.2])
	by holly.csn.ul.ie (Postfix) with ESMTP
	id 08AC82B6B5; Sun, 24 Mar 2002 13:51:28 +0000 (GMT)
Received: by skynet.csn.ul.ie (Postfix, from userid 2139)
	id 9550AE960; Sun, 24 Mar 2002 13:51:22 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by skynet.csn.ul.ie (Postfix) with ESMTP
	id 5CFB87243; Sun, 24 Mar 2002 13:51:22 +0000 (GMT)
Date: Sun, 24 Mar 2002 13:51:22 +0000 (GMT)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender:  <airlied@skynet>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, <linux-mips@fnet.fr>,
   <linux-mips@oss.sgi.com>
Subject: Re: [patch] linux: declance multicast filter fixes
In-Reply-To: <Pine.GSO.3.96.1020323010132.3959A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.32.0203241349380.32481-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > I've created declance_2_4.c on http://www.csn.ul.ie/~airlied/mips
> >
> > for the DS5000/200 series of DecStations..
>
>  Thanks for the reference -- I definitely want to look how to merge the
> drivers one day (well, actually the LANCE core should be common to all
> drivers eventually).  There is certainly no point in keeping your code
> separately.  I suppose your driver should work for the PMAD card as well.
>

well it should work for the PMAD and I've got a version for the VAX that
splits off from my one, the VAX uses a similiar wiring as the DS5000/200,
I've been waiting for the LANCE core to be separated out a lot of people
have talked about it and I hear for 2.5 maybe someone is actually going to
do it ...

Dave

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person
