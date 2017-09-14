Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2017 18:41:47 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:52608 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992982AbdINQlkTrfvJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Sep 2017 18:41:40 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id E32821A2418;
        Thu, 14 Sep 2017 18:41:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkn153 (rtrkn153.domain.local [192.168.236.80])
        by mail.rt-rk.com (Postfix) with ESMTPSA id C7D181A225E;
        Thu, 14 Sep 2017 18:41:33 +0200 (CEST)
From:   "Petar Jovanovic" <petar.jovanovic@rt-rk.com>
To:     "'Petar Jovanovic'" <Petar.Jovanovic@imgtec.com>,
        "'David Daney'" <ddaney@caviumnetworks.com>,
        "'Maciej Rozycki'" <Maciej.Rozycki@imgtec.com>,
        <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <david.daney@cavium.com>
References: <1489600751-82884-1-git-send-email-petar.jovanovic@rt-rk.com> <001b01d2ae25$d7554b80$85ffe280$@rt-rk.com> <56EA75BA695AE044ACFB41322F6D2BF4013D036343@BADAG02.ba.imgtec.org> <002c01d2c80f$52e66060$f8b32120$@rt-rk.com> <56EA75BA695AE044ACFB41322F6D2BF4013D048E49@BADAG02.ba.imgtec.org> <alpine.DEB.2.00.1705210223180.2590@tp.orcam.me.uk> <22c5e59d-fb87-9dbf-1285-2a5ff3b62497@caviumnetworks.com> <alpine.DEB.2.00.1705221846340.2590@tp.orcam.me.uk> <000a01d2e6a4$38a8fe70$a9fafb50$@rt-rk.com> <56EA75BA695AE044ACFB41322F6D2BF4013D065C1B@BADAG02.ba.imgtec.org> <alpine.DEB.2.00.1707062139020.3339@tp.orcam.me.uk> <000b01d2f715$6bb602f0$432208d0$@rt-rk.com> <alpine.DEB.2.00.1707071538030.3339@tp.orcam.me.uk>,<4e2cf7f4-a44c-3beb-290f-ecd483368d67@caviumnetworks.com> <56EA75BA695AE044ACFB41322F6D2BF4013D06C0AF@BADAG02.ba.imgtec.org>
In-Reply-To: <56EA75BA695AE044ACFB41322F6D2BF4013D06C0AF@BADAG02.ba.imgtec.org>
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and mips64r1
Date:   Thu, 14 Sep 2017 18:41:34 +0200
Message-ID: <000001d32d78$539cb260$fad61720$@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFk0u1L5Xxe++MwOaWf1NpDgdbVAQD+Q8JBAi8P7/cBht+ufgJrlzj2AtLLO/IBy5iamAEgIZO+AjLK5lYBw/HWDgHB3AdxAytORVIBtARQbgEoyzzbAdInu5yivcFFwA==
Content-Language: en-us
Return-Path: <petar.jovanovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: petar.jovanovic@rt-rk.com
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

ping

-----Original Message-----
From: Petar Jovanovic [mailto:Petar.Jovanovic@imgtec.com] 
Sent: Monday, August 7, 2017 7:00 PM
To: David Daney <ddaney@caviumnetworks.com>; Maciej Rozycki
<Maciej.Rozycki@imgtec.com>; Petar Jovanovic <petar.jovanovic@rt-rk.com>;
ralf@linux-mips.org
Cc: linux-mips@linux-mips.org; david.daney@cavium.com
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and
mips64r1


________________________________________
From: David Daney [ddaney@caviumnetworks.com]
Sent: Friday, July 07, 2017 6:19 PM
To: Maciej Rozycki; Petar Jovanovic; ralf@linux-mips.org
Cc: Petar Jovanovic; linux-mips@linux-mips.org; david.daney@cavium.com
Subject: Re: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and
mips64r1

On 07/07/2017 08:04 AM, Maciej W. Rozycki wrote:
> On Fri, 7 Jul 2017, Petar Jovanovic wrote:
>
>> As I said earlier in the thread, "in the current ToT, I have not seen 
>> where this change would affect apart from show_cpuinfo()"[1]. So, if 
>> someone implements Octeon-specific controls, where this should be used?
>
>   Right, `egrep -r 'cpu_has_(mips_r1|mips32r1|mips64r1|mips32r2)'
arch/mips'
> does not show anything else indeed.  Please make it unambiguous in the 
> patch description then, i.e. that there is no functional change beyond 
> reporting in `show_cpuinfo'.
>
>> I am not aware of the places where Octeon (ab)uses it in the current 
>> kernel code. David says he "cannot recall exactly what the issues 
>> were" [2].
>

> In my recent review of the code while working the the eBPF JIT, I 
> tried to audit the use of cpu_has_* as it relates to OCTEON.  My 
> current thoughts are that there is no reason not to merge Petar's patch.

> Ralf, please add ...

> Acked-by: David Daney <david.daney@cavium.com>

> Sorry for the pain here.


Ralf?

Regards,
Petar
=
