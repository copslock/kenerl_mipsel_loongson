Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA20PbD26812
	for linux-mips-outgoing; Thu, 1 Nov 2001 16:25:37 -0800
Received: from dark-past (h117n1fls20o53.telia.com [213.64.214.117])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA20PW026791
	for <linux-mips@oss.sgi.com>; Thu, 1 Nov 2001 16:25:33 -0800
Received: from yog-sothoth.dark-past.mine.nu (yog-sothoth [192.168.1.7]) by dark-past (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id DAA01207 for <linux-mips@oss.sgi.com>; Fri, 2 Nov 2001 03:37:04 -0800
Message-Id: <5.1.0.14.0.20011102023002.00a65c90@192.168.1.5>
X-Sender: peter@192.168.1.5
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 02 Nov 2001 03:04:18 +0100
To: linux-mips@oss.sgi.com
From: Peter Andersson <peter@dark-past.mine.nu>
Subject: Re: Mozilla on MIPS
In-Reply-To: <20011101085149.A19298@lucon.org>
References: <200111011554.KAA196739151@node109.ott.qnx.com>
 <200111011554.KAA196739151@node109.ott.qnx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have now managed to compile Mozilla on my mips-linux machine but only by 
"cheating". As it turned out when i compiled it with the -Wa,-xgot flags i 
did not get any errors from the mozilla source files. The thing is that, as 
Ryan Murray pointed out, that gcc has to be compiled with the -Wa,-xgot 
flags as well (because of "relocation truncated errors" in crtibeginS.o and 
probably the other .o files included with gcc). I did not manage to compile 
a working version of gcc for some reason.
Also glibc had to be compiled with the same flags (otherwise crti.o 
returned the "relocation" error). Because of my own lack of competence i 
did not manage to pass the -Wa,-xgot arguments automatically during the 
making of the crt*.o-files. I could not find the file used for creating 
those particular files and i could not find them in any makefile. This 
meant that i had to wait for those files to "get made" and then stop the 
compilation and pass the arguments manually to gcc.
These two factors resulted in me "cheating" to get it to compile. I just 
replaced the files from the glibc/gcc rpms (crti.o from glibc and 
crtibeginS.o from gcc) with the ones i had compiled and then i managed to 
compile mozilla without any trouble. This, of course, did not produce a 
working binary but if someone, a bit more knowledgeable about these things 
than i, recompiled gcc and glibc they probably would get it to work...

I hope this will shed some light on the "mozilla problem".

Perhaps i should mention that i got the web browser galeon 
(http://galeon.sourceforge.net/) working using the mozilla libs i compiled...

Peter
