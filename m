Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5CN15nC017347
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 12 Jun 2002 16:01:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5CN15ur017346
	for linux-mips-outgoing; Wed, 12 Jun 2002 16:01:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from www.linux.org.uk (parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5CN10nC017311;
	Wed, 12 Jun 2002 16:01:00 -0700
Received: from adsl-17-114-120.asm.bellsouth.net ([68.17.114.120] helo=mandrakesoft.com)
	by www.linux.org.uk with esmtp (Exim 3.33 #5)
	id 17IH98-0004BT-00; Thu, 13 Jun 2002 00:03:22 +0100
Message-ID: <3D07D270.5060902@mandrakesoft.com>
Date: Wed, 12 Jun 2002 19:00:00 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zhang Fuxin <fxzhang@ict.ac.cn>
CC: linux-mips@oss.sgi.com, saw@saw.sw.com.sg, linux-kernel@vger.kernel.org,
   netdev@oss.sgi.com
Subject: Re: NAPI for eepro100
References: <3D0740ED.2060907@ict.ac.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Zhang Fuxin wrote:
> hi,all
>   Recently i've converted eepro100 driver to use napi,in order to improve
> network performance of my poor 150M mips machine. It does eliminate
> the interrupt live lock seen before,maintaining a peak throughput under
> heavy load.
>  In case anybody are interested,i post the patches to the list. They are
> 3 incremental patchs:
>   eepro100-napi.patch is against 2.5.20 eepro100.c and provide basic
> napi support

Nifty, I'll take a look at this.


>   eepro100-proc.patch is proc file system support adapted from intel's
> e100 driver. I am using it for debugging.
>   eepro100-mips.patch is mips specific patch to make it work(well) for 
> my mips
> platform.


Just FWIW I'm not gonna apply these... for the 'proc' patch, that either 
needs to be moved to ethtool, or we should make a filesystem for net 
drivers that exports procfs-like inodes.  for the 'mips' patch, it looks 
like the arch maintainer(s) need to fix the PCI DMA support...

	Jeff
