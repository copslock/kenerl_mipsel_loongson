Received:  by oss.sgi.com id <S553870AbRCAJ3W>;
	Thu, 1 Mar 2001 01:29:22 -0800
Received: from haliga.physik.TU-Cottbus.De ([141.43.75.9]:22797 "HELO
        haliga.physik.tu-cottbus.de") by oss.sgi.com with SMTP
	id <S553865AbRCAJ3H>; Thu, 1 Mar 2001 01:29:07 -0800
Received: by haliga.physik.tu-cottbus.de (Postfix, from userid 7215)
	id 8D42F8EFE; Thu,  1 Mar 2001 10:24:46 +0100 (MET)
Date:   Thu, 1 Mar 2001 10:24:46 +0100
To:     linux-mips@oss.sgi.com
Subject: Re: NFSROOT filesystem
Message-ID: <20010301102446.B3177@physik.tu-cottbus.de>
References: <OF67407876.E19EEFE1-ON88256A02.000F849E@taec.toshiba.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <OF67407876.E19EEFE1-ON88256A02.000F849E@taec.toshiba.com>; from Lisa.Hsu@taec.toshiba.com on Wed, Feb 28, 2001 at 07:00:13PM -0800
From:   heinold@physik.tu-cottbus.de (H.Heinold)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Feb 28, 2001 at 07:00:13PM -0800, Lisa.Hsu@taec.toshiba.com wrote:
> 
> Hi, All
> 
> For using NFS boot, I've already edited the /etc/hosts, /etc/exports to add
> the entry for my target board.  The command line that I use in our EPROM
> based bootloader  is as follows:
> 
> root=/dev/nfs rw ip=::::::rarp console=ttyS2
> nfsroot=209.243.136.151:/work/nfsroot
> 
> I need to setup the NFSROOT filesystem on the server for my target board
> (which is running in Big-endian mode),  what are the steps that I have to
> do?
>
For big endian you need big endian complied packages, you can retrieve the debian base2_2.2.tgz
under ftp.uni-mainz.de/pub/Linux/debian-local/mips, which should work fine as nfsroot. I have some
problems with open a console beacause on Indigo2 you only have output on the serial console.

> There is a FTP site for getting RPM packages for little endian mode:
> 
>          tp://ftp.linux.sgi.com/[ig/linux/mips/mipsel-linux/RedHat-6.1/RPMS
> 
> I could not find similar one for big-endian.    Can anybody give me a
> pointer to where the RPM packages reside on the web?
> 
> 
> Thanks,
> 
No prob.

> Lisa
> 
> 
> 



-- 


Henning Heinold
