Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 09:50:08 +0000 (GMT)
Received: from apollo.ext.eurgw.xerox.com ([IPv6:::ffff:13.16.138.21]:40634
	"EHLO apollo.eurgw.xerox.com") by linux-mips.org with ESMTP
	id <S8225341AbTLIJuH>; Tue, 9 Dec 2003 09:50:07 +0000
Received: from eurodns4.eur.xerox.com (eurodns4.eur.xerox.com [13.202.66.50])
	by apollo.eurgw.xerox.com (8.12.9-20030917/8.12.9) with ESMTP id hB99o1KB029255
	for <linux-mips@linux-mips.org>; Tue, 9 Dec 2003 09:50:01 GMT
Received: from eurdubmg02.eur.xerox.com (eurdubmg02.eur.xerox.com [13.202.65.254])
	by eurodns4.eur.xerox.com (8.12.9/8.12.8) with ESMTP id hB99o0nw006626
	for <linux-mips@linux-mips.org>; Tue, 9 Dec 2003 09:50:00 GMT
Received: from eurgbrbh02.emeacinops.xerox.com (unverified) by eurdubmg02.eur.xerox.com
 (Content Technologies SMTPRS 4.2.10) with ESMTP id <T6666cd5e0d0dca41fe97c@eurdubmg02.eur.xerox.com> for <linux-mips@linux-mips.org>;
 Tue, 9 Dec 2003 09:49:59 +0000
Received: from gbrwgcbh01.wgc.gbr.xerox.com ([13.200.2.175]) by eurgbrbh02.emeacinops.xerox.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id YQB8974A; Tue, 9 Dec 2003 09:49:58 -0000
Received: by gbrwgcbh01.wgc.gbr.xerox.com with Internet Mail Service (5.5.2657.72)
	id <V8CZ2WFD>; Tue, 9 Dec 2003 09:50:21 -0000
Message-ID: <8EAC52A94CD8D411A01000805FBB37760615AF16@gbrwgcms02.wgc.gbr.xerox.com>
From: "Hamilton, Ian" <Ian.Hamilton@gbr.xerox.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: GCC 3.3.2 and Alchemy AU1100
Date: Tue, 9 Dec 2003 09:50:10 -0000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Ian.Hamilton@gbr.xerox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ian.Hamilton@gbr.xerox.com
Precedence: bulk
X-list: linux-mips

Hi there.

I'm trying to build software for the AMD AU1100 processor using version
3.3.2 of the gnu compiler, and I'm having trouble figuring out the -march,
-mtune, etc settings.

Version 2.95 of gcc uses something like -mcpu=r4600, but this doesn't work
with 3.3.2.

I've tried other likely-looking options (e.g. -mips32), but the compiler
fails to assembler instructions like mtc0 and cache.

Has anyone built for the AU1100 using gcc 3.3.2? If so, could you tell me
the cpu options you used please?

Thanks
Ian Hamilton.
