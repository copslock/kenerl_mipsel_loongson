Received:  by oss.sgi.com id <S42215AbQF3SQ4>;
	Fri, 30 Jun 2000 11:16:56 -0700
Received: from Cantor.suse.de ([194.112.123.193]:11271 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S42200AbQF3SQa>;
	Fri, 30 Jun 2000 11:16:30 -0700
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 953521E231; Fri, 30 Jun 2000 20:16:38 +0200 (MEST)
Received: from arthur.inka.de (Galois.suse.de [10.0.0.1])
	by Hermes.suse.de (Postfix) with ESMTP
	id 94E6A10A026; Fri, 30 Jun 2000 20:16:37 +0200 (MEST)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 1385IA-0000f2-00; Fri, 30 Jun 2000 20:13:30 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 0DDC81821; Fri, 30 Jun 2000 20:13:29 +0200 (CEST)
Mail-Copies-To: never
To:     drepper@cygnus.com (Ulrich Drepper)
Cc:     libc-alpha Mailinglist <libc-alpha@sourceware.cygnus.com>,
        linux-mips@oss.sgi.com
Subject: Re: origtest failure with MIPS-Linux glibc
References: <u8og4j6w9r.fsf@gromit.rhein-neckar.de>
	<m33dlvgii3.fsf@otr.mynet.cygnus.com>
From:   Andreas Jaeger <aj@suse.de>
Date:   30 Jun 2000 20:13:29 +0200
In-Reply-To: Ulrich Drepper's message of "30 Jun 2000 10:56:36 -0700"
Message-ID: <u8d7kz3uly.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>>>>> Ulrich Drepper writes:

Uli> Andreas Jaeger <aj@suse.de> writes:
>> This test fails on MIPS-Linux since testobj1.so contains an undefined
>> reference to foo which can't be fulfilled.  

Uli> I thought we went over this alread.  There is a definition of `foo',
We spoke about it - but didn't fix it.
Uli> it is in origtest.c.  I MIPS has problems it's in not doing what
Uli> -rdynamic is expected to do.

Uli> $ nm elf/origtest|grep foo
Uli> 08048680 T foo

But origtest doesn't have -rdynamic.  There's no
LDFLAGS-origtest = -rdynamic
in elf/Makefile.  Should it be there?

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
