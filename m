Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 00:32:16 +0000 (GMT)
Received: from mx01.hansenet.de ([213.191.73.25]:35001 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S28577066AbXLRAcH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Dec 2007 00:32:07 +0000
Received: from [213.39.184.147] (213.39.184.147) by webmail.hansenet.de (7.3.118.12) (authenticated as mbx20228207@koeller-hh.org)
        id 4761398E00AECD15; Tue, 18 Dec 2007 01:31:47 +0100
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id D9ADE47C10;
	Tue, 18 Dec 2007 01:31:40 +0100 (CET)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To:	linux-mips@linux-mips.org
Subject: excite patches
Date:	Tue, 18 Dec 2007 01:31:21 +0100
User-Agent: KMail/1.9.7
MIME-Version: 1.0
Content-Disposition: inline
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200712180131.22459.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Here is a series of patches to bring the excite platform up to date. In
order to achieve this, I had to apply a couple of changes to some
non-platform code as well:

Patch 1/4:
This one introduces a new configuration parameter named GPI_RM9000, used
to enable devices that depend on RM9000-style GPI hardware. This is a
re-submit, I submitted this patch before, but it has not been applied yet.

Patch 2/4:
The RM9000 hazards in include/asm-mips/hazards.h were apparently wrong; I
could not get c0_compare_int_usable() in arch/mips/kernel/cevt-r4k.c to
work. The RM9122 manual says, "When a CP0 register is changed by an MTC0
or CTC0 instruction, the contents of the changed register must not be used
for 4 cycles after the MTC0 or CTC0 is issued. Specifically, if a CP0
register is loaded, its contents must not be read back or otherwise used
until 4 cycles later." I guess this also covers the case of observing
the result of writing to a CP0 register by reading the contents of
another CP0 register, as in this case.

Patch 3/4:
Since the excite platform uses the RM9000's alternate timer interrupt, I
had to rework the compare interrupt setup. I changed the existing
get_c0_compare_int() hook to be called earlier than before, so that
cp0_compare_irq contains the correct value right from the start, and
functions like c0_compare_int_pending() and c0_compare_int_usable()
continue to function without any need for modifications. Then I added a
get_c0_perfcounter_int() hook to complement it. I also did some
minor modifications, like adding 'const' in some places, and outputting
an error message if the compare interrupt is found to be non-functional,
a condition that certainly deserves such a message.

Since the get_c0_compare_int() hook is used in 
arch/mips/mips-boards/generic/time.c,
users of this file might theoretically be affected by this change. I do not 
have
access to these boards, so I could not check, however, I believe the
change does not cause any breakage here.

Patch 4/4:
Finally, the excite platform has to supply the alternate compare irq, which
this patch is for.

tk

-- 
_______________________________

Thomas Köller, Software Developer

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel. +49 (0) 4102 - 463 390
Fax +49 (0) 4102 - 463 390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com

Vorstand: Dr.-Ing. Dietmar Ley (Vorsitzender) · John P. Jennings · Peter 
Krumhoff · Aufsichtsratsvorsitzender: Norbert Basler
Basler AG · Amtsgericht Ahrensburg HRB 4090 · Ust-IdNr.: DE 135 098 121 · 
Steuer-Nr.: 30 292 04497

_______________________________
