Received:  by oss.sgi.com id <S553669AbRATNds>;
	Sat, 20 Jan 2001 05:33:48 -0800
Received: from Cantor.suse.de ([194.112.123.193]:49158 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S553664AbRATNdb>;
	Sat, 20 Jan 2001 05:33:31 -0800
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 833AF1E11C; Sat, 20 Jan 2001 14:33:29 +0100 (MET)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 14Jxye-0000SR-00; Sat, 20 Jan 2001 14:22:44 +0100
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 368D71822; Sat, 20 Jan 2001 14:22:43 +0100 (CET)
Mail-Copies-To: never
To:     Quinn Jensen <jensenq@Lineo.COM>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Glibc-error.
References: <3A611CFF.FD28766@isratech.ro>
	<u8n1cvf90h.fsf@gromit.rhein-neckar.de> <3A688998.1080608@Lineo.COM>
From:   Andreas Jaeger <aj@suse.de>
Date:   20 Jan 2001 14:22:42 +0100
In-Reply-To: <3A688998.1080608@Lineo.COM> (Quinn Jensen's message of "Fri, 19 Jan 2001 11:38:16 -0700")
Message-ID: <u8puhi8ijh.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Quinn Jensen <jensenq@Lineo.COM> writes:

> I'm curious which version of glibc incorporated
> support for syscall changes that have occured
> with the 2.4.0 kernel.  Or is it all there yet
> even with glibc 2.2.1?

glibc 2.2 and 2.2.1 should support all features and syscalls of 2.4.0
- if not it's a bug in glibc ;-)

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
