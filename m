Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Aug 2004 19:46:19 +0100 (BST)
Received: from mx5.Informatik.Uni-Tuebingen.De ([IPv6:::ffff:134.2.12.32]:17595
	"EHLO mx5.informatik.uni-tuebingen.de") by linux-mips.org with ESMTP
	id <S8225003AbUHKSqO>; Wed, 11 Aug 2004 19:46:14 +0100
Received: from localhost (loopback [127.0.0.1])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id 22F8B10E; Wed, 11 Aug 2004 20:46:07 +0200 (MST)
Received: from mx3.informatik.uni-tuebingen.de ([134.2.12.26])
 by localhost (mx5 [134.2.12.32]) (amavisd-new, port 10024) with ESMTP
 id 30314-05; Wed, 11 Aug 2004 20:46:05 +0200 (DFT)
Received: from dual (semeai.Informatik.Uni-Tuebingen.De [134.2.15.66])
	by mx3.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id 79B18139; Wed, 11 Aug 2004 20:46:03 +0200 (DFT)
Received: from mrvn by dual with local (Exim 4.34)
	id 1Buy6o-0002Xx-MG; Wed, 11 Aug 2004 20:45:59 +0200
To: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Q: XFree86 (on MeshCube) from Debian?
References: <Pine.LNX.4.58.0408110935080.16674@shofar.kom.e-technik.tu-darmstadt.de>
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: Wed, 11 Aug 2004 20:45:57 +0200
In-Reply-To: <Pine.LNX.4.58.0408110935080.16674@shofar.kom.e-technik.tu-darmstadt.de> (Ralf
 Ackermann's message of "Wed, 11 Aug 2004 09:35:35 +0200 (CEST)")
Message-ID: <87smatpl7e.fsf@mrvn.homelinux.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: by amavisd-new (McAfee AntiVirus) at informatik.uni-tuebingen.de
Return-Path: <brederlo@informatik.uni-tuebingen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brederlo@informatik.uni-tuebingen.de
Precedence: bulk
X-list: linux-mips

Ralf Ackermann <rac@KOM.tu-darmstadt.de> writes:

> Hello,
>
> thanks a lot to the persons who helped me setting up a Debian/Sarge 
> environment for the MeshCube (using cdebootstrap worked like a charm).
>
> I may go on with an XFree86 server now (I tried using the ati module):
> ...
> XFree86 Version 4.3.0.1 (Debian 4.3.0.dfsg.1-6 20040709164028 
> root@remake.rfc822
> .org)
> Release Date: 15 August 2003
> X Protocol Version 11, Revision 0, Release 6.6
> Build Operating System: Linux 2.4.25 mips [ELF]
> Build Date: 10 July 2004
> ...
>
> Nevertheless - the server refuses to start because of:
> Fatal server error:
> xf86OpenConsole: Cannot open /dev/tty0 (No such file or directory)
>
> Can this be fixed without having to install an alternative kernel on the 
> cube? (e.g. by loading an additional / which? kernel module?)

cdebootstrap only creates the absolutely essential device nodes for a
chroot. You need more device nodes, udev or devfs.

cd /dev
MAKEDEV generic

> best regards and thanks for your help
>  Ralf

MfG
        Goswin
