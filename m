Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3HDV88d024647
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Apr 2002 06:31:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3HDV8MJ024646
	for linux-mips-outgoing; Wed, 17 Apr 2002 06:31:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3HDV48d024642
	for <linux-mips@oss.sgi.com>; Wed, 17 Apr 2002 06:31:05 -0700
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id B40968D35; Wed, 17 Apr 2002 15:32:01 +0200 (CEST)
Date: Wed, 17 Apr 2002 15:32:01 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Gary.A.Grant@gsk.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Indy --> Linux?
Message-ID: <20020417153201.C31398@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Gary.A.Grant@gsk.com, linux-mips@oss.sgi.com
References: <OFE00701E7.4960DCD3-ON80256B9E.0045F5F8@ha.uk.sbphrd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFE00701E7.4960DCD3-ON80256B9E.0045F5F8@ha.uk.sbphrd.com>; from Gary.A.Grant@gsk.com on Wed, Apr 17, 2002 at 02:12:57PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Gary,
On Wed, Apr 17, 2002 at 02:12:57PM +0100, Gary.A.Grant@gsk.com wrote:
> OK, no problem!
> 
> Hello Guido 
> Here is a hinv and gxfinfo of my Indy......can it be made to run Linux?? 
[..snip..] 
Linux should run fine on your Indy including audio and XFree86.
There are several distributions available like a Red Hat miniport
available at 
 ftp://oss.sgi.com/pub/linux/mips
and Debian available at:
 ftp.debian.org:/debian/dists/woody/main/disks-mips/current
The later one might be slightly easier to set up since it comes with a
netbooted installer. For more information see
 http://www.debian.org/ports/mips
and
 http://www.linux-debian.de/howto/debian-mips-woody-install.html
Regards,
 -- Guido
