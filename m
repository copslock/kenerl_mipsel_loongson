Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2008 11:06:35 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:33529 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28586302AbYIRKG3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2008 11:06:29 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8IA6RI6022751;
	Thu, 18 Sep 2008 12:06:27 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8IA6IpW022747;
	Thu, 18 Sep 2008 11:06:27 +0100
Date:	Thu, 18 Sep 2008 11:06:17 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Bryan Phillippe <u1@terran.org>
cc:	linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
In-Reply-To: <4A385D69-6A36-46B5-84C2-32D4C60C3543@terran.org>
Message-ID: <Pine.LNX.4.55.0809181054410.22686@cliff.in.clinika.pl>
References: <072748C6-07A9-4167-A8A5-80D0F7D9C784@darkforest.org>
 <B45397E7-EBE4-497B-9055-42B604A909AA@terran.org>
 <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl>
 <4A385D69-6A36-46B5-84C2-32D4C60C3543@terran.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 17 Sep 2008, Bryan Phillippe wrote:

> FWIW... your patch (below) seems to actually fix the checksum problem  
> in my testing.  What was your concern about it?

 For unaligned buffers the passed checksum is added before the result has
been byte-swapped.  That is probably not seen too often as the network
stack normally aligns IP packets, but it does not make the change correct.  

 One possibility with no performance impact to the common aligned case
would be to byte-swap the passed checksum too, but currently I am somewhat
puzzled about the API of the function; specifically as to whether the
checksums passed to and from it are expected to be folded or not.  The use
of a 32-bit type does not imply it is valid for the upper 16 bits to be
non-zero in the values passed.

  Maciej
