Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2017 19:00:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28839 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993376AbdHGQ77AHrGK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Aug 2017 18:59:59 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1A2FB74C0A7E1;
        Mon,  7 Aug 2017 17:59:48 +0100 (IST)
Received: from BADAG03.ba.imgtec.org (10.20.40.115) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Aug
 2017 17:59:52 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 badag03.ba.imgtec.org ([fe80::5efe:10.20.40.115%12]) with mapi id
 14.03.0266.001; Mon, 7 Aug 2017 09:59:48 -0700
From:   Petar Jovanovic <Petar.Jovanovic@imgtec.com>
To:     David Daney <ddaney@caviumnetworks.com>,
        Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@rt-rk.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "david.daney@cavium.com" <david.daney@cavium.com>
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and
 mips64r1
Thread-Topic: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2
 and mips64r1
Thread-Index: AQHSnbX++bP4lnkFiE+wD6odSKTYpKG3hZqAgB8QjxiAFMJoAIAKSgX9gAk83ICAAoqeAIAAGCEAgCcALACAHyi9Z4AAwRUAgAD4k4CAADm+gIAAFRUAgDBNzfw=
Date:   Mon, 7 Aug 2017 16:59:47 +0000
Message-ID: <56EA75BA695AE044ACFB41322F6D2BF4013D06C0AF@BADAG02.ba.imgtec.org>
References: <1489600751-82884-1-git-send-email-petar.jovanovic@rt-rk.com>
 <001b01d2ae25$d7554b80$85ffe280$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D036343@BADAG02.ba.imgtec.org>
 <002c01d2c80f$52e66060$f8b32120$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D048E49@BADAG02.ba.imgtec.org>
 <alpine.DEB.2.00.1705210223180.2590@tp.orcam.me.uk>
 <22c5e59d-fb87-9dbf-1285-2a5ff3b62497@caviumnetworks.com>
 <alpine.DEB.2.00.1705221846340.2590@tp.orcam.me.uk>
 <000a01d2e6a4$38a8fe70$a9fafb50$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D065C1B@BADAG02.ba.imgtec.org>
 <alpine.DEB.2.00.1707062139020.3339@tp.orcam.me.uk>
 <000b01d2f715$6bb602f0$432208d0$@rt-rk.com>
 <alpine.DEB.2.00.1707071538030.3339@tp.orcam.me.uk>,<4e2cf7f4-a44c-3beb-290f-ecd483368d67@caviumnetworks.com>
In-Reply-To: <4e2cf7f4-a44c-3beb-290f-ecd483368d67@caviumnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.216.37.146]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Petar.Jovanovic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Petar.Jovanovic@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


________________________________________
From: David Daney [ddaney@caviumnetworks.com]
Sent: Friday, July 07, 2017 6:19 PM
To: Maciej Rozycki; Petar Jovanovic; ralf@linux-mips.org
Cc: Petar Jovanovic; linux-mips@linux-mips.org; david.daney@cavium.com
Subject: Re: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and mips64r1

On 07/07/2017 08:04 AM, Maciej W. Rozycki wrote:
> On Fri, 7 Jul 2017, Petar Jovanovic wrote:
>
>> As I said earlier in the thread, "in the current ToT, I have not seen
>> where this change would affect apart from show_cpuinfo()"[1]. So, if
>> someone implements Octeon-specific controls, where this should be used?
>
>   Right, `egrep -r 'cpu_has_(mips_r1|mips32r1|mips64r1|mips32r2)' arch/mips'
> does not show anything else indeed.  Please make it unambiguous in the
> patch description then, i.e. that there is no functional change beyond
> reporting in `show_cpuinfo'.
>
>> I am not aware of the places where Octeon (ab)uses it in the current
>> kernel code. David says he "cannot recall exactly what the issues
>> were" [2].
>

> In my recent review of the code while working the the eBPF JIT, I tried
> to audit the use of cpu_has_* as it relates to OCTEON.  My current
> thoughts are that there is no reason not to merge Petar's patch.

> Ralf, please add ...

> Acked-by: David Daney <david.daney@cavium.com>

> Sorry for the pain here.


Ralf?

Regards,
Petar
