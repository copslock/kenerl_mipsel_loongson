Received:  by oss.sgi.com id <S553738AbRCAVrQ>;
	Thu, 1 Mar 2001 13:47:16 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:40694 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553705AbRCAVrF>;
	Thu, 1 Mar 2001 13:47:05 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f21Lg8G24303;
	Thu, 1 Mar 2001 13:42:08 -0800
Message-ID: <3A9EC293.F301E8D5@mvista.com>
Date:   Thu, 01 Mar 2001 13:43:47 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Lisa.Hsu@taec.toshiba.com
CC:     "H.Heinold" <heinold@physik.tu-cottbus.de>, linux-mips@oss.sgi.com,
        owner-linux-mips@oss.sgi.com
Subject: Re: NFSROOT filesystem
References: <OF68B1111A.E5F36BC9-ON88256A02.0074F726@taec.toshiba.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Lisa.Hsu@taec.toshiba.com wrote:
> 
> Thanks to Henning for showing me where to get the big-endian compiled
> packages and it works.   Now, I need big-endian compiled "ash".
> Is anybody know where I can get it?
> 
> Thanks,
> 
> Lisa
> 
> 
>                     heinold@physik.tu-
>                     cottbus.de                To:     linux-mips@oss.sgi.com
>                     (H.Heinold)               cc:
>                     Sent by:                  Subject:     Re: NFSROOT filesystem
>                     owner-linux-mips@o
>                     ss.sgi.com
> 
> 
>                     03/01/01 01:24 AM
> 
> 
> 
> On Wed, Feb 28, 2001 at 07:00:13PM -0800, Lisa.Hsu@taec.toshiba.com wrote:
> >
> > Hi, All
> >
> > For using NFS boot, I've already edited the /etc/hosts, /etc/exports to
> add
> > the entry for my target board.  The command line that I use in our EPROM
> > based bootloader  is as follows:
> >
> > root=/dev/nfs rw ip=::::::rarp console=ttyS2
> > nfsroot=209.243.136.151:/work/nfsroot
> >
> > I need to setup the NFSROOT filesystem on the server for my target board
> > (which is running in Big-endian mode),  what are the steps that I have to
> > do?
> >
> For big endian you need big endian complied packages, you can retrieve the
> debian base2_2.2.tgz
> under ftp.uni-mainz.de/pub/Linux/debian-local/mips, which should work fine
> as nfsroot. I have some
> problems with open a console beacause on Indigo2 you only have output on
> the serial console.
> 
> > There is a FTP site for getting RPM packages for little endian mode:
> >
> >
> tp://ftp.linux.sgi.com/[ig/linux/mips/mipsel-linux/RedHat-6.1/RPMS
> >
> > I could not find similar one for big-endian.    Can anybody give me a
> > pointer to where the RPM packages reside on the web?
> >
> >
> > Thanks,
> >
> No prob.
> 
> > Lisa
> >
> >
> >

Lisa,

You can get either big endian or little endian NFS root fs on the following
site.  

ftp://ftp.mvista.com/pub/Area51/mips_fp_le
ftp://ftp.mvista.com/pub/Area51/mips_fp_be

Jun
