Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 20:38:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39323 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006917AbaHZSiIpKvk5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 20:38:08 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8EA74DE0FCB3A;
        Tue, 26 Aug 2014 19:37:58 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 26 Aug
 2014 19:38:01 +0100
Received: from BADAG01.ba.imgtec.org (192.168.146.113) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 26 Aug 2014 19:38:01 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 BADAG01.ba.imgtec.org ([fe80::8c38:df2b:fd93:33d3%14]) with mapi id
 14.03.0123.003; Tue, 26 Aug 2014 11:37:53 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Max Filippov <jcmvbkbc@gmail.com>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Chris Zankel <chris@zankel.net>,
        "Marc Gauthier" <marc@cadence.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: Re: [PATCH v4 0/2] mm/highmem: make kmap cache coloring aware
Thread-Topic: [PATCH v4 0/2] mm/highmem: make kmap cache coloring aware
Thread-Index: AQHPre7N5QBJ5Fz/0EKvD+9jsRp2sZviKfYAgAEz3a8=
Date:   Tue, 26 Aug 2014 18:37:52 +0000
Message-ID: <nlshxsgfkahrb2t7cl2hk6q5.1409078269675@email.android.com>
References: <1406941899-19932-1-git-send-email-jcmvbkbc@gmail.com>,<20140825171600.GH25892@linux-mips.org>
In-Reply-To: <20140825171600.GH25892@linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42264
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

16KB page size solution may sometime be a solution:

1) in microcontroller environment then small pages have advantage
in small applications world.

2) some kernel drivers may not fit well a different page size, especially if HW
has an embedded memory translation: GPU, video/audio decoders,
supplement accelerators.

3) finally, somebody can increase cache size faster than page size,
this race never finishes.



Ralf Baechle <ralf@linux-mips.org> wrote:


On Sat, Aug 02, 2014 at 05:11:37AM +0400, Max Filippov wrote:

> this series adds mapping color control to the generic kmap code, allowing
> architectures with aliasing VIPT cache to use high memory. There's also
> use example of this new interface by xtensa.

I haven't actually ported this to MIPS but it certainly appears to be
the right framework to get highmem aliases handled on MIPS, too.

Though I still consider increasing PAGE_SIZE to 16k the preferable
solution because it will entirly do away with cache aliases.

Thanks,

  Ralf
