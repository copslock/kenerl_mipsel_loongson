Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3PGrNwJ017300
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Apr 2002 09:53:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3PGrMtM017299
	for linux-mips-outgoing; Thu, 25 Apr 2002 09:53:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mcp.csh.rit.edu (mcp.csh.rit.edu [129.21.60.9])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3PGr4wJ017288;
	Thu, 25 Apr 2002 09:53:04 -0700
Received: from csh.rit.edu (anna.csh.rit.edu [129.21.61.85])
	by mcp.csh.rit.edu (Postfix) with ESMTP
	id 1768AE5; Thu, 25 Apr 2002 12:18:55 -0400 (EDT)
Message-ID: <3CC82C2F.7010104@csh.rit.edu>
Date: Thu, 25 Apr 2002 12:17:51 -0400
From: George Gensure <werkt@csh.rit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@oss.sgi.com>, Pete Popov <ppopov@mvista.com>,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: reiserfs
References: <Pine.GSO.4.21.0204251011190.1401-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geert Uytterhoeven wrote:

>On Thu, 25 Apr 2002, Ralf Baechle wrote:
>
>>On Wed, Apr 24, 2002 at 04:13:06PM -0700, Pete Popov wrote:
>>
>>>Has anyone been able to run reiserfs on big endian systems?
>>>
>>I've seen reports of people running Reiserfs on MIPS but I don't know what
>>endianess.
>>
>
>Some people run it on PowerPC, which is big endian as far as Linux is
>concerned.
>
>Gr{oetje,eeting}s,
>
>						Geert
>
>--
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
>In personal conversations with technical people, I call myself a hacker. But
>when I'm talking to journalists I just say "programmer" or something like that.
>							    -- Linus Torvalds
>
Jeff Mahoney, probably the lead big-endian reiserfs developer, has run 
reiserfs on (that I've seen with my own eyes) Sun and Apple (G3 or 
later).  There is no reason his code would not similarly work on 
big-endian mips machines.

-George
