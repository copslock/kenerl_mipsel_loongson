Received:  by oss.sgi.com id <S42308AbQHVP4T>;
	Tue, 22 Aug 2000 08:56:19 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:26679 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42304AbQHVPzy>; Tue, 22 Aug 2000 08:55:54 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA02807
	for <linux-mips@oss.sgi.com>; Tue, 22 Aug 2000 09:02:10 -0700 (PDT)
	mail_from (shm@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id IAA28242 for <linux-mips@oss.sgi.com>; Tue, 22 Aug 2000 08:55:23 -0700 (PDT)
Received: from tantrik.engr.sgi.com (tantrik.engr.sgi.com [130.62.52.189])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA95466;
	Tue, 22 Aug 2000 08:53:50 -0700 (PDT)
	mail_from (shm@cthulhu.engr.sgi.com)
Received: from localhost (shm@localhost) by tantrik.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA64683; Tue, 22 Aug 2000 08:53:49 -0700 (PDT)
Date:   Tue, 22 Aug 2000 08:53:49 -0700
From:   Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
cc:     linux-fbdev@vuser.vu.union.edu,
        Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: Re: [linux-fbdev] SGI VW 540, fbdev and pot pourii of faults and
 evidence..:-)
In-Reply-To: <Pine.LNX.4.10.10008221138450.664-100000@maxwell.futurevision.com>
Message-ID: <Pine.SGI.4.21.0008220847450.264415-100000@tantrik.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 22 Aug 2000, James Simmons wrote:

JS>> I don't speak for SGI, but in the past I think they said that the
JS>> specs basically do not exist in a releasable form.  Basically, the
JS>> hardware developers and software developers worked in the same hallway
JS>> and the development was of the form "hey Joe, how do I program the
JS>> zapbot to do foobaz?"
JS>
JS>Actually you are right. The lack of docs internally in SGI has caused this
JS>problem. This also has had the bad side effect of when they lose a
JS>critical employee then no one else has a clue on how it program it. You
JS>have to start from scratch. 
JS>

Well as I have tried to explain in the past the situation is not as cut
and dry as all that. For most hardware systems, well written driver code
is a good place to start. (in fact al of the internal port to linux for
the 320 was done without formal docs, or the engg's to talk to)

The real problem is that the 320 gfx family uses a SGI style
high-performance which is different from the AGP style approach that the
other guys use. Porting this to linux .. or more than knowing how the
hardware works .. since we need to port a very complicated mechanism, for
which linux may not have obvious and ready replacements.

On top of that .. there are potentially Intellectual Property issues with
the management style. Thus the concerns with just releasing the specs.

Since this is a recurring question, are there people on this list that are
personally motivated to try and port this system over ?

Std Disclaimer: I am not speaking for SGI .. all opinions expressed here
and mine and mine alone.

Thanx

-- 
--------------------------------------------------------------------------
Shrijeet Mukherjee,    		        Advanced Graphics, SGI
http://reality.sgi.com/shm_engr     	phone: 650-933-5312
email: shm@sgi.com, shrijeet@hotmail.com
--------------------------------------------------------------------------
Where there is a will, there is a way. If a way cannot be found, 
it is the will that is suspect ..                                   -- shm 
