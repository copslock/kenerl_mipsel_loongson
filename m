Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2017 10:35:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43490 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992213AbdHGIew2YcOL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Aug 2017 10:34:52 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v778Yn6E020982;
        Mon, 7 Aug 2017 10:34:49 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v778Ymm3020981;
        Mon, 7 Aug 2017 10:34:48 +0200
Date:   Mon, 7 Aug 2017 10:34:48 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     linux-mips@linux-mips.org, Waldemar Brodkorb <wbx@openadk.org>
Subject: Re: undefined reference to `__multi3' when building with gcc 7.x
Message-ID: <20170807083448.GA20713@linux-mips.org>
References: <20170803225547.6caa602b@windsurf.lan>
 <20170804000556.GC30597@linux-mips.org>
 <20170804151920.GA11317@linux-mips.org>
 <20170804174151.2eea9af3@windsurf.lan>
 <20170804222500.GA11675@linux-mips.org>
 <20170805135649.152b0739@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170805135649.152b0739@windsurf>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sat, Aug 05, 2017 at 01:56:49PM +0200, Thomas Petazzoni wrote:

> On Sat, 5 Aug 2017 00:25:00 +0200, Ralf Baechle wrote:
> 
> > > Great! However, looking at the functions that end up calling __multi3,
> > > I'm wondering why suddenly gcc 7.x needs to call such a function, while
> > > the same code was compiling without __multi3 in libgcc with gcc 6.x.  
> > 
> > Chances are it's something specific to MIPS64 R6.  Before trying your
> > config file I also tried a number of other defconfigs and all built
> > well.
> > 
> > Here's a test case which generates a reference to __multi3:
> > 
> > unsigned long func(unsigned long a, unsigned long b)
> > {
> >         return a > (~0UL) / b;
> > }
> > 
> > GCC rearanges above statement to:
> > 
> > 	return (unsigned __int128)a * (unsigned __int128) b > 0xffffffff;
> 
> And this is normal/expected ?

Without consideration of performance, It's certainly is valid code.  And
with that I can't drop the issue as a GCC code generation bug.

However it seems GCC itself doesn't seem to have a __multi3 in its
libgcc2 - which indeed would be a GCC issue - at least none I was easily
able to find with grep so I'm adding Matthew Fortune to cc in the hope he
can shed some light on this.

  Ralf
