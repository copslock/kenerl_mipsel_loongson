Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g25DCE524376
	for linux-mips-outgoing; Tue, 5 Mar 2002 05:12:14 -0800
Received: from arianna.cineca.it (dns.cineca.it [130.186.1.53])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g25DC7924373
	for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 05:12:08 -0800
Received: from cineca.it (andrea@nb-venturi.cineca.it [193.204.122.87])
	by arianna.cineca.it (8.12.1/8.12.1/CINECA 5.0-MILTER) with ESMTP id g25CBttv019279
	for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 13:11:56 +0100 (MET)
Message-ID: <3C84B611.5050103@cineca.it>
Date: Tue, 05 Mar 2002 13:12:01 +0100
From: Andrea Venturi <a.venturi@cineca.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: device support on indy WS !?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

i just put my hands on a couple of old indy r4000 (quite old)

i installed so far a debian woody linux distro! amazing..

i'm wondering about the bunch of special features available on the indy, 
how much are supported?

1. audio hal2: i saw in the cvs.sgi.com kernel the OSS hal2.* files; 
what about the guenther alsa0.9 port? is it finished? what about iec958 
spdif support?

2. isdn: there is a siemens isac-s chip (BTW i didn't see the hscx 
twin): is it supported now? it should be not to difficult to leverage 
the ia32-isdn hisax (passive) isac driver _if_ the hpc3 delivers the 
irq? what do you think about it?

bye


andrea venturi
