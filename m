Received:  by oss.sgi.com id <S42235AbQGEPqV>;
	Wed, 5 Jul 2000 08:46:21 -0700
Received: from Cantor.suse.de ([194.112.123.193]:35598 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S42218AbQGEPqE>;
	Wed, 5 Jul 2000 08:46:04 -0700
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 094F61E245; Wed,  5 Jul 2000 17:46:05 +0200 (MEST)
Received: from arthur.inka.de (Galois.suse.de [10.0.0.1])
	by Hermes.suse.de (Postfix) with ESMTP
	id 8E62F10A028; Wed,  5 Jul 2000 17:46:01 +0200 (MEST)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 139rHI-0003cM-00; Wed, 05 Jul 2000 17:39:56 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 234021822; Wed,  5 Jul 2000 17:39:55 +0200 (CEST)
Mail-Copies-To: never
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: FPU Control Word: Initial Value looks wrong
References: <u8sntrm88t.fsf@gromit.rhein-neckar.de>
	<20000704003232.A2112@bacchus.dhis.org>
	<u8g0pqjfaf.fsf@gromit.rhein-neckar.de>
	<20000705031318.A7627@bacchus.dhis.org>
From:   Andreas Jaeger <aj@suse.de>
Date:   05 Jul 2000 17:39:55 +0200
In-Reply-To: Ralf Baechle's message of "Wed, 5 Jul 2000 03:13:18 +0200"
Message-ID: <u8zonwpovo.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>>>>> Ralf Baechle writes:

Ralf> Looking at the fcr31 bug I found some other bug which probably isn't causing
Ralf> what you observe but is a bug anyway - fpu_control_t was a 16-bit type
Ralf> but should be a 32-bit type.  Patch below.
Thanks, I've commited it.

Ralf> Is _FPU_IEEE used at all and is it's definition right?
It's nowhere used - but each architecture has it.  The value looks fine.

Ralf> I asked more people to run your test program.  The result is that glibc
Ralf> 2.0.6 (both shared and static tried) and 2.2 print ``0 0'' while glibc
Ralf> 2.0.7 prints a non-zero value.

OK, I'll investigate the kernels and glibc I'm running a bit more.

Thanks,
Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
