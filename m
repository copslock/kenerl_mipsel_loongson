Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 02:02:17 +0100 (CET)
Received: from mail-ww0-f49.google.com ([74.125.82.49]:57770 "EHLO
        mail-ww0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492839Ab0BBBCJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2010 02:02:09 +0100
Received: by wwg30 with SMTP id 30so658343wwg.36
        for <linux-mips@linux-mips.org>; Mon, 01 Feb 2010 17:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=GaZLB6Dk3RWy4wgi2SdGToY8vYB/Pif7qxiBw6Sk2Ns=;
        b=vus1cn80kwnQV4HvmmvVCZymu74YmncAyw7jhGw3LkiM2Tin2lFzaoGpasdiv9UwWX
         goxyS3i+MHDCggLPBoesb1cue4HwRwm3KtwLi/OBXb43hKJXJCTP3efki7k8CNPGK7Yc
         7ap42Fpp+DqDAH0reB14vnoNjiB2Kv+2W5ZG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=IaenIMO/ATerVVLriSG3WBqtDagqT8qVkZwgSous2mNxVdNLQB/bfTa3MMQ7G5pwm+
         Q+BBBjO/LMHzUus8Pt/UfSZXca5szwiXOGbzV/LD/xzRqhY5XQOl/Oo3XmGNkIbnIuC9
         QLLxj46OQw9kdAoJgJ9YOxthmxnnFCXpxD02Q=
MIME-Version: 1.0
Received: by 10.216.93.18 with SMTP id k18mr2960331wef.218.1265072524252; Mon, 
        01 Feb 2010 17:02:04 -0800 (PST)
Date:   Mon, 1 Feb 2010 19:02:04 -0600
Message-ID: <83f0348b1002011702j305c726ek18e006dc7c4087aa@mail.gmail.com>
Subject: Problems compiling old code
From:   Ed Okerson <ed.okerson@gmail.com>
To:     linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ed.okerson@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ed.okerson@gmail.com
Precedence: bulk
X-list: linux-mips

I just inherited some old code that was previously being built on
Cygwin with a very old sde-gcc (2.96).  When I attempt to build it on
a Linux machine using a more recent cross compiler and toolchain, I
get the following errors:

mipsel-linux-uclibc-objcopy --output-target=binary prog prog.bin
BFD: Warning: Writing section `.text' to huge (ie negative) file
offset 0x86bfff4c.
BFD: Warning: Writing section `.rodata' to huge (ie negative) file
offset 0x86c3e97c.
BFD: Warning: Writing section `.data.rel.ro' to huge (ie negative)
file offset 0x86c479ec.
BFD: Warning: Writing section `.data' to huge (ie negative) file
offset 0x86c4896c.
BFD: Warning: Writing section `.got' to huge (ie negative) file offset
0x86c4d35c.
BFD: Warning: Writing section `.sdata' to huge (ie negative) file
offset 0x86c4d84c.
mipsel-linux-uclibc-objcopy: prog.bin: File truncated

Is there a simple solution to this?  My Google skills must be waning
as I was unable to find anything helpful. :(

Ed Okerson
