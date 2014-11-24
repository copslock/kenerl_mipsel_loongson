Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 20:42:17 +0100 (CET)
Received: from e34.co.us.ibm.com ([32.97.110.152]:50317 "EHLO
        e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006921AbaKXTmMwLqIU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 20:42:12 +0100
Received: from /spool/local
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 24 Nov 2014 12:42:06 -0700
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 24 Nov 2014 12:42:03 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 24B461FF0045
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 12:30:47 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAOJg2qY35717134
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 12:42:02 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
        by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id sAOJkuTx012850
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 12:46:57 -0700
Received: from paulmck-ThinkPad-W500 ([9.50.23.142])
        by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id sAOJkuct012845;
        Mon, 24 Nov 2014 12:46:56 -0700
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
        id 7C22D381844; Mon, 24 Nov 2014 11:42:00 -0800 (PST)
Date:   Mon, 24 Nov 2014 11:42:00 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-x86_64@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar
 types
Message-ID: <20141124194200.GR5050@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
 <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com>
 <15567.1416835858@warthog.procyon.org.uk>
 <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com>
 <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com>
 <547381D7.2070404@de.ibm.com>
 <CA+55aFy+dunTcdgB4-BXsYiLDk9pf8b_L74ky-dMixpbX3JQQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFy+dunTcdgB4-BXsYiLDk9pf8b_L74ky-dMixpbX3JQQA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14112419-0017-0000-0000-0000068AFF52
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
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

On Mon, Nov 24, 2014 at 11:14:42AM -0800, Linus Torvalds wrote:
> On Mon, Nov 24, 2014 at 11:07 AM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
> >
> > Looks really nice, but does not work with ACCESS_ONCE is on the left-hand side:
> 
> Oh, I forgot about that. And that was indeed why I had done that whole
> helper macro originally, with ACCESS_ONCE() itself just being the
> dereference of the pointer.

OK, how about the following?

It complains if the variable is too large, for example, long long on
32-bit systems or large structures.  It is OK loading from and storing
to small structures as well, which I am having a hard time thinking of
as a disadvantage.

							Thanx, Paul

------------------------------------------------------------------------

#define get_scalar_volatile_pointer(x) ({ \
	volatile typeof(x) *__vp = &(x); \
	BUILD_BUG_ON(sizeof(*__vp) != sizeof(char) && \
		     sizeof(*__vp) != sizeof(short) && \
		     sizeof(*__vp) != sizeof(int) && \
		     sizeof(*__vp) != sizeof(long)); \
	__vp; })
#define ACCESS_ONCE(x) (*get_scalar_volatile_pointer(x))
