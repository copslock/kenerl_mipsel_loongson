Received:  by oss.sgi.com id <S553809AbRAOHKg>;
	Sun, 14 Jan 2001 23:10:36 -0800
Received: from Cantor.suse.de ([194.112.123.193]:34066 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S553801AbRAOHKR>;
	Sun, 14 Jan 2001 23:10:17 -0800
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 3408B1E0D7; Mon, 15 Jan 2001 08:10:15 +0100 (MET)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 14I3fc-0008LH-00; Mon, 15 Jan 2001 08:03:12 +0100
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id F150A1822; Mon, 15 Jan 2001 08:03:11 +0100 (CET)
To:     Hiroyuki Machida <machida@sm.sony.co.jp>
Cc:     linux-mips@oss.sgi.com
Subject: Re: pthread_sighander() of glibc-2.2 breaks stack
References: <20010115152011L.machida@sm.sony.co.jp>
From:   Andreas Jaeger <aj@suse.de>
Date:   15 Jan 2001 08:03:11 +0100
In-Reply-To: <20010115152011L.machida@sm.sony.co.jp>
Message-ID: <u8lmsd8fgw.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>>>>> Hiroyuki Machida writes:

 > Hello Andreas,

 > I had a experience that pthread_sighander() of current glibc-2.2 
 > breaks stack. I tracked down the problem, and finally found the
 > mismatch  between kenrel and glibc-2.2. 

 > Current kernel pass following args to the signal handler for the 
 > case of not SA_SIGINFO specified.
 > 	a0	signal number
 > 	a1	0 (cause code?)
 > 	a2	pointer to sigcontext struct

 > But, the pthread_sighander() of glibc-2.2 expects;
 > 	1st arg.	signal number
 > 	2nd arg.	sigcontext struct itself (not pointer)

 > Patches attached below. Please apply.

Thanks, I've committed them,

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
