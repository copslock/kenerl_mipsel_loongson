Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3QH0jX18015
	for linux-mips-outgoing; Thu, 26 Apr 2001 10:00:45 -0700
Received: from techunix.technion.ac.il (techunix.technion.ac.il [132.68.1.28])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3QH0iM18012
	for <linux-mips@oss.sgi.com>; Thu, 26 Apr 2001 10:00:44 -0700
Received: from jungo.com (csrover3-p4.cs.technion.ac.il [132.68.38.194])
	by techunix.technion.ac.il (Postfix) with ESMTP
	id 0618A154A9; Thu, 26 Apr 2001 20:00:41 +0300 (IDT)
Message-ID: <3AE86354.117899E@jungo.com>
Date: Thu, 26 Apr 2001 20:05:08 +0200
From: Michael Shmulevich <michaels@jungo.com>
X-Mailer: Mozilla 4.7 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
Cc: Ian Soanes <ians@lineo.com>, Linux/MIPS <linux-mips@oss.sgi.com>
Subject: Re: usermode gdb / remote gdb
References: <3AE67CBA.4060606@jungo.com> <3AE69AAA.76A20F08@lineo.com> <3AE6A795.1080004@jungo.com> <3AE6B14F.B5844932@lineo.com> <3AE70BBA.2BD8B387@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun,

Jun Sun wrote:

>
> Hmm, I added linux-mips target for gdbserver in gdb 4.17.  And I thought Ralf
> sent the patch back to FSF (as I had to fill out some copyright forms).
> Perhaps it is lost somewhere?
>
> Anyhow, here is the patch that I submitted.  Hopefully it helps.
>
> Jun
>

>From the patch you've sent I see most of changes were made for mipsel.
Could I use similar updates
for mips(EB)?
Anyway, in my default  gdb-5.0 gdb/config/mips/  doesn't contain any
?m-linux.h headers. That's why
configure fails, I suppose.

Thanks,
Michael.
