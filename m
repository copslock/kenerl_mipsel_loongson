Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 13:43:54 +0100 (CET)
Received: from forward.webhostbox.net ([162.251.85.138]:50754 "EHLO
        forward.webhostbox.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014102AbcCQMnwv8H7I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 13:43:52 +0100
Received: from bh-25.webhostbox.net (unknown [172.16.210.69])
        by forward.webhostbox.net (Postfix) with ESMTP id 86D662608311;
        Thu, 17 Mar 2016 12:43:51 +0000 (GMT)
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:42448 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1agXHL-002Hjw-AJ; Thu, 17 Mar 2016 12:43:51 +0000
Subject: Re: linux-next: Tree for Mar 14 (mips qemu failure bisected)
To:     Qais Yousef <qsyousef@gmail.com>
References: <20160314174037.0097df55@canb.auug.org.au>
 <20160314143729.GA31845@roeck-us.net> <20160315052659.GA9320@roeck-us.net>
 <56E884BA.5050103@gmail.com> <20160316001713.GA4412@roeck-us.net>
 <20160316132210.GA21918@roeck-us.net> <56E9C1CA.7050208@gmail.com>
 <56E9DB85.9090405@gmail.com> <56EA1839.8010807@roeck-us.net>
 <CA+mqd+5AUfGSh1WvLa5bOt-HQM=eA+BmLeb7_xZo+-tswLcqiQ@mail.gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-next@vger.kernel.org,
        linux-mips@linux-mips.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <56EAA686.5010300@roeck-us.net>
Date:   Thu, 17 Mar 2016 05:43:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <CA+mqd+5AUfGSh1WvLa5bOt-HQM=eA+BmLeb7_xZo+-tswLcqiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.1 cv=MpLykzue c=1 sm=1 tr=0
        a=9TTQYYGGY7a1eFc7Vblcuw==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
        a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
        a=7OsogOcEt9IA:10 a=iPttUr02qUeVUSLfdeEA:9 a=QEXdDO2ut3YA:10
Return-Path: <SRS0+9h8u=PN=roeck-us.net=linux@forward.webhostbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 03/16/2016 10:25 PM, Qais Yousef wrote:
[ ... ]
>
> Yeah it is assumed that a Malta should always have a GIC and no one got around to fix this in qemu yet.
>
> I can only improve on the patch to do
>
>    if (!ipidomain && nr_cpu_ids == 1)
>            return 0;
>
> Which is more generic way to do it. I think a WARN_ON () would still be useful as SMP without ipis will not work really.
>
> I can send a proper patch if Ralf is OK with that.
>
> I got the console output from qemu by the way. I didn't use your script though.
>

What command line did you use ?

Thanks,
Guenter
