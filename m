Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 16:01:41 +0100 (CET)
Received: from krynn.se.axis.com ([193.13.178.10]:45131 "EHLO
        krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492521Ab0CKPBg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 16:01:36 +0100
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
        by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o2BExqdb019855
        for <linux-mips@linux-mips.org>; Thu, 11 Mar 2010 16:00:18 +0100
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Thu, 11 Mar 2010 15:59:48 +0100
From:   Mikael Starvik <mikael.starvik@axis.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:   Thu, 11 Mar 2010 15:59:44 +0100
Subject: MIPS raw_local_irq_restore flags
Thread-Topic: MIPS raw_local_irq_restore flags
Thread-Index: AcrBK3wkk2FBNl+9TaOxNHDqJxz80A==
Message-ID: <4BEA3FF3CAA35E408EA55C7BE2E61D0546AC862322@xmail3.se.axis.com>
Accept-Language: sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-puzzleid: {BD95551F-236F-4DB5-9BD6-5AABD159E72A}
x-cr-hashedpuzzle: gyU= Bby3 Bt5Z CS4u ChsQ Co9K D2/n D8Lp EFIC EHOd Eii6
 FoZ0 HbUU Hpa+ JG0X
 JPZy;1;bABpAG4AdQB4AC0AbQBpAHAAcwBAAGwAaQBuAHUAeAAtAG0AaQBwAHMALgBvAHIAZwA=;Sosha1_v1;7;{BD95551F-236F-4DB5-9BD6-5AABD159E72A};bQBpAGsAYQBlAGwALgBzAHQAYQByAHYAaQBrAEAAYQB4AGkAcwAuAGMAbwBtAA==;Thu,
 11 Mar 2010 14:59:44
 GMT;TQBJAFAAUwAgAHIAYQB3AF8AbABvAGMAYQBsAF8AaQByAHEAXwByAGUAcwB0AG8AcgBlACAAZgBsAGEAZwBzAA==
acceptlanguage: sv-SE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <mikael.starvik@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikael.starvik@axis.com
Precedence: bulk
X-list: linux-mips

For the common case CONFIG_CPU_MIPSR2 && CONFIG_IRQ_CPU raw_local_irq_restore_flags is defined as:

"       beqz    \\flags, 1f                                     \n"
"       di                                                      \n"
"       ei                                                      \n"
"1:                                                             \n"

Doesn't this imply that you can't do recursive local_irq_save() (with different locks ofcourse)? 

Best Regards
/Mikael
