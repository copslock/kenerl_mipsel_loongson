Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2003 13:08:21 +0100 (BST)
Received: from daemon.nethack.at ([IPv6:::ffff:62.116.47.92]:46050 "EHLO
	daemon.nethack.at") by linux-mips.org with ESMTP
	id <S8224821AbTHTMIT>; Wed, 20 Aug 2003 13:08:19 +0100
Received: (qmail 1134 invoked by uid 1000); 20 Aug 2003 12:08:01 -0000
Date: Wed, 20 Aug 2003 14:08:01 +0200
From: Michael Dosser <mic@nethack.at>
To: linux-mips@linux-mips.org
Subject: Re: mips64
Message-ID: <20030820120759.GP15525@nethack.at>
References: <20030820100339.GO15525@nethack.at> <20030820101509.GA16419@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030820101509.GA16419@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4.1i
Organization: Nethack.at
X-Operating-System: Linux 2.4.19 mips
X-sig-random-gen: http://cfml.sourceforge.net/perl/chsig.tar.gz
X-spam-note: Sending SPAM is a violation of both Austrian and US law and will at least trigger a complaint at your providers postmaster.
Return-Path: <mic@daemon.nethack.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mic@nethack.at
Precedence: bulk
X-list: linux-mips

Hi again,

* On 2003-08-20 12:15 <ica2_ts@csv.ica.uni-stuttgart.de> wrote:

> egcs is known to be broken WRT, and horribly outdated anyway.

That's right. But I thought better trying out first before writing an
email.

> No, this ld is too old to handle elf32-tradbigmips.
> You'll need a more up to date toolchain.

I could slap myself for this: I fetched binutils 2.9.5 instead of 2.13.1
while thinking 9 > 1 and not reading 13. *hmpf* Sorry for this. After
installing binutils-2.13.1 the compile went fine.

# ls -l arch/mips64/boot
total 2256
drwxr-xr-x    2 root     root         4096 Aug 20 11:13 CVS
-rw-r--r--    1 root     root          922 Jan 10  2003 Makefile
-rwxr-xr-x    1 root     root         7965 Aug 20 13:44 addinitrd
-rwxr-xr-x    1 root     root        16138 Aug 20 13:44 elf2ecoff
-rwxr-xr-x    1 root     root      2269392 Aug 20 13:44 vmlinux.ecoff
# file arch/mips64/boot/vmlinux.ecoff
vmlinux.ecoff: MIPSEB ECOFF executable (impure) stripped - version 0.200
#

That's it I suppose :) I'm looking forward to test this kernel ...

Thanks for your help.

Ciao,mic

-- 
while !asleep {sheep ++};
