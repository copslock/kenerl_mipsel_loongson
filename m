Received:  by oss.sgi.com id <S42218AbQF3Su0>;
	Fri, 30 Jun 2000 11:50:26 -0700
Received: from Cantor.suse.de ([194.112.123.193]:31752 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S42200AbQF3SuJ>;
	Fri, 30 Jun 2000 11:50:09 -0700
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id C0A4B1E233; Fri, 30 Jun 2000 20:50:17 +0200 (MEST)
Received: from arthur.inka.de (Galois.suse.de [10.0.0.1])
	by Hermes.suse.de (Postfix) with ESMTP
	id 0299D10A026; Fri, 30 Jun 2000 20:50:17 +0200 (MEST)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 1385gm-0000rY-00; Fri, 30 Jun 2000 20:38:56 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 690661821; Fri, 30 Jun 2000 20:38:55 +0200 (CEST)
Mail-Copies-To: never
To:     drepper@cygnus.com (Ulrich Drepper)
Cc:     libc-alpha Mailinglist <libc-alpha@sourceware.cygnus.com>,
        linux-mips@oss.sgi.com
Subject: Re: origtest failure with MIPS-Linux glibc
References: <u8og4j6w9r.fsf@gromit.rhein-neckar.de>
	<m33dlvgii3.fsf@otr.mynet.cygnus.com>
	<u8d7kz3uly.fsf@gromit.rhein-neckar.de>
	<m3n1k3f2hq.fsf@otr.mynet.cygnus.com>
From:   Andreas Jaeger <aj@suse.de>
Date:   30 Jun 2000 20:38:55 +0200
In-Reply-To: Ulrich Drepper's message of "30 Jun 2000 11:27:45 -0700"
Message-ID: <u84s6b3tfk.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>>>>> Ulrich Drepper writes:

Uli> Andreas Jaeger <aj@suse.de> writes:
>> But origtest doesn't have -rdynamic.  There's no
>> LDFLAGS-origtest = -rdynamic
>> in elf/Makefile.  Should it be there?

Uli> Look again :-)

One test failure less ;-).

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
