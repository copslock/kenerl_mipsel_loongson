Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4CJcJw08878
	for linux-mips-outgoing; Sat, 12 May 2001 12:38:19 -0700
Received: from chmls06.mediaone.net (chmls06.mediaone.net [24.147.1.144])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4CJcIF08875
	for <linux-mips@oss.sgi.com>; Sat, 12 May 2001 12:38:18 -0700
Received: from [192.168.1.3] (h00104b670a0d.ne.mediaone.net [65.96.137.220])
	by chmls06.mediaone.net (8.11.1/8.11.1) with ESMTP id f4CJbb829180;
	Sat, 12 May 2001 15:37:37 -0400 (EDT)
Mime-Version: 1.0
X-Sender: mjpento@pop.ne.mediaone.net
Message-Id: <p05001900b7233ce422ce@[192.168.1.3]>
In-Reply-To: <20010512204401.D6072@e67205.upc-e.chello.nl>
References: <20010512204401.D6072@e67205.upc-e.chello.nl>
Date: Sat, 12 May 2001 15:39:24 -0400
To: peter.zijlstra@chello.nl
From: mjpento <mjpento@mediaone.net>
Subject: Re: Where to start with a R4000 Indigo
Cc: linux-mips@oss.sgi.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Peter,

	I am in the same boat as you essentially, only I am a little 
worse off. I own 2 Indigo R3000's and would love to see a port of 
Linux or NetBSD or something of that nature done for the machine, but 
alas, I fear that if I don't start one on my architecture there may 
never be a port to the R3000.
	There is some hope for you. I believe someone on this list 
told me a while back that a port is being developed by someone to the 
R4000 Indigo, someone here might be able to shed some more light on 
that for you as I have no idea who is doing that.
	There is also the Plan 9 effort, which is an OS that is/was 
being developed by AT&T that supports the R4000 and maybe even the 
R3000. You may be able to get information about the architecture of 
the Indigo from this code. I have been unsuccessful in this respect, 
but, maybe you will have better luck than I. Here are some Plan 9 
links to get you started:

http://www.vitanuova.com/plan9/
http://www.fywss.com/plan9/plan9faq.html

	As far as getting information from SGI, I wouldn't bother 
with that, as anyone else in here would agree. The chances of them 
giving you any information are slim to none. The expense of having 
someone at SGI pull documentation for the Indigo (if it even still 
exists) is too high. So, architecture information and specifications 
are very hard to come by.
	I am thinking about *attempting* to start a port of some 
linux distribution to the R3000, but I have to admit, the task seems 
a bit daunting. On other platforms, this is difficult with the proper 
documentation. You may also want to take a look at the Linux/MIPS 
page and check out the Indy port, which is the only functional Linux 
port to the SGI platform that I am aware of.
	I hope that some of this information will help you out. 
Remember to try the MIPS website also as there may be some useful 
bits of data there that will shed some light for you.

Thanks,
Mike


>Hi,.
>
>I recently acquired a R4000 50MHz Indigo without an IRIX install nor CD
>with it. No CD-Rom player either, however I did order one, network however
>does seem to work. And as I am a linux fanatic and professional programmer
>myself I would like to see whether I could help a bit with bringing linux to
>this system.
>
>As Indigo support isn't finished and I have nothing but a bare BIOS
>to start with; and have no experience with the machine to begin with;
>I have to ask for _help_ :)
>
>Where do I start reading and tinkering to get linux; for as far as it's
>sort of running; on my system ?
>
>Are there any specs for the machine, especially for those parts that need
>most urgent development and which parts are that ?
>
>
>kind regards,
>	Peter Zijlstra
