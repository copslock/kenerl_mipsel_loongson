Received:  by oss.sgi.com id <S553975AbQKMJUs>;
	Mon, 13 Nov 2000 01:20:48 -0800
Received: from helena.bawue.de ([193.197.13.6]:25349 "HELO helena.bawue.de")
	by oss.sgi.com with SMTP id <S553972AbQKMJU1>;
	Mon, 13 Nov 2000 01:20:27 -0800
Received: by helena.bawue.de (Postfix, from userid 99)
	id 54D9D1F10E; Mon, 13 Nov 2000 10:20:14 +0100 (CET)
To:     wesolows@chem.unr.edu, bjzheng@ict.ac.cn
Subject: Re: Can you help me?
From:   flaws@bawue.de
Reply-To: flaws@bawue.de
Cc:     linux-mips@oss.sgi.com
X-Mailer: AeroMail (http://the.cushman.net/reverb/aeromail/)
Message-Id: <20001113092014.54D9D1F10E@helena.bawue.de>
Date:   Mon, 13 Nov 2000 10:20:14 +0100 (CET)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


> On Mon, Nov 13, 2000 at 10:45:17AM +0800, Zheng Baojian wrote:
> 
> >      I'm a Chinese student,i want to run linux on SGI O2 workstation.
> > I see that O2 not support linux now on your web,can you tell me the
> > reason?As series of SGI workstations,O2,Indy,Onyx ,Origin,they have
same
> > architecture,same cpu,why others support linux,O2 not support.
> 
> Harald Koerfgen and I (at least) have done some work on O2 and I can
> verify that it has at one point booted to userland (I no longer have
> the machine and thus do not know the status).  To say that an O2 has
> the same architecture as the other machines you mention, however, is
> an oversimplification at best; these machines have numerous
> differences (no two use the same bus type/controller), and afaik Onyx
> is not and never has been supported.  In fact, these machines don't

AFAIK Onyx is pretty much the same as an Origin, except for the graphics
hardware. Since Ralf is working on an Origin port, which is in quite a good
state, I guess, Onyx should be supported, too.
Without graphics, of course.

Florian
