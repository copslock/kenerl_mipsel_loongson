Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2005 14:43:57 +0000 (GMT)
Received: from emmental.realmagic.fr ([IPv6:::ffff:82.229.218.57]:51405 "EHLO
	bunker.france.sdesigns.com") by linux-mips.org with ESMTP
	id <S8229638AbVCYOnm>; Fri, 25 Mar 2005 14:43:42 +0000
Received: from [172.27.0.88] (nikita.france.sdesigns.com [172.27.0.88])
	by bunker.france.sdesigns.com (Postfix) with ESMTP id BC4AB9D4A0
	for <linux-mips@linux-mips.org>; Fri, 25 Mar 2005 15:43:40 +0100 (CET)
Subject: kernel oops -> bootloader path
From:	Emmanuel Michon <em@realmagic.fr>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Organization: REALmagic France SAS
Message-Id: <1111761820.28989.407.camel@nikita.france.sdesigns.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Fri, 25 Mar 2005 15:43:40 +0100
Content-Transfer-Encoding: 7bit
Return-Path: <em@realmagic.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: em@realmagic.fr
Precedence: bulk
X-list: linux-mips

Hi,

is there a `standard' mechanism by which a fatal mips linux kernel
error drops the user back to the bootloader (typically YAMON) for
stack review / disassemble / maybe... resume?

Is this the purpose of BEV bit?

Sincerely yours,

E.M.
