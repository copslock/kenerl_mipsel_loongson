Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g25Ep4t27148
	for linux-mips-outgoing; Tue, 5 Mar 2002 06:51:04 -0800
Received: from arianna.cineca.it (dns.cineca.it [130.186.1.53])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g25Eot927145
	for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 06:50:55 -0800
Received: from cineca.it (andrea@nb-venturi.cineca.it [193.204.122.87])
	by arianna.cineca.it (8.12.1/8.12.1/CINECA 5.0-MILTER) with ESMTP id g25DoStv008622;
	Tue, 5 Mar 2002 14:50:28 +0100 (MET)
Message-ID: <3C84CD2A.6070901@cineca.it>
Date: Tue, 05 Mar 2002 14:50:34 +0100
From: Andrea Venturi <a.venturi@cineca.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
CC: Andrea Venturi <a.venturi@cineca.it>, linux-mips@oss.sgi.com
Subject: Re: device support on indy WS !?
References: <Pine.LNX.4.21.0203051355360.24029-100000@hlubocky.del.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ladislav Michl wrote:
> On Tue, 5 Mar 2002, Andrea Venturi wrote:
> 
> [snip]
> 
>>1. audio hal2: i saw in the cvs.sgi.com kernel the OSS hal2.* files; 
>>what about the guenther alsa0.9 port? is it finished? what about iec958 
>>spdif support?
>>
> 
> I can't say anything about ALSA 0.9 port. I decided for OSS driver,
> because I wanded to listen music and there was no driver. OSS is much
> better documented interface than ALSA.

..................
> 
> recording doesn't work and will not work until someone provide better
> documentation.
> 
> btw, what is iec958 spdig?
> 

it's a digital audio interface, for some info, see here:

   http://www.epanorama.net/documents/audio/spdif.html

in the indy there is a consumer mini-jack connector; you should be able 
to link a dolby surround digital amplifier or a dat or similar digital 
audio device..

see here:

   http://www.futuretech.vuurwerk.nl/i2sec3.html

BTW, on the mainboard, i can see the cs-8411, and there is the 8411.pdf 
inside the audio.zip doc package

> 
>>2. isdn: there is a siemens isac-s chip (BTW i didn't see the hscx 
>>twin): is it supported now? it should be not to difficult to leverage 
>>the ia32-isdn hisax (passive) isac driver _if_ the hpc3 delivers the 
>>irq? what do you think about it?
>>
> 
> there is currenty no support. any documentation available?
> 

apart from the hpc3.ps on:

   ftp://oss.sgi.com/pub/linux/mips/doc/indy/

you should find the isac-s (peb2086) specs here:
http://www.infineon.com/cgi/ecrm.dll/ecrm/scripts/prod_ov.jsp?oid=13633&cat_oid=-9183

but i don't know if it's enough.. i mean, if we should know something 
more on the way the isac-s chip is linked thru the pbus to the hpc3 chip.

bye

andrea venturi
