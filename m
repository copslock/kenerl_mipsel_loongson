Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g47C44wJ016897
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 05:04:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g47C44eZ016896
	for linux-mips-outgoing; Tue, 7 May 2002 05:04:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g47C3xwJ016893
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 05:04:00 -0700
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 1753iO-0001Wr-00; Tue, 07 May 2002 14:05:08 +0200
Date: Tue, 7 May 2002 14:05:08 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Robert Rusek <robru@teknuts.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: depmod help !
Message-ID: <20020507120507.GA5859@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Robert Rusek <robru@teknuts.com>, linux-mips@oss.sgi.com
References: <001501c1f57c$f2188e90$6601a8c0@delllaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001501c1f57c$f2188e90$6601a8c0@delllaptop>
User-Agent: Mutt/1.3.28i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, May 06, 2002 at 09:09:11PM -0700, Robert Rusek wrote:
> When a depmod is performed I get the following message:
> 
> depmod: cannot read ELF header from /lib/modules/2.4.17/modules.dep
> depmod: cannot read ELF header from
> /lib/modules/2.4.17/modules.generic_string
> depmod: /lib/modules/2.4.17/modules.ieee1394map is not an ELF file
> depmod: /lib/modules/2.4.17/modules.isapnpmap is not an ELF file
> depmod: cannot read ELF header from
> /lib/modules/2.4.17/modules.parportmap
> depmod: /lib/modules/2.4.17/modules.pcimap is not an ELF file
> depmod: cannot read ELF header from
> /lib/modules/2.4.17/modules.pnpbiosmap
> depmod: /lib/modules/2.4.17/modules.usbmap is not an ELF file

depmod bug, you get this if you've compiled your kernel with module
support but actually havent't installed any modules. Create an empty
/lib/modules/2.4.17/kernel/ directory to make depmod happy.

Regards,
Johannes
