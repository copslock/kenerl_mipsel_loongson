Received:  by oss.sgi.com id <S554076AbRAQOym>;
	Wed, 17 Jan 2001 06:54:42 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:50445 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S554071AbRAQOyh>;
	Wed, 17 Jan 2001 06:54:37 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 761FA7FC; Wed, 17 Jan 2001 15:54:27 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 2D303F597; Wed, 17 Jan 2001 15:55:06 +0100 (CET)
Date:   Wed, 17 Jan 2001 15:55:06 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: sgi automatic console detection
Message-ID: <20010117155506.D2517@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
i was just on the way again of detecting the console of the Indigo2
automagically - There are some interesting nifty details.

In arch/mips/sgi/kernel/setup.c i find

    251 #ifdef CONFIG_SERIAL_CONSOLE
    252         /* ARCS console environment variable is set to "g?" for
    253          * graphics console, it is set to "d" for the first serial
    254          * line and "d2" for the second serial line.
    255          */
    256         ctype = ArcGetEnvironmentVariable("console");
    257         if(*ctype == 'd') {
    258                 if(*(ctype+1)=='2')
    259                         console_setup ("ttyS1");
    260                 else
    261                         console_setup ("ttyS0");
    262         }
    263 #endif

Which is ok - But - On my Indigo2 (It has a GFX Board) the prom gives me:

console=g
ConsoleOut=serial(0)
ConsoleIn=serial(0)

So - From the logic above this will give me "graphics" console although
there is no keyboard attached and no Monitor. What do others see there 
especially the ones with an Indy and GFX Console.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
