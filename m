Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2013 17:13:03 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:61278 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817315Ab3ILPM6Cu5qN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Sep 2013 17:12:58 +0200
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Paul Burton <Paul.Burton@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix errata for some 1074K cores.
Thread-Topic: [PATCH] MIPS: Fix errata for some 1074K cores.
Thread-Index: AQHOrynF0sZcYE/SBUSzvM9JZ+mYmJnCTuwA///jmEGAAHengP//jII/
Date:   Thu, 12 Sep 2013 15:12:31 +0000
Message-ID: <0y9ngx00ss83f3rabscx8trh.1378998749581@email.android.com>
References: <1378929708-7253-1-git-send-email-Steven.Hill@imgtec.com>
 <52318BC6.7030903@imgtec.com>
 <j0d17e3bxlvp3famj4e32xv9.1378997855738@email.android.com>,<CAGVrzcY_OWUSK4dfZ8fnV49ELSYE6exSYQi5AwxuGoKnvx5Rtg@mail.gmail.com>
In-Reply-To: <CAGVrzcY_OWUSK4dfZ8fnV49ELSYE6exSYQi5AwxuGoKnvx5Rtg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01192__2013_09_12_16_12_51
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

Well, if you read an errata text, you probably have a big chance to stare at it trying to understand it. At least I don't and I just put that was said to me by HW team. There is no sense in discussion here because it is a part of specific core tuneup.


Florian Fainelli <f.fainelli@gmail.com> wrote:


2013/9/12 Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>:
> Treat it as is.
>
> It is a dirty laundry of HW engineers and you may need to communicate with them or read Errata docs on CPU.
>
> If it is about a way how it is written - ask Steven, initially it was in mainland probe code but he think it should be a separate function. I just corrected him, pointing that erratas on 74K and 1074K are different. But because he insist on having the same CPU_74K for both, so...

If you take a look at another CPU company such as ARM, they provide
lengthy explanations for their various Erratas:

config PJ4B_ERRATA_4742
        bool "PJ4B Errata 4742: IDLE Wake Up Commands can Cause the
CPU Core to Cease Operation"
        depends on CPU_PJ4B && MACH_ARMADA_370
        default y
        help
          When coming out of either a Wait for Interrupt (WFI) or a Wait for
          Event (WFE) IDLE states, a specific timing sensitivity exists between
          the retiring WFI/WFE instructions and the newly issued subsequent
          instructions.  This sensitivity can result in a CPU hang scenario.
          Workaround:
          The software must insert either a Data Synchronization Barrier (DSB)
          or Data Memory Barrier (DMB) command immediately after the WFI/WFE
          instruction

I really think that you should aim for the same level of information
so that people know whether this is relevant for their platform,
whether they have the ECO applied etc...
--
Florian
