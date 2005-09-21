Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2005 15:43:47 +0100 (BST)
Received: from mail.gmx.net ([IPv6:::ffff:213.165.64.20]:23754 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225263AbVIUOnZ>;
	Wed, 21 Sep 2005 15:43:25 +0100
Received: (qmail 5280 invoked by uid 0); 21 Sep 2005 14:43:18 -0000
Received: from 62.2.248.2 by www52.gmx.net with HTTP;
	Wed, 21 Sep 2005 16:43:19 +0200 (MEST)
Date:	Wed, 21 Sep 2005 16:43:19 +0200 (MEST)
From:	phess.linux@streber24.de
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Subject: newbie question
X-Priority: 3 (Normal)
X-Authenticated: #25484589
Message-ID: <21597.1127313799@www52.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <phess.linux@streber24.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phess.linux@streber24.de
Precedence: bulk
X-list: linux-mips

Hi there!

First I have to say that I'm a newbie without any experience with "linux
kernel". So don't blame me ;-)

I downloaded toolchains from MIPS Technologies.
I downloaded the newest version Linux 2.6.14-rc1 via CVS.

I installed the toolchain and tested some examples like "hello world" and
"minicom". They worked fine. I copied the linux kernel into a new folder of
the toolchain example directory. Then I tried to make (with command sde-make
menuconfig and then sde-make SBD=GSIM32L) the linux kernel. But all I get
are the following five lines:

  CHK     include/linux/version.h
  CC      arch/mips/kernel/asm-offsets.s
gcc: cannot specify -o with -c or -S and multiple compilations
sde-make[1]: *** [arch/mips/kernel/asm-offsets.s] Error 1
sde-make: *** [prepare0] Error 2

Now I need some help. Thx!

-- 
GMX DSL = Maximale Leistung zum minimalen Preis!
2000 MB nur 2,99, Flatrate ab 4,99 Euro/Monat: http://www.gmx.net/de/go/dsl
