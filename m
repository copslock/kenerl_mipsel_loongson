Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Aug 2004 22:18:49 +0100 (BST)
Received: from mx5.Informatik.Uni-Tuebingen.De ([IPv6:::ffff:134.2.12.32]:64949
	"EHLO mx5.informatik.uni-tuebingen.de") by linux-mips.org with ESMTP
	id <S8225195AbUHJVSo>; Tue, 10 Aug 2004 22:18:44 +0100
Received: from localhost (loopback [127.0.0.1])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id D472D115; Tue, 10 Aug 2004 23:18:37 +0200 (MST)
Received: from mx3.informatik.uni-tuebingen.de ([134.2.12.26])
 by localhost (mx5 [134.2.12.32]) (amavisd-new, port 10024) with ESMTP
 id 30452-04; Tue, 10 Aug 2004 23:18:35 +0200 (DFT)
Received: from dual (semeai.Informatik.Uni-Tuebingen.De [134.2.15.66])
	by mx3.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id B1C7313B; Tue, 10 Aug 2004 23:18:33 +0200 (DFT)
Received: from mrvn by dual with local (Exim 4.34)
	id 1Bue0s-0004pE-2I; Tue, 10 Aug 2004 23:18:30 +0200
To: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
Cc: dev-list@meshcube.org, linux-mips@linux-mips.org
Subject: Re: Q: way to populate a (full featured) Debian/MIPS with the
 Meshcube
References: <41176789.12682.FB0F085@localhost>
	<Pine.LNX.4.58.0408102158480.14110@shofar.kom.e-technik.tu-darmstadt.de>
	<Pine.LNX.4.58.0408102224260.14110@shofar.kom.e-technik.tu-darmstadt.de>
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: Tue, 10 Aug 2004 23:18:29 +0200
In-Reply-To: <Pine.LNX.4.58.0408102224260.14110@shofar.kom.e-technik.tu-darmstadt.de> (Ralf
 Ackermann's message of "Tue, 10 Aug 2004 22:31:37 +0200 (CEST)")
Message-ID: <878ycmlmje.fsf@mrvn.homelinux.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: by amavisd-new (McAfee AntiVirus) at informatik.uni-tuebingen.de
Return-Path: <brederlo@informatik.uni-tuebingen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brederlo@informatik.uni-tuebingen.de
Precedence: bulk
X-list: linux-mips

Ralf Ackermann <rac@KOM.tu-darmstadt.de> writes:

> Hello,
>
> since a few people (e.g. Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>) 
> already earlier suggested to use a full-featured Debian/MIPS with the 
> Meshcube - here are my 2 questions concerning that topic:
> 	1. Is there a step-by-step instruction list on how
> 		to bootstrap such an environment (with just the
> 		MeshCube and i386 Linux systems but no further MIPS system
> 		available)

nfs-root? Debian (on that i386)?

cdebootstrap -amips sarge /tftpboot/<ip>/ http://ftp.de.debian.org/debian

That will fail after a while leaving you with a skeleton to boot from:

- create etc/fstab hosts resolv.conf apt/sources.list
- boot with init=/bin/sh
  - cd /var/cache/apt/archive/
  - dpkg --force-all -i libc6*deb
  - dpkg --force-all -i dpkg*deb
  - dpkg --force-all -i libc6*deb
  - dpkg -iGREB /var/cache/apt/archive/
  - dpkg -iGREB /var/cache/apt/archive/
  - dpkg -iGREB /var/cache/apt/archive/
  - check remaining dpkg errors if any
  - /usr/sbin/base-config
- adjust etc/inittab for serial console if you need
- reboot with normal init
- run dselect once going through all the top menu items to get all the
  standard packages added. You don't need to select any packages, just
  go into select once.

If you already have a unix on the meshcube run cdeboostrap there
(build it from source). Much easier.

> 	2. Could somebody provide a snapshot of a (basic) Debian/MIPS
> 		filesystem that can be mounted via NFS and chrooted to?
> 		(this would then let me start apt-get upgrading / 
> 		installing in it)
> 	(I could provide the storage space / connectivity to also host
> 		such a FS snapshot for others)

Again use cdebootstrap or debootstrap.

> Many thanks for your help and best regards
>  Ralf
>
> ---------------------------------------------------------------
> Dr. Ralf Ackermann            _         rac@KOM.tu-darmstadt.de
> Multimedia Communications |/ | | |\/|           Merckstrasse 25
>                           |\ |_| |  |  64283 Darmstadt, Germany
> Tel.: (+49) 6151 16-6138                Fax: (+49) 6151 16-6152
> ---------------------------------------------------------------
>              http://www.kom.tu-darmstadt.de/~rac
> ---------------------------------------------------------------

MfG
        Goswin

PS: You can ask your local DAluk for help if you get stuck too.
