Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9CIBmp27260
	for linux-mips-outgoing; Fri, 12 Oct 2001 11:11:48 -0700
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9CIBeD27250;
	Fri, 12 Oct 2001 11:11:40 -0700
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 12 Oct 2001 18:13:08 UT
Received: from bud.austin.esstech.com ([193.5.206.3])
	by mail.esstech.com (8.8.8+Sun/8.8.8) with SMTP id LAA22291;
	Fri, 12 Oct 2001 11:10:13 -0700 (PDT)
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id NAA19852; Fri, 12 Oct 2001 13:09:39 -0500
Message-ID: <3BC732C9.9080508@esstech.com>
Date: Fri, 12 Oct 2001 13:13:29 -0500
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@oss.sgi.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Remove ifdefs from setup_arch()
References: <Pine.GSO.4.21.0110121350300.20566-100000@mullein.sonytel.be> <3BC72BE8.F50C2001@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Can you wrap this code into small functions like machine_detect() and
board_setup() and put it all in one place?  That way those of us who
just want a simple system supporting only one board can just replace
those two functions with defines that alias the proper machine_detect
and board_setup fuctions.  Then all of the special elf sections and
function pointers go away.

If it's all in one place like this, then maybe it could be configured
in the config.in file.  I can ifdef it out for boards like mine or other
boards that can't possibly support more than one system in a given binary
image.  config.in could ifdef it in for configurations that could possibly
support more than one configuration in a given binary image.

Gerald


Jun Sun wrote:
> The actual mechanism can vary and be flexible, but here is more detail what I
> had in mind:
> 
> 1. <my>_detect is placed in a special ELF section (mips_mach_detect), using
> similar mechanism as .initcall.init section and __setup() macro.
> 
> 2. in addition to the 3 possible return value, <my>_detect also returns a
> function pointer to <my>_setup.  Once a final candidate is chosen, the machine
> detection code will issue the right <my>_setup call.
> 
> There are probably some other related changes which need to be made, (e.g.,
> prom_init() may be eliminated, etc).
> 
> It seems like I get more and more positive feedbacks on this idea.  We should
> try to implement this in 2.5.
> 
> Jun
> 
> 
> 
