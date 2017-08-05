Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Aug 2017 13:57:59 +0200 (CEST)
Received: from mail.free-electrons.com ([62.4.15.54]:48976 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993944AbdHEL5w2Q-cq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Aug 2017 13:57:52 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 553E121DCD; Sat,  5 Aug 2017 13:57:44 +0200 (CEST)
Received: from windsurf (unknown [37.171.170.247])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 9DFCC21DC7;
        Sat,  5 Aug 2017 13:57:37 +0200 (CEST)
Date:   Sat, 5 Aug 2017 13:56:49 +0200
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Waldemar Brodkorb <wbx@openadk.org>
Subject: Re: undefined reference to `__multi3' when building with gcc 7.x
Message-ID: <20170805135649.152b0739@windsurf>
In-Reply-To: <20170804222500.GA11675@linux-mips.org>
References: <20170803225547.6caa602b@windsurf.lan>
        <20170804000556.GC30597@linux-mips.org>
        <20170804151920.GA11317@linux-mips.org>
        <20170804174151.2eea9af3@windsurf.lan>
        <20170804222500.GA11675@linux-mips.org>
Organization: Free Electrons
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

Hello,

On Sat, 5 Aug 2017 00:25:00 +0200, Ralf Baechle wrote:

> > Great! However, looking at the functions that end up calling __multi3,
> > I'm wondering why suddenly gcc 7.x needs to call such a function, while
> > the same code was compiling without __multi3 in libgcc with gcc 6.x.  
> 
> Chances are it's something specific to MIPS64 R6.  Before trying your
> config file I also tried a number of other defconfigs and all built
> well.
> 
> Here's a test case which generates a reference to __multi3:
> 
> unsigned long func(unsigned long a, unsigned long b)
> {
>         return a > (~0UL) / b;
> }
> 
> GCC rearanges above statement to:
> 
> 	return (unsigned __int128)a * (unsigned __int128) b > 0xffffffff;

And this is normal/expected ?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
