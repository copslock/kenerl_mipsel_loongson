Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1QBTLe12069
	for linux-mips-outgoing; Tue, 26 Feb 2002 03:29:21 -0800
Received: from firewall.i-data.com (firewall.i-data.com [195.24.22.194])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1QBTI912065
	for <linux-mips@oss.sgi.com>; Tue, 26 Feb 2002 03:29:18 -0800
Received: (qmail 23919 invoked from network); 26 Feb 2002 11:34:35 -0000
Received: from idahub2000.i-data.com (HELO idanshub.i-data.com) (172.16.1.8)
  by firewall.i-data.com with SMTP; 26 Feb 2002 11:34:35 -0000
Received: from eicon.com ([172.17.159.1])
          by idanshub.i-data.com (Lotus Domino Release 5.0.8)
          with ESMTP id 2002022611291552:46028 ;
          Tue, 26 Feb 2002 11:29:15 +0100 
Message-ID: <3C7B63E7.8DFF9D89@eicon.com>
Date: Tue, 26 Feb 2002 11:31:03 +0100
From: "Tommy S. Christensen" <tommy.christensen@eicon.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Dharm <mdharm@momenco.com>
CC: Kevin Paul Herbert <kph@ayrnetworks.com>,
   Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Is this a toolchain bug?
References: <NEBBLJGMNKKEEMNLHGAIGEMACFAA.mdharm@momenco.com>
X-MIMETrack: Itemize by SMTP Server on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at
 26-02-2002 11:29:15,
	Serialize by Router on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at 26-02-2002
 11:29:16,
	Serialize complete at 26-02-2002 11:29:16
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Matthew Dharm wrote:
> 
> So, we've got a problem somewhere in the module handling.  Either the
> symbol wasn't being relocated properly, or it wasn't being allocated
> properly, or something.  I'm not an expert in this region of the
> kernel, but my guess is that we're going to see this more and more
> often, so someone with a clue should take a look at this.

To me, this looks like a problem with common symbols that I have run
into a couple of times (I think it was in i2o).

Compiling with -fno-common or linking with -d worked for me.
(Or avoid having uninitialized global variables.)

I guess insmod should actually complain in this case ?!

 -Tommy
