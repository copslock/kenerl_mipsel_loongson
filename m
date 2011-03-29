Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2011 13:51:04 +0200 (CEST)
Received: from service87.mimecast.com ([94.185.240.25]:57623 "HELO
        service87.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491856Ab1C2LvB convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Mar 2011 13:51:01 +0200
Received: from cam-owa2.Emea.Arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.21]) by service87.mimecast.com; Tue, 29 Mar 2011 12:50:57 +0100
Received: from [10.1.77.95] ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 29 Mar 2011 12:50:55 +0100
Subject: Re: kmemleak for MIPS
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Maxin John <maxin.john@gmail.com>
Cc:     Daniel Baluta <dbaluta@ixiacom.com>,
        naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <AANLkTim-4v5Cbp6+wHoXjgKXoS0axk1cgQ5AHF_zot80@mail.gmail.com>
References: <9bde694e1003020554p7c8ff3c2o4ae7cb5d501d1ab9@mail.gmail.com>
         <AANLkTinnqtXf5DE+qxkTyZ9p9Mb8dXai6UxWP2HaHY3D@mail.gmail.com>
         <1300960540.32158.13.camel@e102109-lin.cambridge.arm.com>
         <AANLkTim139fpJsMJFLiyUYvFgGMz-Ljgd_yDrks-tqhE@mail.gmail.com>
         <1301395206.583.53.camel@e102109-lin.cambridge.arm.com>
         <AANLkTim-4v5Cbp6+wHoXjgKXoS0axk1cgQ5AHF_zot80@mail.gmail.com>
Organization: ARM Limited
Date:   Tue, 29 Mar 2011 12:50:54 +0100
Message-ID: <1301399454.583.66.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1
X-OriginalArrivalTime: 29 Mar 2011 11:50:55.0202 (UTC) FILETIME=[8FA04C20:01CBEE07]
X-MC-Unique: 111032912505702901
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <catalin.marinas@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: catalin.marinas@arm.com
Precedence: bulk
X-list: linux-mips

On Tue, 2011-03-29 at 12:38 +0100, Maxin John wrote:
> Hi,
> 
> > You may want to disable the kmemleak testing to reduce the amount of
> > leaks reported.
> 
> The kmemleak results in MIPS that I have included in the previous mail
> were obtained during the booting of the malta kernel.
> Later, I have checked the "real" usage by using the default
> "kmemleak_test" module.
> 
> Following output shows the kmemleak results when I used the "kmemleak_test.ko"

Yes, that's fine to test kmemleak and show that it reports issues on
MIPS. But it shouldn't report other leaks if the test module isn't
loaded at all (removing it wouldn't remove the leaks reported as they
are permanent).

> debian-mips:~# cat /sys/kernel/debug/kmemleak
> ........

These were caused by the kmemleak test.
> 
> > These are probably false positives.
> The previous results could be false positives. However, the current
> results are not false positives as we have intentionally created the
> memory leaks using the test module.

I was only referring to those leaks coming from udp.c and ignored the
kmemleak tests (that's why I said that you should run it again without
the kmemleak_test.ko).

> > Since the pointer referring this
> > block (udp_table) is __read_mostly, is it possible that the
> > corresponding section gets placed outside the _sdata.._edata range?
> 
> I am not sure about this. Please  let know how can I check this.

Boot the kernel with kmemleak enabled but don't load kmemleak_test.ko.
Than you can either wait 10-15 minutes or force a scan with:

echo scan > /sys/kernel/debug/kmemleak
echo scan > /sys/kernel/debug/kmemleak
cat /sys/kernel/debug/kmemleak.

-- 
Catalin
