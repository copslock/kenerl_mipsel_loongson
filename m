Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6QDlHp05764
	for linux-mips-outgoing; Thu, 26 Jul 2001 06:47:17 -0700
Received: from dea.waldorf-gmbh.de (u-167-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.167])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6QDlBV05757
	for <linux-mips@oss.sgi.com>; Thu, 26 Jul 2001 06:47:12 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6QDku011285;
	Thu, 26 Jul 2001 15:46:56 +0200
Date: Thu, 26 Jul 2001 15:46:56 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Andre.Messerschmidt@infineon.com
Cc: linux-mips@oss.sgi.com
Subject: Re: glibc problem
Message-ID: <20010726154655.B10790@bacchus.dhis.org>
References: <86048F07C015D311864100902760F1DDFF0021@dlfw003a.dus.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <86048F07C015D311864100902760F1DDFF0021@dlfw003a.dus.infineon.com>; from Andre.Messerschmidt@infineon.com on Thu, Jul 26, 2001 at 11:09:37AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 26, 2001 at 11:09:37AM +0200, Andre.Messerschmidt@infineon.com wrote:

> During compilation of glibc 2.2.3  I get the following error:
> Can not represent BFD_RELOC_16_PCREL_S2 relocation in this object file
> format
> 
> Someone in the archives meant that -D__PIC__ should be included to the
> CFLAGS to resolve this problem, but it seams that I am too dumb to do this. 
> I tried several locations to set the variable in the Makefiles and used the
> configparms file to set it, but nothing worked. Then I tried to define it in
> the file where the error occured, just to realize that there are more
> locations where this define is needed, so I reckon it would be the best to
> define it from the beginning.
> Can anybody tell me how to get it right? 

Adding -D__PIC__ is a kludge; the compiler should do it by default.  It
means you're using some non-Linux/MIPS compiler which you should replace.

  Ralf
