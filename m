Received:  by oss.sgi.com id <S42273AbQJKFjj>;
	Tue, 10 Oct 2000 22:39:39 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:52758 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42247AbQJKFjT>;
	Tue, 10 Oct 2000 22:39:19 -0700
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id WAA08270
	for <linux-mips@oss.sgi.com>; Tue, 10 Oct 2000 22:30:52 -0700 (PDT)
	mail_from (kaos@melbourne.sgi.com)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id QAA13560; Wed, 11 Oct 2000 16:36:00 +1100
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Cort Dougan <cort@fsmlabs.com>
cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: modutils bug? 'if' clause executes incorrectly 
In-reply-to: Your message of "Tue, 10 Oct 2000 22:43:17 MDT."
             <20001010224317.I733@hq.fsmlabs.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 11 Oct 2000 16:36:00 +1100
Message-ID: <9251.971242560@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 10 Oct 2000 22:43:17 -0600, 
Cort Dougan <cort@fsmlabs.com> wrote:
>I'm finding that in a Linux/MIPS module the test case attached executes the
>'if' clause in

Almost certainly nothing to do with modutils, insmod just relocates and
loads the program.  The only possible modutil problems are an
unexpected relocation being emitted by binutils or insmod not handling
a valid relocation correctly.  Compile with -g then do "objdump -rS
object.o".  What does the offending section of code look like,
including the relocations?
