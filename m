Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2011 10:02:52 +0100 (CET)
Received: from anubis.se.axis.com ([195.60.68.12]:42696 "EHLO
        anubis.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491067Ab1BGJCt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Feb 2011 10:02:49 +0100
Received: from localhost (localhost [127.0.0.1])
        by anubis.se.axis.com (Postfix) with ESMTP id CAF2E19D07
        for <linux-mips@linux-mips.org>; Mon,  7 Feb 2011 10:02:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
        by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Yzgdgj3apTi5 for <linux-mips@linux-mips.org>;
        Mon,  7 Feb 2011 10:02:41 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by anubis.se.axis.com (Postfix) with ESMTP id 932C619D00
        for <linux-mips@linux-mips.org>; Mon,  7 Feb 2011 10:02:40 +0100 (CET)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
        by thoth.se.axis.com (Postfix) with ESMTP id 9924534145
        for <linux-mips@linux-mips.org>; Mon,  7 Feb 2011 10:02:40 +0100 (CET)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Mon, 7 Feb 2011 10:02:40 +0100
From:   Mikael Starvik <mikael.starvik@axis.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:   Mon, 7 Feb 2011 10:02:34 +0100
Subject: Highmem in architechtures with cache alias
Thread-Topic: Highmem in architechtures with cache alias
Thread-Index: AcvGpcKiS+6S2cZ3S+WKJ2QF7+g/MQ==
Message-ID: <4BEA3FF3CAA35E408EA55C7BE2E61D055C60823A4F@xmail3.se.axis.com>
Accept-Language: sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-puzzleid: {5A2D5031-25B1-4079-8637-0D4F4D2DB8D9}
x-cr-hashedpuzzle: B0Q= Anrj Arms Bb8N CzOs DCBG F8dQ GiMm G2Lf HXhh Hcbo
 HnSG H0ZZ IPfT I+Ku
 KnM+;1;bABpAG4AdQB4AC0AbQBpAHAAcwBAAGwAaQBuAHUAeAAtAG0AaQBwAHMALgBvAHIAZwA=;Sosha1_v1;7;{5A2D5031-25B1-4079-8637-0D4F4D2DB8D9};bQBpAGsAYQBlAGwALgBzAHQAYQByAHYAaQBrAEAAYQB4AGkAcwAuAGMAbwBtAA==;Mon,
 07 Feb 2011 09:02:34
 GMT;SABpAGcAaABtAGUAbQAgAGkAbgAgAGEAcgBjAGgAaQB0AGUAYwBoAHQAdQByAGUAcwAgAHcAaQB0AGgAIABjAGEAYwBoAGUAIABhAGwAaQBhAHMA
acceptlanguage: sv-SE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <mikael.starvik@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikael.starvik@axis.com
Precedence: bulk
X-list: linux-mips

Hi!

It is clearly stated in http://www.linux-mips.org/wiki/Highmem that the MIPS kernel
can´t user highmem on machines with cache aliasing and I understand the reason. So,
what is the solution here? Switch to 16k pages? Or are there other ways to get more
memory on a machine with cache aliases?

/Mikael
