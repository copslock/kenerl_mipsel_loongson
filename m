Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6R34ZH05740
	for linux-mips-outgoing; Thu, 26 Jul 2001 20:04:35 -0700
Received: from dea.waldorf-gmbh.de (u-179-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.179])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6R34WV05737
	for <linux-mips@oss.sgi.com>; Thu, 26 Jul 2001 20:04:33 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6R34N115089;
	Fri, 27 Jul 2001 05:04:23 +0200
Date: Fri, 27 Jul 2001 05:04:23 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Siders, Keith" <keith_siders@toshibatv.com>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: Linux 2.4.6
Message-ID: <20010727050423.A14716@bacchus.dhis.org>
References: <7DF7BFDC95ECD411B4010090278A44CA0A3BC1@ATVX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7DF7BFDC95ECD411B4010090278A44CA0A3BC1@ATVX>; from keith_siders@toshibatv.com on Thu, Jul 26, 2001 at 04:02:04PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 26, 2001 at 04:02:04PM -0500, Siders, Keith wrote:

> I've made changes to the plain vanilla Linux 2.4.6 to port to our TX49H2

Stock kernel won't work.  See http://oss.sgi.com/mips/mips-howto.html
for how to get the latest MIPS kernel.

> core on one of our EVB's. Which version of the compiler and binutils should
> I use? The binutils-xx-2.8.1-2 and egcs-xx-1.1.2-4 worked for the 2.2.19
> port, but I'm getting errors in the shell scripts when I run 'make config'.
> I get the same errors with the same tools with the generic 2.4.6 as well.
> Looks like
> 
> bash-2.04$ cd linux
> bash-2.04$ make config
> rm -f include/asm
> ( cd include ; ln -sf asm-mips asm)
> /bin/sh scripts/Configure arch/mips/config.in
> : command not found
> 'cripts/Configure: line 68: syntax error near unexpected token `{
> 'cripts/Configure: line 68: `function mainmenu_option () {

Is /bin/sh bash at all?

  Ralf
