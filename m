Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jul 2013 10:53:08 +0200 (CEST)
Received: from ozlabs.org ([203.10.76.45]:44589 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822972Ab3GAIxE70RXh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Jul 2013 10:53:04 +0200
Received: by ozlabs.org (Postfix, from userid 1011)
        id 2D1D42C0209; Mon,  1 Jul 2013 18:53:00 +1000 (EST)
From:   Rusty Russell <rusty@rustcorp.com.au>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] mm: module_alloc: check if size is 0
In-Reply-To: <1372373188.2060.32.camel@joe-AO722>
References: <1330631119-10059-1-git-send-email-veli-pekka.peltola@bluegiga.com> <1331125768-25454-1-git-send-email-veli-pekka.peltola@bluegiga.com> <20130627093917.GQ7171@linux-mips.org> <20130627152335.c3a4c9f4c647cf4a2b263479@linux-foundation.org> <1372373188.2060.32.camel@joe-AO722>
User-Agent: Notmuch/0.15.2+81~gd2c8818 (http://notmuchmail.org) Emacs/23.4.1 (i686-pc-linux-gnu)
Date:   Mon, 01 Jul 2013 12:48:28 +0930
Message-ID: <87sizzrmrf.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rusty@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rusty@rustcorp.com.au
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

Joe Perches <joe@perches.com> writes:
> On Thu, 2013-06-27 at 15:23 -0700, Andrew Morton wrote:
>> On Thu, 27 Jun 2013 11:39:17 +0200 Ralf Baechle <ralf@linux-mips.org> wrote:
> []
>> Veli-Pekka's original patch would be neater if we were to add a new
>> 
>> void *__vmalloc_node_range_zero_size_ok(<args>)
>> {
>> 	if (size == 0)
>> 		return NULL;
>
> I believe you mean
> 		return ZERO_SIZE_PTR;

Yes, this is the Right Fix.

Thanks,
Rusty.
