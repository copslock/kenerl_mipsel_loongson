Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2011 11:15:17 +0200 (CEST)
Received: from service87.mimecast.com ([94.185.240.25]:60781 "HELO
        service87.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491063Ab1C3JPO convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Mar 2011 11:15:14 +0200
Received: from cam-owa2.Emea.Arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.21]) by service87.mimecast.com; Wed, 30 Mar 2011 10:15:08 +0100
Received: from [10.1.77.95] ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 30 Mar 2011 10:15:06 +0100
Subject: Re: kmemleak for MIPS
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Maxin John <maxin.john@gmail.com>
Cc:     Daniel Baluta <dbaluta@ixiacom.com>,
        naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <AANLkTi=gMP6jQuQFovfsOX=7p-SSnwXoVLO_DVEpV63h@mail.gmail.com>
References: <9bde694e1003020554p7c8ff3c2o4ae7cb5d501d1ab9@mail.gmail.com>
         <AANLkTinnqtXf5DE+qxkTyZ9p9Mb8dXai6UxWP2HaHY3D@mail.gmail.com>
         <1300960540.32158.13.camel@e102109-lin.cambridge.arm.com>
         <AANLkTim139fpJsMJFLiyUYvFgGMz-Ljgd_yDrks-tqhE@mail.gmail.com>
         <1301395206.583.53.camel@e102109-lin.cambridge.arm.com>
         <AANLkTim-4v5Cbp6+wHoXjgKXoS0axk1cgQ5AHF_zot80@mail.gmail.com>
         <1301399454.583.66.camel@e102109-lin.cambridge.arm.com>
         <AANLkTin0_gT0E3=oGyfMwk+1quqonYBExeN9a3=v=Lob@mail.gmail.com>
         <AANLkTi=gMP6jQuQFovfsOX=7p-SSnwXoVLO_DVEpV63h@mail.gmail.com>
Organization: ARM Limited
Date:   Wed, 30 Mar 2011 10:15:05 +0100
Message-ID: <1301476505.29074.47.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1
X-OriginalArrivalTime: 30 Mar 2011 09:15:06.0492 (UTC) FILETIME=[F5C61BC0:01CBEEBA]
X-MC-Unique: 111033010150808201
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <catalin.marinas@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: catalin.marinas@arm.com
Precedence: bulk
X-list: linux-mips

On Tue, 2011-03-29 at 20:36 +0100, Maxin John wrote:
> I have prepared the combined patch for kmemleak porting to MIPS. After
> applying the patch and enabling the kmemleak in Kernel, I can see one
> kernel memleak reported during booting itself:
...
> unreferenced object 0x8f90d000 (size 4096):
>   comm "swapper", pid 1, jiffies 4294937330 (age 815.000s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<80529644>] alloc_large_system_hash+0x2f8/0x410
>     [<805383b4>] udp_table_init+0x4c/0x158
>     [<805384dc>] udp_init+0x1c/0x94
>     [<8053889c>] inet_init+0x184/0x2a0
>     [<80100584>] do_one_initcall+0x174/0x1e0
>     [<8051f348>] kernel_init+0xe4/0x174
>     [<80103d4c>] kernel_thread_helper+0x10/0x18

If you for the kmemleak scan (via echo) a few times, do you get more
leaks? The udp_table_init() function looks like it could leak some
memory but I haven't seen it before. I'm not sure whether this is a
false positive or a real leak.
> 
> Please let me know your comments.
> 
> Signed-off-by: Maxin B. John <maxin.john@gmail.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

I think the last line should be more like:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
