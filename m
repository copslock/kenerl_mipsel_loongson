Received:  by oss.sgi.com id <S42450AbQIGIRG>;
	Thu, 7 Sep 2000 01:17:06 -0700
Received: from Cantor.suse.de ([194.112.123.193]:24078 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S42333AbQIGIQp>;
	Thu, 7 Sep 2000 01:16:45 -0700
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id D221D1E294; Thu,  7 Sep 2000 10:16:43 +0200 (MEST)
Received: from arthur.inka.de (Galois.suse.de [10.0.0.1])
	by Hermes.suse.de (Postfix) with ESMTP
	id 20EAC10A063; Thu,  7 Sep 2000 10:16:43 +0200 (MEST)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 13Wwqw-0003t3-00; Thu, 07 Sep 2000 10:16:10 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 59A491822; Thu,  7 Sep 2000 10:16:09 +0200 (CEST)
Mail-Copies-To: never
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
Cc:     Guido Guenther <guido.guenther@gmx.net>, linux-mips@oss.sgi.com
Subject: Re: latest glibc from cvs fails to build
References: <20000906222133.A1052@bilbo.physik.uni-konstanz.de>
	<20000906141248.A18088@chem.unr.edu>
From:   Andreas Jaeger <aj@suse.de>
Date:   07 Sep 2000 10:16:09 +0200
In-Reply-To: Keith M Wesolowski's message of "Wed, 6 Sep 2000 14:12:49 -0700"
Message-ID: <u84s3s1ut2.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>>>>> Keith M Wesolowski writes:

 > Unfortunately, there's another problem that looks less easy to fix. In
 > the link phase later on, __syscall_getdents64 will be undefined. I am
 > uncertain what needs to be done to fix this (anyone?).
You should have told me before - I'm running Linux 2.2.

I've just checked in a patch to the glibc CVS archive to fix this,
please test it and tell me if you encounter problems.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
