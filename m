Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 19:55:28 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:54586 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493376AbZJMRzU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 19:55:20 +0200
Received: by fxm21 with SMTP id 21so8409652fxm.33
        for <multiple recipients>; Tue, 13 Oct 2009 10:55:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=7vdUarBnYv/rnjhQ2mXk9f6qC4xd1MkvKQG4Pe0r8hk=;
        b=YyA/l+czt+gfdM+xUyyf4qVPbwy1RiKy73K1sL5AWCnFCYyJ0mrohLN8Az3UUqtyMI
         +DhxNikgiezxYcJsJTtGrvr5TJ3LloLFE26g+0YmcWB7iXxTbZzeHrdCLVbnGuuIAOB6
         qAkHKeyJseNrh1gYW34H1WiqJFRK/EwGZWz7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=ZUhmhy+jPhAFCyC4r2mkUhiiRJR/BDxMHVVzsvYUyfVEMTev7PU7Yoeo0Z/Tqtrr1z
         2uJUE6nlOq1C1IzoFCrPJnb97Uk9dfrpTzcPHpiT5Domc5UxQ+qc1wqzvzYcftKaVkZd
         nSOuTXbgePlKWQU7JvbsrNFbJ3mIIKTmtMeCk=
MIME-Version: 1.0
Received: by 10.223.5.90 with SMTP id 26mr1735413fau.59.1255456512251; Tue, 13 
	Oct 2009 10:55:12 -0700 (PDT)
Date:	Tue, 13 Oct 2009 20:55:12 +0300
Message-ID: <90edad820910131055t3cb46d39t87fa568c001634cf@mail.gmail.com>
Subject: [RFC] [IP22] parsing PROM variables at startup
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, davem@davemloft.net
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I tried booting a few kernels, ranging from 2.2.1 to the current Linus
Git, on my IP22s using an ecoff image directly, without the help of
arcboot or tip22. It turns out that during many years (at least, since
the times of late 2.4 series) the sizes of ecoff images have been so
big that ARCS was not capable of reading the kernel images. Therefore,
I'd like to claim that it's safe to assume that at least from now on,
nobody is ever going to boot ecoffs on IP22 whatsoever, and arcboot
and tip22 remain the only way to load Linux on an IP22 machine.

I'm leading to the following thing. Currently we have the
arch/mips/fw/arc/cmdline.c, which assumes that the kernel could
receive command-line parameters directly from PROM, including such
variables as OSLoadPartition, OSLoadFilename, etc. Both arcboot and
tip22 handle those parameters by themselves, never exposing them to
the kernel. The latter fact is easy to see from the sources of the
arcboot and tip22 loaders. That said, I would like to simplify
arch/mips/fw/arc/cmdline.c::prom_init_cmdline() so that the PROM
variables do not get any special treatment.

Are you asking me why did I start touching the 13-years-old code?

There is an unpleasant bug in the current PROM command line handler.
Namely, the CONFIG_CMDLINE, if set, is overwritten when
prom_init_cmdline() tries to strip off some of the PROM variables, and
it's easy to see from the code of that function. So, I thought of
fixing that, and, simultaneously, of simplifying the overall logic by
assuming that we never ever have to special-case the PROM variables at
all.

Could anyone see any drawbacks in the discourse above? If not, I'll
start making a patch.

Thanks,
Dmitri
