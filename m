Received:  by oss.sgi.com id <S42313AbQHVQ3J>;
	Tue, 22 Aug 2000 09:29:09 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:34319 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42304AbQHVQ3A>;
	Tue, 22 Aug 2000 09:29:00 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA22613
	for <linux-mips@oss.sgi.com>; Tue, 22 Aug 2000 09:21:23 -0700 (PDT)
	mail_from (ehab@aia067.aia.rwth-aachen.de)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA22893;
	Tue, 22 Aug 2000 09:28:41 -0700 (PDT)
	mail_from (ehab@aia067.aia.RWTH-Aachen.DE)
Received: from aia067.aia.RWTH-Aachen.DE (aia067.aia.RWTH-Aachen.DE [134.130.140.67]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA01932; Tue, 22 Aug 2000 09:28:37 -0700 (PDT)
	mail_from (ehab@aia067.aia.RWTH-Aachen.DE)
Received: from localhost (localhost [[UNIX: localhost]])
	by aia067.aia.RWTH-Aachen.DE (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) id SAA08887;
	Tue, 22 Aug 2000 18:28:30 +0200
From:   Ehab Fares <ehab@aia.rwth-aachen.de>
To:     Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
Subject: Re: [linux-fbdev] SGI VW 540, fbdev... and other stuff
Date:   Tue, 22 Aug 2000 17:59:43 +0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
Cc:     linux-fbdev@vuser.vu.union.edu,
        Linux porting team <linux@cthulhu.engr.sgi.com>
References: <Pine.SGI.4.21.0008220847450.264415-100000@tantrik.engr.sgi.com>
In-Reply-To: <Pine.SGI.4.21.0008220847450.264415-100000@tantrik.engr.sgi.com>
MIME-Version: 1.0
Message-Id: <00082218283000.08755@aia067>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 22 Aug 2000, Shrijeet Mukherjee wrote:
> Well as I have tried to explain in the past the situation is not as cut
> and dry as all that. For most hardware systems, well written driver code
> is a good place to start. (in fact al of the internal port to linux for
> the 320 was done without formal docs, or the engg's to talk to)
> 
> The real problem is that the 320 gfx family uses a SGI style
> high-performance which is different from the AGP style approach that the
> other guys use. Porting this to linux .. or more than knowing how the
> hardware works .. since we need to port a very complicated mechanism, for
> which linux may not have obvious and ready replacements.
> 
> On top of that .. there are potentially Intellectual Property issues with
> the management style. Thus the concerns with just releasing the specs.
> 
> Since this is a recurring question, are there people on this list that are
> personally motivated to try and port this system over ?
> 
We are using a 540 system with the top configuration (4 processors, 2GB Ram and
the flat panel 1600SW). We are certainly motivated to get linux and the
X-Server working  poperly. As already posted in this mailing list the X-server
is not the only problem. I therefore would suggest to start collecting all the
problems that should be solved and look for people interested in working on
the port.  

The problems we have are:
1) new kernels simply wouldn'[t boot the machine. I got the machine working
with  the 2.2.10 patched kernel. All the four processors are working.
2) We have only 960 MB Ram of the installed 2GB working.
3) strange behaviour of the keyboard.
4) the parallel port is not working. (we haven't tested the rest of the ports)
5) very poor X performance with hangs every now and then which is probably
because of the X-Server.

Are there other people having similar or other problems and interested in
solving them? Is there anyone who have the experience or knowledge of that
system (and linux) who can help?

I personally would like to help but need some information and
details as I'm not a kernel hacker. 

Ehab.
