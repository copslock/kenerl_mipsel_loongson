Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Feb 2005 01:56:10 +0000 (GMT)
Received: from noon.org ([IPv6:::ffff:192.220.74.114]:36874 "EHLO noon.org")
	by linux-mips.org with ESMTP id <S8224930AbVBPBzy>;
	Wed, 16 Feb 2005 01:55:54 +0000
Received: (qmail 4582 invoked by uid 19058); 16 Feb 2005 01:55:51 -0000
Received: from unknown (HELO SJC-FNOON2) ([192.220.74.114])
          (envelope-sender <fcn@noon.org>)
          by 192.220.74.114 (qmail-ldap-1.03) with SMTP
          for <blind-copy@noon.org>; 16 Feb 2005 01:55:51 -0000
To:	<linux-mips@linux-mips.org>
Subject: kernel for custom MV64341 board?
X-Attribution: Fredrik
X-URL:	<http://www.noon.org>
X-Request-PGP: http://noon.org/keys/pgpkey.txt
From:	Fredrik <fcn-sub@noon.org>
Date:	Tue, 15 Feb 2005 17:55:50 -0800
Message-ID: <ubrale09l.fsf@noon.org>
User-Agent: Gnus/5.090024 (Oort Gnus v0.24) Emacs/21.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <fcn@noon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fcn-sub@noon.org
Precedence: bulk
X-list: linux-mips

Howdy,

I'm getting a custom board going: it sports an RM7000 and Marvell
MV64341 system controller (alas, no external UART!).  I've hacked
U-Boot to the point where I can TFTP a kernel image and (start to)
boot it.

So far I've been using an old 2.4 kernel I used for some Ocelot-G
work, just to get past the TFTP-load stage. MY QUESTION IS: What would
be the best kernel version for me to now start customizing for my
board?  Is 2.6 too bleeding-edge, 2.4 too moldy, or what?  Dealing
with the MV64341 will be most of the effort, of course.

The Ocelot boards seem well supported, but there looks to be a lot of
code that would have to change (different system controller, different
memory map--though I'm flexible--a lot of assumptions about the
goodies available on-board, etc.).  This is the first time I'll be
porting the kernel, so it might be more productive for me to start
from a minimalist configuration and add-in what I need.  Enough code
to set up the memory configuration would be a big help.

Suggestions?

/Fredrik

+----------------------------------------------------------------+
|            Fredrik Noon,   Senior Software Engineer            |
|            Hifn, Inc.      www.hifn.com                        |
|            fnoon@hifn.com  +1 408 399 3630                     |
|-------------------+--------------------------------------------|
|  pgp key: <http://noon.org/keys/pgpkey.txt> 7840AC55           |
+----------------------------------------------------------------+
