Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2005 08:46:02 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.188]:36800
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224930AbVA1Ipq> convert rfc822-to-8bit; Fri, 28 Jan 2005 08:45:46 +0000
Received: from [212.227.126.206] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CuRl9-0000OQ-00
	for linux-mips@linux-mips.org; Fri, 28 Jan 2005 09:45:43 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1CuRl9-0001Su-00
	for linux-mips@linux-mips.org; Fri, 28 Jan 2005 09:45:43 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: Compiler erros in process.c
Date:	Fri, 28 Jan 2005 09:47:52 +0100
User-Agent: KMail/1.7.1
References: <NHBBLBCCGMJFJIKAMKLHEEKACCAA.ralf.roesch@rw-gmbh.de>
In-Reply-To: <NHBBLBCCGMJFJIKAMKLHEEKACCAA.ralf.roesch@rw-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501280947.53038.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Ralf Rösch wrote:
> The last commit of process.c (version 1.73, 2.6)
> results in compiler errors on my system:
>
> arch/mips/kernel/process.c: In function `dump_regs':
> arch/mips/kernel/process.c:169: error: `EF_CP0_EPC' undeclared [...]
> arch/mips/kernel/process.c:170: error: `EF_CP0_BADVADDR' undeclared [...]
> arch/mips/kernel/process.c:171: error: `EF_CP0_STATUS' undeclared [...]
> arch/mips/kernel/process.c:172: error: `EF_CP0_CAUSE' undeclared [...]

The culprit of this seems to be 'include/asm-mips/reg.h' (and that both of us 
didn't listen to what CVS was telling them..). This file recently was 
switched from a generated file to a real sourcefile. CVS told you that there 
was a file in the way when calling 'cvs up', so all you have to do is to 
remove it, update again and there will be peace on earth.

TGIF

Uli
