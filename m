Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 17:21:38 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.169]:43406 "EHLO
	wf-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S28578119AbYGYQVg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Jul 2008 17:21:36 +0100
Received: by wf-out-1314.google.com with SMTP id 27so3284315wfd.21
        for <linux-mips@linux-mips.org>; Fri, 25 Jul 2008 09:21:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=s2QPkfvtT2f9SlJNgdBPz7pEa95zh5BmDo9mam+2U8c=;
        b=J4AtZz2nsqjHxMn/KGLzsxDCgUUhZFZXF9cOMSTUi6yQnjDsLCVz9loNbOWCR4RyuI
         SKRe78KJSM1g+qVe+eoxNNBQy4Lfk9SfFfCKz37G1OXnh9knyC5ReBqIfSs6FPy5FV61
         PP3UIEjWoRkviTVJ/X3k+GfWUcEnCSEzlgM0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=eQygZmlsTAcFHBbSwS1sUMjM1d6nJjiNtmQCVxFKy37LU6kRFGo/JbN1NJjZ1CBhmW
         mZD274DTpYF4sf8j5Y82gVKHyD5ukHygwHmms5WZlij7AzqN0pI/tsXwEs8TFAj6iqjq
         Q8WVoWpACYxGPAHN0Q3PYtOtIprZGeQFRZbW0=
Received: by 10.142.132.2 with SMTP id f2mr596775wfd.287.1217002894084;
        Fri, 25 Jul 2008 09:21:34 -0700 (PDT)
Received: by 10.142.49.17 with HTTP; Fri, 25 Jul 2008 09:21:33 -0700 (PDT)
Message-ID: <64660ef00807250921h75ec4e48v92ef964e1c1185f4@mail.gmail.com>
Date:	Fri, 25 Jul 2008 17:21:33 +0100
From:	"Daniel Laird" <daniel.j.laird@nxp.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Is the new generic KGDB patch in upstream-akpm?
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: a3bcec512ec8d05a
Return-Path: <daniel.j.laird@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

I am trying to respin the patch to add pnx833x support to linux 2.6.27.
I wanted to patch against the new generic kernel KGDB patch.
So I removed gdb-hook etc.

However when I compile I get
arch/mips/kernel/built-in.o: In function `early_console_write':
early_printk.c:(.init.text+0x1450): undefined reference to `prom_putchar'
early_printk.c:(.init.text+0x1450): relocation truncated to fit:
R_MIPS_26 against `prom_putchar'
early_printk.c:(.init.text+0x145c): undefined reference to `prom_putchar'
early_printk.c:(.init.text+0x145c): relocation truncated to fit:
R_MIPS_26 against `prom_putchar'
make[1]: *** [.tmp_vmlinux1] Error 1

These functions were defined in my gdb-hook.c.  Do I need to move
these somewhere else now? Or just not support EARLY_PRINTK etc.

Is this true?
Cheers
Daniel Laird
