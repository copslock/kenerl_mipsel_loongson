Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DF7No08496
	for linux-mips-outgoing; Thu, 13 Sep 2001 08:07:23 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DF7Je08490
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 08:07:19 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA11202;
	Thu, 13 Sep 2001 08:06:56 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id IAA20769;
	Thu, 13 Sep 2001 08:06:55 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f8DF6sa14950;
	Thu, 13 Sep 2001 17:06:55 +0200 (MEST)
Message-ID: <3BA0CB8D.ED5AB42B@mips.com>
Date: Thu, 13 Sep 2001 17:06:53 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: linux-mips@oss.sgi.com
Subject: Re: Update for RedHat 7.1
References: <20010907230009.A1705@lucon.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I now tried to installing the bigendian RedHat7.1 RPMs and I noticed the
following.

/etc/localtime is lacking in glibc-2.2.4-11.2.mips.rpm (but it's contain
in the little endian version).
All the timezone information is lacking under /usr/share/zoneinfo in
glibc-common-2.2.4-11.2 (but it's in the little endian version).

I can't changes the root password, I get the following:
# passwd root
Changing password for user root
New UNIX password:
/usr/lib/cracklib_dict: magic mismatch
PWOpen: Success

/Carsten


"H . J . Lu" wrote:

> I updated a few packages, fixed a linker bug and rebuilt everything.
>
> H.J.
> ----
> My mini-port of RedHat 7.1 is at
>
> ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/
>
> you should be able to put a small RedHat 7.1 on the mips/mipsel box and
> compile the rest of RedHat 7.1 yourselves.
>
> Here are something you should know:
>
> 1. The cross compiler hosted on RedHat 7.1/ia32 is provided as a
> toolchain rpm. The binary rpms for the mips and mipsel cross compilers
> are included. You will need glibc 2.2.3-11 or above to use those
> rpms. The glibc x86 binary rpms under RPMS/i386 should be ok.
> 2. You have to find a way to put those rpms on your machine. I use
> network boot and NFS root to do it.
> 3. install.tar.bz2 has some scripts to prepare NFS root and install
> RedHat 7.1 on a hard drive.
> 4. baseline.tar.bz2 contains the cross build tree.
>
> Thanks.
>
> H.J.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
