Received:  by oss.sgi.com id <S553655AbRAMVVI>;
	Sat, 13 Jan 2001 13:21:08 -0800
Received: from Cantor.suse.de ([194.112.123.193]:16655 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S553652AbRAMVUu>;
	Sat, 13 Jan 2001 13:20:50 -0800
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 84C511E2FA; Sat, 13 Jan 2001 22:20:48 +0100 (MET)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 14HY22-0002xJ-00; Sat, 13 Jan 2001 22:16:14 +0100
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id CB9B91822; Sat, 13 Jan 2001 22:16:14 +0100 (CET)
Mail-Copies-To: never
To:     Nicu Popovici <octavp@isratech.ro>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Glibc-error.
References: <3A611CFF.FD28766@isratech.ro>
From:   Andreas Jaeger <aj@suse.de>
Date:   13 Jan 2001 22:16:14 +0100
In-Reply-To: <3A611CFF.FD28766@isratech.ro>
Message-ID: <u8n1cvf90h.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>>>>> Nicu Popovici writes:

 > Hello ,
 > I am struggling to get glibc 2.1.3 working for mips. I have to do this
 > so please not redirect me to another glibc. I did a diff between glibc
 > 2.0.6 for mips and glibc 2.1.3 and now I applied the patch obtained on
 > glibc 2.1.3 . At make I get the following error and I don't know what to
 > do. Maybe someone will help me.

You just can't apply the patch from 2.0.6 to 2.1.3 without any changes
- and you also want to check how I've done it for glibc 2.2.1.  To
much has changed in between and 2.0.6 might just be a basis for you.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
