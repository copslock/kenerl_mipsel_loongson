Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f73GnvT15718
	for linux-mips-outgoing; Fri, 3 Aug 2001 09:49:57 -0700
Received: from server3.toshibatv.com ([207.152.29.75])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f73GnoV15712
	for <linux-mips@oss.sgi.com>; Fri, 3 Aug 2001 09:49:51 -0700
Received: by SERVER3 with Internet Mail Service (5.5.2650.21)
	id <3MTR1VGF>; Fri, 3 Aug 2001 11:49:23 -0500
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA0A3BE0@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: Linux 2.4.6
Date: Fri, 3 Aug 2001 11:48:11 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Still getting the following for make config/oldconfig/vmlinux. What works
(or seem to): make clean/mrproper/depend. What am I missing? I also get this
on the MIPS Linux 2.4.3 from the MIPS site.

> bash-2.04$ make config
> rm -f include/asm
> ( cd include ; ln -sf asm-mips asm)
> /bin/sh scripts/Configure arch/mips/config.in
> : command not found
> 'cripts/Configure: line 68: syntax error near unexpected token `{
> 'cripts/Configure: line 68: `function mainmenu_option () {
> make: *** [config] Error 2
> bash-2.04$
> 
> 
> Keith Siders
> Software Engineer
>  Toshiba America Consumer Products, Inc.
> Advanced Television Technology Center
> 801 Royal Parkway, Suite 100
> Nashville, Tennessee 37214
> Phone: (615) 257-4050
> Fax:   (615) 453-7880
> 
