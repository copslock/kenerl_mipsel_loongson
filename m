Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Aug 2004 21:07:08 +0100 (BST)
Received: from mx5.Informatik.Uni-Tuebingen.De ([IPv6:::ffff:134.2.12.32]:25027
	"EHLO mx5.informatik.uni-tuebingen.de") by linux-mips.org with ESMTP
	id <S8225216AbUHLUHE>; Thu, 12 Aug 2004 21:07:04 +0100
Received: from localhost (loopback [127.0.0.1])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id 1CE3B117; Thu, 12 Aug 2004 22:06:58 +0200 (MST)
Received: from mx5.informatik.uni-tuebingen.de ([127.0.0.1])
 by localhost (mx5 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 34540-01; Thu, 12 Aug 2004 22:06:56 +0200 (DFT)
Received: from dual (semeai.Informatik.Uni-Tuebingen.De [134.2.15.66])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id 05D80115; Thu, 12 Aug 2004 22:06:56 +0200 (MST)
Received: from mrvn by dual with local (Exim 4.34)
	id 1BvLqg-0001cO-9O; Thu, 12 Aug 2004 22:06:54 +0200
To: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
Cc: linuxconsole-dev@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: Q: problems with missing /dev/tty0 on X startup in MIPS system
References: <Pine.LNX.4.58.0408121954270.14123@shofar.kom.e-technik.tu-darmstadt.de>
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: Thu, 12 Aug 2004 22:06:53 +0200
In-Reply-To: <Pine.LNX.4.58.0408121954270.14123@shofar.kom.e-technik.tu-darmstadt.de> (Ralf
 Ackermann's message of "Thu, 12 Aug 2004 20:02:28 +0200 (CEST)")
Message-ID: <874qn8m882.fsf@mrvn.homelinux.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: by amavisd-new (McAfee AntiVirus) at informatik.uni-tuebingen.de
Return-Path: <brederlo@informatik.uni-tuebingen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brederlo@informatik.uni-tuebingen.de
Precedence: bulk
X-list: linux-mips

Ralf Ackermann <rac@KOM.tu-darmstadt.de> writes:

> Hello,
>
> I'm trying to get VGA output on a MIPSel system (MeshCube 
> http://www.meshcube.org) to work. 
> The system uses a miniPCI ATI Rage VGA card (=> problem does not get 
> initialized due to lack of system BIOS => hopefully initialized by int10 
> XFree86 x86 emulator code).
>
> I've attached an USB mouse and keyboard but fail to start X due to
>
> Fatal server error:
> xf86OpenConsole: Cannot open /dev/tty0 (No such file or directory)

Didn't you see my mail about MAKEDEV?

MfG
        Goswin
