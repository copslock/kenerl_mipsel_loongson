Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2004 00:46:30 +0000 (GMT)
Received: from [IPv6:::ffff:65.205.244.70] ([IPv6:::ffff:65.205.244.70]:14764
	"EHLO envy.pioneer-pra.com") by linux-mips.org with ESMTP
	id <S8225331AbUCRAq3>; Thu, 18 Mar 2004 00:46:29 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by envy.pioneer-pra.com (Postfix) with ESMTP id 98493377E8
	for <linux-mips@linux-mips.org>; Wed, 17 Mar 2004 16:46:19 -0800 (PST)
Received: from envy.pioneer-pra.com ([127.0.0.1])
 by localhost (envy.pioneer-pra.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 19758-07 for <linux-mips@linux-mips.org>;
 Wed, 17 Mar 2004 16:46:18 -0800 (PST)
Received: from pioneer-pra.com (rberkoff.int.pioneer-pra.com [10.0.2.13])
	by envy.pioneer-pra.com (Postfix) with ESMTP id 8F9C7377DD
	for <linux-mips@linux-mips.org>; Wed, 17 Mar 2004 16:46:18 -0800 (PST)
Message-ID: <4058F168.8000704@pioneer-pra.com>
Date: Wed, 17 Mar 2004 16:46:32 -0800
From: Russell Berkoff <rberkoff@pioneer-pra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips <linux-mips@linux-mips.org>
Subject: asm-mips/ptrace.h pt_regs vs gdb 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <rberkoff@pioneer-pra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rberkoff@pioneer-pra.com
Precedence: bulk
X-list: linux-mips

Hi,

It looks like gdb-6.0 (see gdb/mips-linux-tdep.c) uses hardcoded 
offsets  to decipher the register frame section of generated core files.

Unfortunately, someone decided to rearrange the registers in 
asm-mips/ptrace.h struct pt_regs somewhere between linux-mips 2.4.5 and 
2.4.23, so now gdb-6.0
(at least out-of-the-can version) displays incorrect mips register state.

Can someone address this.

Thanks.

Regards,
Russell Berkoff
Pioneer Electronics.
