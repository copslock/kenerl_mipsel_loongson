Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2012 10:34:34 +0100 (CET)
Received: from ra.se.axis.com ([195.60.68.13]:33795 "EHLO ra.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903556Ab2BTJe2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2012 10:34:28 +0100
Received: from localhost (localhost [127.0.0.1])
        by ra.se.axis.com (Postfix) with ESMTP id 9D61216730C
        for <linux-mips@linux-mips.org>; Mon, 20 Feb 2012 10:34:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
        by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id aTXY57rIJBFe for <linux-mips@linux-mips.org>;
        Mon, 20 Feb 2012 10:34:22 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by ra.se.axis.com (Postfix) with ESMTP id 195141672C1
        for <linux-mips@linux-mips.org>; Mon, 20 Feb 2012 10:34:22 +0100 (CET)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
        by seth.se.axis.com (Postfix) with ESMTP id 058EA3E0A5
        for <linux-mips@linux-mips.org>; Mon, 20 Feb 2012 10:34:22 +0100 (CET)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Mon, 20 Feb 2012 10:34:22 +0100
From:   Mikael Starvik <mikael.starvik@axis.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:   Mon, 20 Feb 2012 10:34:20 +0100
Subject: SMP MIPS and Linux 3.2
Thread-Topic: SMP MIPS and Linux 3.2
Thread-Index: AcznH9lfpXUbAgVmQ5aJnfIX4n0HcAIkubIw
Message-ID: <4BEA3FF3CAA35E408EA55C7BE2E61D055C769FECBC@xmail3.se.axis.com>
Accept-Language: sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: sv-SE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 32488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikael.starvik@axis.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

I'm running Linux 3.2 on a MIPS 34K with two VPEs (in MT_SMP configuration). It works fine in UP but with SMP it deadlocks during bootup (both CPUs gets idle). Typically like this:

[    0.090000] CPU revision is: 01019550 (MIPS 34Kc)
[    0.090000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
[    0.090000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes
[    0.170000] Brought up 2 CPUs
<No more output>

I have tried to enable __ARCH_WANT_INTERRUPTS_ON_CTXSW but that didn't improve anything. Anyone else got this running or have any thoughts about what the problem may be?

Best Regards
/Mikael
