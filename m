Received:  by oss.sgi.com id <S42203AbQF3GzD>;
	Thu, 29 Jun 2000 23:55:03 -0700
Received: from Cantor.suse.de ([194.112.123.193]:14859 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S42194AbQF3Gyk>;
	Thu, 29 Jun 2000 23:54:40 -0700
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 3BBFA1E1A0; Fri, 30 Jun 2000 08:54:48 +0200 (MEST)
Received: from arthur.inka.de (Galois.suse.de [10.0.0.1])
	by Hermes.suse.de (Postfix) with ESMTP
	id BE2F010A028; Fri, 30 Jun 2000 08:54:46 +0200 (MEST)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 137uVi-0006FD-00; Fri, 30 Jun 2000 08:42:46 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 54D181821; Fri, 30 Jun 2000 08:42:45 +0200 (CEST)
Mail-Copies-To: never
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: MIPS symbol versioning patches
References: <Pine.SGI.4.10.10006291446000.17956-100000@thor.tetracon-eng.net>
From:   Andreas Jaeger <aj@suse.de>
Date:   30 Jun 2000 08:42:45 +0200
In-Reply-To: "J. Scott Kasten"'s message of "Thu, 29 Jun 2000 14:47:59 -0300"
Message-ID: <u8u2eb3c0q.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>>>>> J Scott Kasten writes:

J> On Tue, 20 Jun 2000, Ulf Carlsson wrote:

>> Hi Guys,
>> 
>> I have synced the binutils CVS with symbol versioning patches.  The
>> current CVS tree at http://sourceware.cygnus.com/binutils should work
>> now.  I have only tested compile and tests from glibc 2.1.90 so things
>> will probably break badly.  I will be away from my office the next
>> five days, and I will unfortunately not have any machine to work on.
>> 
>> I have verified with glibc CVS from today, glibc 2.96 CVS from today
>> and binutils CVS from today.
>> 
>> Ulf
>> 


J> I take this to mean that we may soon have a working glibc 2.1.xx for MIPS?
No - only a glibc 2.2.

Have a look at http://www.suse.de/~aj/glibc-mips.html

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
