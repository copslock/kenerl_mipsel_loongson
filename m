Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f93NHSh27707
	for linux-mips-outgoing; Wed, 3 Oct 2001 16:17:28 -0700
Received: from dea.linux-mips.net (a1as01-p32.stg.tli.de [195.252.185.32])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f93NHOD27704
	for <linux-mips@oss.sgi.com>; Wed, 3 Oct 2001 16:17:24 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f93NHAm00679;
	Thu, 4 Oct 2001 01:17:10 +0200
Date: Thu, 4 Oct 2001 01:17:10 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: balaji.ramalingam@philips.com
Cc: linux-mips@oss.sgi.com
Subject: Re: mipsel-linux cross compiler issue while installing
Message-ID: <20011004011710.A483@dea.linux-mips.net>
References: <OF5B78E837.1C0B89F9-ON88256ADA.007E2E97@diamond.philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF5B78E837.1C0B89F9-ON88256ADA.007E2E97@diamond.philips.com>; from balaji.ramalingam@philips.com on Wed, Oct 03, 2001 at 04:08:35PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Oct 03, 2001 at 04:08:35PM -0700, balaji.ramalingam@philips.com wrote:

> ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev
> 
> I edited the make-cross.sh to change the base path and target and when I ran the script
> I got the following errors while installing the glibc.
> 
> Can you please help me in fixing this error?
> Is there a patch or something which I'm missing here?

That's a compiler bug.  It should always define __PIC__.

  Ralf
