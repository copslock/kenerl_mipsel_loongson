Received:  by oss.sgi.com id <S553663AbQJTLKC>;
	Fri, 20 Oct 2000 04:10:02 -0700
Received: from Cantor.suse.de ([194.112.123.193]:60937 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S553659AbQJTLJq>;
	Fri, 20 Oct 2000 04:09:46 -0700
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 5F6811E1B6; Fri, 20 Oct 2000 13:09:44 +0200 (MEST)
Received: from arthur.inka.de (Galois.suse.de [10.0.0.1])
	by Hermes.suse.de (Postfix) with ESMTP
	id 9A4773E46A; Fri, 20 Oct 2000 13:09:42 +0200 (MEST)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 13ma3M-0001rD-00; Fri, 20 Oct 2000 13:09:36 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 7ABC21822; Fri, 20 Oct 2000 13:09:35 +0200 (CEST)
Mail-Copies-To: never
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
References: <39E7EB73.9206D0DB@mvista.com>
From:   Andreas Jaeger <aj@suse.de>
Date:   20 Oct 2000 13:09:35 +0200
In-Reply-To: <39E7EB73.9206D0DB@mvista.com>
Message-ID: <u8k8b3ydjk.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I'd like to add the following paragraph to the glibc2 FAQ.  Is this
correct?

Btw. I've updated my www page.

Andreas

??mips	Which tools should I use for MIPS?

{AJ} Either use as compiler egcs 1.1.2 or the current development version of
gcc 2.96 from CVS.  gcc 2.95.x does not work correctly on mips-linux.

You need recent binutils, anything before and including 2.10 will not work
correctly.  Either try the Linux binutils 2.10.0.26 from HJ Lu or the
current development version of binutils.

For details check also my page <http://www.suse.de/~aj/glibc-mips.html>.

-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
