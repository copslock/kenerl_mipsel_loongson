Received:  by oss.sgi.com id <S553714AbRCAViR>;
	Thu, 1 Mar 2001 13:38:17 -0800
Received: from mailhost.taec.com ([209.243.128.33]:23499 "EHLO
        mailhost.taec.toshiba.com") by oss.sgi.com with ESMTP
	id <S553692AbRCAVhx>; Thu, 1 Mar 2001 13:37:53 -0800
Received: from hdqmta.taec.toshiba.com (hdqmta [209.243.180.59])
	by mailhost.taec.toshiba.com (8.8.8+Sun/8.8.8) with ESMTP id NAA26829;
	Thu, 1 Mar 2001 13:37:14 -0800 (PST)
Subject: Re: NFSROOT filesystem
To:     heinold@physik.tu-cottbus.de (H.Heinold)
Cc:     linux-mips@oss.sgi.com, owner-linux-mips@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OF68B1111A.E5F36BC9-ON88256A02.0074F726@taec.toshiba.com>
From:   Lisa.Hsu@taec.toshiba.com
Date:   Thu, 1 Mar 2001 13:30:57 -0800
X-MIMETrack: Serialize by Router on HDQMTA/TOSHIBA_TAEC(Release 5.0.5 |September 22, 2000) at
 03/01/2001 01:36:00 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Thanks to Henning for showing me where to get the big-endian compiled
packages and it works.   Now, I need big-endian compiled "ash".
Is anybody know where I can get it?

Thanks,

Lisa



                                                                                                                       
                    heinold@physik.tu-                                                                                 
                    cottbus.de                To:     linux-mips@oss.sgi.com                                           
                    (H.Heinold)               cc:                                                                      
                    Sent by:                  Subject:     Re: NFSROOT filesystem                                      
                    owner-linux-mips@o                                                                                 
                    ss.sgi.com                                                                                         
                                                                                                                       
                                                                                                                       
                    03/01/01 01:24 AM                                                                                  
                                                                                                                       
                                                                                                                       




On Wed, Feb 28, 2001 at 07:00:13PM -0800, Lisa.Hsu@taec.toshiba.com wrote:
>
> Hi, All
>
> For using NFS boot, I've already edited the /etc/hosts, /etc/exports to
add
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
For big endian you need big endian complied packages, you can retrieve the
debian base2_2.2.tgz
under ftp.uni-mainz.de/pub/Linux/debian-local/mips, which should work fine
as nfsroot. I have some
problems with open a console beacause on Indigo2 you only have output on
the serial console.

> There is a FTP site for getting RPM packages for little endian mode:
>
>
tp://ftp.linux.sgi.com/[ig/linux/mips/mipsel-linux/RedHat-6.1/RPMS
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
