Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2010 18:11:10 +0200 (CEST)
Received: from mail-wy0-f176.google.com ([74.125.82.176]:43242 "EHLO
        mail-wy0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492147Ab0D0QLH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Apr 2010 18:11:07 +0200
Received: by wyb40 with SMTP id 40so3094315wyb.35
        for <linux-mips@linux-mips.org>; Tue, 27 Apr 2010 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=By19QUSI7ibvzTJxgBGh5y38gORZ9V2ObRyy7k38nWk=;
        b=N6V6KVNs8t91I3Tc3pjCWpMiugr5bywoc6GOf8vr1IZTIQN+N/SMmQB/8j3StuKLIP
         D+Ar/1wtUbfi5foaJURewAK0+3NcCADQ1HGyrUTFlwDyHfUq0VgCXnZDT7i4zRJfG8zS
         irXeEysFEKrutVbMMzC6TJEWBoAvZ2OSEAhMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Di7CjJyRmh+fU2yFXHYSvmuxBfl5ATYDhZKDPL69SU6pP5hRV/i6Npymw/FpFD/im3
         yXWD5pjAuySuqnKKOdCEgKJXklp3zJ7denlBrtv0567nXZvvSJKcLodU8WAxpOWliiYU
         tycNb/msalXDXJ0iaRKwfwK+XgJ38V852RQ+8=
MIME-Version: 1.0
Received: by 10.216.87.80 with SMTP id x58mr8406657wee.96.1272384660733; Tue, 
        27 Apr 2010 09:11:00 -0700 (PDT)
Received: by 10.216.166.12 with HTTP; Tue, 27 Apr 2010 09:11:00 -0700 (PDT)
Date:   Tue, 27 Apr 2010 09:11:00 -0700
Message-ID: <o2n545ef25e1004270911m5d96ff8by38fa55c7172401a4@mail.gmail.com>
Subject: issue with gdb load_symbol_file command when loading symbols for MIPS 
        kernel modules
From:   David Olien <dmo.lists@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmo.lists@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmo.lists@gmail.com
Precedence: bulk
X-list: linux-mips

I am using gdb version 6.8-1, running on an x86-64 platform with
kernel version 2.6.26-2-686
(it's a Debian distrubtion) to debug a remote MIPS kernel, 2.6.22.  I
have built the gdb on the
x86 machine, using the configuration parameter
--target=mipsel-unknown-linux-gnu.

After loading the kernel modules on the remote mips machine, I get the
module load addresses
from /proc/modules on the remote machine, and try to add them to the
gdb's symbol table on
 the local machine, using the command:

add-symbol-file {path to local copy of the remote machine's .ko file}
                 {module load address retreived from remote machine's
                 /proc/modules}

After I do this, I can see that .text symbols are translated correctly
to their memory address on the
remote machine.

But sumbols from the .bss and .data sections are NOT translated
properly. In fact, the translate to
addresses that are not even in the range of addresses valid for the kernel.

Since then, I tried calculating which sections are loaded from the
.ko, and where each section gets
loaded into kernel memory (I put print statements in the remote
kernel's kernel/modules.c source file).

If I then give add-symbol-file the address of every loaded section,
then I get properly translated
symbols for .data and .bss.

I have noticed that the address caluclation code in gdb's symfile.c is
similar to but different from
 that in the kernel's module.c file.

I am suspecting that the MIPS compiler tools are producing .ko files
that are different enough in
some way to confuse gdb's code in symbfile.c.

Has anyone else encountered this, or have any suggestions?  As a work
around, I'm planning to
write a utility with code stolen from kernel/modules.c  that will
calculate for me the section addresses
 based on the module loading address.  But it would be nice if gdb did
that calculation for me,
as I suspect it would for an x86 system.

Any suggestions?

Thanks!
Dave
