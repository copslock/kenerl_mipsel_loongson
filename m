Received:  by oss.sgi.com id <S554087AbRAQQAd>;
	Wed, 17 Jan 2001 08:00:33 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:27408 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553820AbRAQQAR>;
	Wed, 17 Jan 2001 08:00:17 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id BE7BF7FC; Wed, 17 Jan 2001 17:00:00 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5B237F597; Wed, 17 Jan 2001 16:51:52 +0100 (CET)
Date:   Wed, 17 Jan 2001 16:51:52 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Guido Guenther <guido.guenther@gmx.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: patches for dvhtool
Message-ID: <20010117165152.G2517@paradigm.rfc822.org>
References: <20001015021522.B3106@bilbo.physik.uni-konstanz.de> <20010117154937.C2517@paradigm.rfc822.org> <20010117162718.A2447@frodo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010117162718.A2447@frodo.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Wed, Jan 17, 2001 at 04:27:18PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 17, 2001 at 04:27:18PM +0100, Guido Guenther wrote:
> On Wed, Jan 17, 2001 at 03:49:37PM +0100, Florian Lohoff wrote:
> > I set this in the prom:
> > 
> > OSLoadFilename=vmlinux
> > OSLoadPartition=/dev/sda1
> > OSLoader=vmlinux
> > SystemPartition=scsi(1)disk(4)rdisk(0)partition(0)
> No need to set OSLoadFilename, OSLoader should be sufficient. Could you
> try to use SystemPartition=...partition(8)? Since this is the partition
> number of the volume header AFAIR.


>> setenv SystemPartition scsi(1)disk(4)rdisk(0)partition(8)
>> boot
1212416+135264+143084 entry: 0x880025a8                                        

Thats it - Now silence as the serial console will not be detected
automagically or at least not very reliable.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
