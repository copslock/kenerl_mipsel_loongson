Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 10:15:13 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:36626 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20029430AbXIZJPF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 10:15:05 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E92AED8DF; Wed, 26 Sep 2007 09:14:57 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 53CAA542CF; Wed, 26 Sep 2007 11:14:43 +0200 (CEST)
Date:	Wed, 26 Sep 2007 11:14:43 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
Message-ID: <20070926091443.GA10236@deprecation.cyrius.com>
References: <20070925181353.GA15412@deprecation.cyrius.com> <46FA1260.4000404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46FA1260.4000404@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Franck Bui-Huu <vagabon.xyz@gmail.com> [2007-09-26 10:03]:
> To verify this, could you apply the following patch _without_ Ralf's
> commit and report back the trace. You may need to enable early printk
> to see something and be sure CONFIG_KALLSYMS_ALL is set.

5152902+253674 entry: 0x804ac000
Linux version 2.6.22-2-r5k-ip32 (2.6.22-5) (tbm@em64t) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #3 Wed Sep 26 09:10:31 UTC 2007
ARCH: SGI-IP32
PROMLIB: ARC firmware Version 1 Revision 10
CRIME id a rev 1 at 0x0000000014000000
CRIME MC: bank 0 base 0x0000000000000000 size 128MiB
CRIME MC: bank 1 base 0x0000000008000000 size 128MiB
CRIME MC: bank 2 base 0x0000000050000000 size 32MiB
CRIME MC: bank 3 base 0x0000000052000000 size 32MiB
CPU revision is: 00002321
FPU revision is: 00002310
Determined physical RAM map:
 memory: 0000000010000000 @ 0000000000000000 (usable)
 memory: 0000000004000000 @ 0000000050000000 (usable)
*** __pa: symbol in CKSEG0 found: wireless_nlevent_queue+0x20/0x20

Exception: <vector=Normal>
Status register: 0x34010082<CU1,CU0,FR,DE,IPL=8,KX,MODE=KERNEL>
Cause register: 0x8024<CE=0,IP8,EXC=BREAK>
Exception PC: 0x804bbc2c, Exception RA: 0x804bbc2c
Breakpoint exception at address 0xbffffff7
  Saved user regs in hex (&gpda 0x810617b8, &_regs 0x810619b8):
  arg: 81070000 2f1 0 1
  tmp: 81070000 8052bf70 a13fb518 81077d40 8052bf70 a13fba0c 810723b0 81054090
  sve: 81070000 4015fa0c 0 4618fbd8 0 4047cfc7 0 3ebf5e51
  t8 81070000 t9 0 at 0 v0 402003f7 v1 0 k1 46
  gp 81070000 fp 0 sp 0 ra 0

PANIC: Unexpected exception

-- 
Martin Michlmayr
http://www.cyrius.com/
