Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2GBU1j29129
	for linux-mips-outgoing; Sat, 16 Mar 2002 03:30:01 -0800
Received: from holly.csn.ul.ie (holly.csn.ul.ie [136.201.105.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2GBTu929124
	for <linux-mips@oss.sgi.com>; Sat, 16 Mar 2002 03:29:56 -0800
Received: from skynet.csn.ul.ie (skynet [136.201.105.2])
	by holly.csn.ul.ie (Postfix) with ESMTP
	id 777A72B31C; Sat, 16 Mar 2002 11:31:19 +0000 (GMT)
Received: by skynet.csn.ul.ie (Postfix, from userid 2139)
	id D9413E953; Sat, 16 Mar 2002 11:31:18 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by skynet.csn.ul.ie (Postfix) with ESMTP
	id BBE247243; Sat, 16 Mar 2002 11:31:18 +0000 (GMT)
Date: Sat, 16 Mar 2002 11:31:18 +0000 (GMT)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender:  <airlied@skynet>
To: Karsten Merker <karsten@excalibur.cologne.de>
Cc: <linux-mips@oss.sgi.com>
Subject: Re: DECStation kernel boot failure
In-Reply-To: <20020315195946.GA3020@excalibur.cologne.de>
Message-ID: <Pine.LNX.4.32.0203161129110.28645-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>
> That was the LANCE driver for the 5000/200, which is different from
> the driver for all the 5000/xx, /1xx, /240 and /260. The Maxine
> should work with the default declance.c from the CVS.

Does the copy on my website still work ?

http://www.skynet.ie/~airlied/mips/declance_2_3_48.c

It was never merged as to do it properly required a re-write of the
driver, which I never got around to, and I only had a DS5000/200, I still
have one, but no build system at the moment ...

Dave.

 >
> Regards,
> Karsten
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person
