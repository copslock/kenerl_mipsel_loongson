Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2005 11:51:50 +0000 (GMT)
Received: from i3ED630B6.versanet.de ([IPv6:::ffff:62.214.48.182]:25446 "EHLO
	arbas.nms.ulrich-teichert.org") by linux-mips.org with ESMTP
	id <S8224992AbVAVLvq>; Sat, 22 Jan 2005 11:51:46 +0000
Received: from arbas.nms.ulrich-teichert.org (localhost [127.0.0.1])
	by arbas.nms.ulrich-teichert.org (8.12.10/8.12.1) with ESMTP id j0MBlBZ4023299
	for <linux-mips@linux-mips.org>; Sat, 22 Jan 2005 12:47:11 +0100
Received: (from ut@localhost)
	by arbas.nms.ulrich-teichert.org (8.12.10/8.12.1/Submit) id j0MBlBfW023297
	for linux-mips@linux-mips.org; Sat, 22 Jan 2005 12:47:11 +0100
Message-Id: <200501221147.j0MBlBfW023297@arbas.nms.ulrich-teichert.org>
X-Authentication-Warning: arbas.nms.ulrich-teichert.org: ut set sender to krypton using -f
Subject: Re: O2 and 128Mb
To:	linux-mips@linux-mips.org
Date:	Sat, 22 Jan 2005 12:47:10 +0100 (MET)
In-Reply-To: <Pine.GSO.4.61.0501220920460.21833@waterleaf.sonytel.be> from "Geert Uytterhoeven" at Jan 22, 2005 09:21:36 AM
From:	Ulrich Teichert <krypton@ulrich-teichert.org>
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <krypton@ulrich-teichert.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krypton@ulrich-teichert.org
Precedence: bulk
X-list: linux-mips

Hi,

[del]
>> Drop minicom, I get nothing but trouble with it.  Use "xc", a small, simple
>
>Indeed.

We couldn't agree more, I suppose ;-)

>> dial program.  If it's not on your system, you'll have to install it via
>> whatever means your working distro provides, then do this:
>> 
>> xc -l/dev/ttyS0
>
>Or you can try `cu' (`apt-get install cu'). 

Or kermit, my personal favourite. "set line /dev/ttyS0" in your .kermrc,
or `kermit -l /dev/ttyS0`.

HTH,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Cauchemar (Opération S)
