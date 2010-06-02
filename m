Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 12:17:49 +0200 (CEST)
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:42198 "HELO
        na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491145Ab0FBKRl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 12:17:41 +0200
Received: from source ([209.85.214.179]) by na3sys009aob105.postini.com ([74.125.148.12]) with SMTP
        ID DSNKTAYvwmYU7pKLt3MCju/GmJXoAF0iB0Ae@postini.com; Wed, 02 Jun 2010 03:17:41 PDT
Received: by mail-iw0-f179.google.com with SMTP id 35so1183247iwn.38
        for <linux-mips@linux-mips.org>; Wed, 02 Jun 2010 03:17:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.120.37 with SMTP id b37mr9574909ibr.81.1275473858138; Wed, 
        02 Jun 2010 03:17:38 -0700 (PDT)
Received: by 10.231.182.74 with HTTP; Wed, 2 Jun 2010 03:17:38 -0700 (PDT)
Date:   Wed, 2 Jun 2010 15:17:38 +0500
Message-ID: <AANLkTino_WFpj8aueN4zGwkRV-SCVqA5NGsKQOGU9qho@mail.gmail.com>
Subject: Details of MIPS(Octeon) system call semantics
From:   adnan iqbal <adnan.iqbal@seecs.edu.pk>
To:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=001485e2ebde3c1242048809664f
X-archive-position: 26999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adnan.iqbal@seecs.edu.pk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1201

--001485e2ebde3c1242048809664f
Content-Type: text/plain; charset=ISO-8859-1

hi everybody,

I am able to find system call list (o32 and n64) in
/usr/include/asm/unistd.h over octeon/debian board. I am looking for details
about these system calls so that for each system call i know exactly

1. What parmeters should be set in which registers before syscall
2. Which registers contain output of those system calls.


Thanks in advance for your help.
Regards
Adnan

--001485e2ebde3c1242048809664f
Content-Type: text/html; charset=ISO-8859-1

hi everybody,<br><br>I am able to find system call list (o32 and n64) in /usr/include/asm/unistd.h over octeon/debian board. I am looking for details about these system calls so that for each system call i know exactly<br>
<br>1. What parmeters should be set in which registers before syscall<br>2. Which registers contain output of those system calls.<br><br><br>Thanks in advance for your help.<br>Regards<br>Adnan<br><br>

--001485e2ebde3c1242048809664f--
