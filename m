Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7CGCn29457
	for linux-mips-outgoing; Fri, 7 Dec 2001 04:16:12 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7CG9o29454
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 04:16:09 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA16486;
	Fri, 7 Dec 2001 03:15:47 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA02228;
	Fri, 7 Dec 2001 03:15:45 -0800 (PST)
Received: from mips.com (coppccl [172.17.27.2])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id fB7BFfA06918;
	Fri, 7 Dec 2001 12:15:41 +0100 (MET)
Message-ID: <3C10A5CB.FB92B3A@mips.com>
Date: Fri, 07 Dec 2001 12:19:39 +0100
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Guido Guenther <agx@sigxcpu.org>
CC: linux-mips@oss.sgi.com
Subject: Re: Mozilla/Netscape on MIPS
References: <3C0CDB7B.C13AE2B3@mips.com> <20011204161157.A9410@galadriel.physik.uni-konstanz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Guido Guenther wrote:

> On Tue, Dec 04, 2001 at 03:19:39PM +0100, Carsten Langgaard wrote:
> > There has previous been some request about running Mozilla on a MIPS
> > system.
> > We have put a bigendian and a littleendian image on our FTP site.
> >
> > It runs on the current RedHat7.1 distribution with some minor updates.
> > The needed RPMs is also available on our FTP site:
> >     ftp://ftp.mips.com/pub/linux/mips/installation/apps/mozilla/
> Were any special patches needed? Could you please also put the source
> rpms there?

Ok, I will put the sources on our FTP.
Inorder to build the sources you also need to install some extra RPMs and
rebuild crtbeginS.o, crti.o and libc_nonshared.a with the -Wa,-xgot option.


>
> Regards,
>  -- Guido
