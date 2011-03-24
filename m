Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 10:55:55 +0100 (CET)
Received: from service87.mimecast.com ([94.185.240.25]:54112 "HELO
        service87.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491045Ab1CXJzx convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Mar 2011 10:55:53 +0100
Received: from cam-owa2.Emea.Arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.21]) by service87.mimecast.com; Thu, 24 Mar 2011 09:55:48 +0000
Received: from [10.1.77.95] ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 24 Mar 2011 09:55:43 +0000
Subject: Re: kmemleak for MIPS
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Daniel Baluta <dbaluta@ixiacom.com>
Cc:     naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <AANLkTinnqtXf5DE+qxkTyZ9p9Mb8dXai6UxWP2HaHY3D@mail.gmail.com>
References: <9bde694e1003020554p7c8ff3c2o4ae7cb5d501d1ab9@mail.gmail.com>
         <AANLkTinnqtXf5DE+qxkTyZ9p9Mb8dXai6UxWP2HaHY3D@mail.gmail.com>
Organization: ARM Limited
Date:   Thu, 24 Mar 2011 09:55:40 +0000
Message-ID: <1300960540.32158.13.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1
X-OriginalArrivalTime: 24 Mar 2011 09:55:43.0877 (UTC) FILETIME=[A4170B50:01CBEA09]
X-MC-Unique: 111032409554800601
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <catalin.marinas@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: catalin.marinas@arm.com
Precedence: bulk
X-list: linux-mips

On Thu, 2011-03-24 at 09:27 +0000, Daniel Baluta wrote:
> > I want to check kmemleak for both ARM/MIPS. i am able to find kernel
> > patch for ARM at
> > http://linux.derkeiler.com/Mailing-Lists/Kernel/2009-04/msg11830.html.
> > But I could not able to trace patch for MIPS.
> 
> It seems that kmemleak is not supported on MIPS.
> 
> According to 'depends on' config entry it is supported on:
> x86, arm, ppc, s390, sparc64, superh, microblaze and tile.
> 
> Cătălin, can you confirm this? I will send a patch to update
> Documentation/kmemleak.txt.
> 
> Also, looking forward to work on making kmemleak available on MIPS.

It's not supported probably because no-one tried it, kmemleak is pretty
architecture-independent. You may need to add some standard symbols to
the vmlinux.lds.S if the linker complains and possibly annotate some
false positives if you get any.

Just add "depends on MIPS" and give it a try.

-- 
Catalin
