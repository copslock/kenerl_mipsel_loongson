Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78Joet04261
	for linux-mips-outgoing; Wed, 8 Aug 2001 12:50:40 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78JocV04257
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 12:50:38 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id VAA189493
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 21:50:37 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15UZLh-0004Hd-00
	for <linux-mips@oss.sgi.com>; Wed, 08 Aug 2001 21:50:37 +0200
Date: Wed, 8 Aug 2001 21:50:37 +0200
To: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: HELP can't boot
Message-ID: <20010808215037.G4452@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.33.0108081532180.2274-100000@grover.WPI.EDU>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ian wrote:
> > tftp/nfs-root boot ? The prom is enough.
> 
> When I type "boot bootp():/tftpboot/kernel-hardhat" at the PROM command
                   ^
boot -f bootp():...


Thiemo
