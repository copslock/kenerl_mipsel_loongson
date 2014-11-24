Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 21:48:18 +0100 (CET)
Received: from e32.co.us.ibm.com ([32.97.110.150]:39840 "EHLO
        e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011494AbaKXUsRUirOg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 21:48:17 +0100
Received: from /spool/local
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 24 Nov 2014 13:48:10 -0700
Received: from d03dlp02.boulder.ibm.com (9.17.202.178)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 24 Nov 2014 13:48:08 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 850E63E40041
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 13:48:07 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAOKmrHb36700210
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 13:48:53 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
        by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id sAOKr1Jp013862
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 13:53:02 -0700
Received: from paulmck-ThinkPad-W500 ([9.50.23.142])
        by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id sAOKr1xP013850;
        Mon, 24 Nov 2014 13:53:01 -0700
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
        id 68D31381855; Mon, 24 Nov 2014 12:48:05 -0800 (PST)
Date:   Mon, 24 Nov 2014 12:48:05 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20141124204805.GV5050@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <CAADnVQJ6eXGiasoQwyAzuejLncEHdy6MOf+m3AHnpjgn0h3+OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ6eXGiasoQwyAzuejLncEHdy6MOf+m3AHnpjgn0h3+OQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14112420-0005-0000-0000-0000069858E3
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44405
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

On Mon, Nov 24, 2014 at 12:29:07PM -0800, Alexei Starovoitov wrote:
> On Mon, Nov 24, 2014 at 11:07 AM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
> >
> > Anyone with a new propopal? ;-)                                        ^
> 
> one more proposal :)
> #define __ACCESS_ONCE(x) ({ typeof(x) __var = 0; (volatile typeof(x) *)&(x); })
> #define ACCESS_ONCE(x) (*__ACCESS_ONCE(x))
> 
> works as lvalue...
> the basic idea is the same:
> constant zero can be used to initialize any scalar
> (including pointers), but unions and structs will fail to compile as:
> "error: invalid initializer"
> 
> If I'm reading pr58145 gcc bug report correctly, it
> miscompiles only structs, so we can let ACCESS_ONCE
> to work on unions. Then the following will rejects structs only:
> #define __ACCESS_ONCE(x) ({ (typeof(x))0; (volatile typeof(x) *)&(x); })
> #define ACCESS_ONCE(x) (*__ACCESS_ONCE(x))

You beat me to it.  ;-)

However, your approach would allow an ACCESS_ONCE() of a long long
to compile on 32-bit systems where it has to be broken up into a
pair of 32-bit accesses.

							Thanx, Paul
