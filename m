Received:  by oss.sgi.com id <S42212AbQF3Qdz>;
	Fri, 30 Jun 2000 09:33:55 -0700
Received: from Cantor.suse.de ([194.112.123.193]:64017 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S42210AbQF3Qde>;
	Fri, 30 Jun 2000 09:33:34 -0700
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 891111E221; Fri, 30 Jun 2000 18:33:43 +0200 (MEST)
Received: from arthur.inka.de (Galois.suse.de [10.0.0.1])
	by Hermes.suse.de (Postfix) with ESMTP
	id 84D7210A026; Fri, 30 Jun 2000 18:33:42 +0200 (MEST)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 1383e6-0000AY-00; Fri, 30 Jun 2000 18:28:02 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id D8C2F1821; Fri, 30 Jun 2000 18:28:01 +0200 (CEST)
Mail-Copies-To: never
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
Cc:     linux-mips@oss.sgi.com
Subject: Re: glibc 2.2 based root fs available
References: <20000630091524.A32081@chem.unr.edu>
From:   Andreas Jaeger <aj@suse.de>
Date:   30 Jun 2000 18:28:01 +0200
In-Reply-To: Keith M Wesolowski's message of "Fri, 30 Jun 2000 09:15:24 -0700"
Message-ID: <u8aeg35e26.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>>>>> Keith M Wesolowski writes:

 > This is the Simple MIPS/Linux 0.2a 'pre-Alpha and we're not joking'
 > release. You can obtain the kernel from
 > ftp://ftp.foobazco.org/pub/people/wesolows/mips-linux/kernels/vmlinux-24test2
 > and the filesystem from .../mips-linux/testing/core-0.2a.tar.gz. This
 > is a big-endian filesystem and the kernel is for SGI IP22.

 > This is a developer release, mainly to help shake out bugs in the
 > toolchain and glibc. This release will not run properly on kernel
 > 2.2. Mandatory release notes are at
 > .../mips-linux/testing/README.core-02a. There is still a good deal of
 > functionality missing, including the networking utilities, ext2fs

 > tools, and a c++ compiler. This release includes the libemptysymbol
 > hack to work around the "undefined symbol: " problem until it's fixed.

What kind of hack?  Can you make it available to me?  I haven't found
a fix for the problem yet :-(

Thanks a lot for making this available!

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
