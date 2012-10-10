Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 10:08:07 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47506 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6870520Ab2JJIH6mF0w5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Oct 2012 10:07:58 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q9A87uBI007344;
        Wed, 10 Oct 2012 10:07:56 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q9A87u8n007343;
        Wed, 10 Oct 2012 10:07:56 +0200
Date:   Wed, 10 Oct 2012 10:07:56 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ronny Meeus <ronny.meeus@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: 2GB userspace limitation in ABI N32
Message-ID: <20121010080756.GC6740@linux-mips.org>
References: <CAMJ=MEfFsJH6Cqkow7-w3a352iYiWWi+ubOSJaqhh2bp2MqPZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMJ=MEfFsJH6Cqkow7-w3a352iYiWWi+ubOSJaqhh2bp2MqPZg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34666
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Oct 10, 2012 at 08:32:47AM +0200, Ronny Meeus wrote:

> I have a legacy application that we want to port to a MIPS (Cavium)
> architecture from a PPC based one.
> The board has 4GB memory of which we actually need almost 3GB in
> application space. On the PPC this is no issue since the split
> user/kernel is 3GB/1GB.
> We have to use the N32 ABI Initial tests on MIPS showed me the
> user-space limit of 2GB.
> We do not want to port the application to a 64bit
> 
> Now the question is: are there any workarounds, tricks existing to get
> around this limitation?
> I found some mailthreads on this subject (n32-big ABI -
> http://gcc.gnu.org/ml/gcc/2011-02/msg00278.html,
> http://elinux.org/images/1/1f/New-tricks-mips-linux.pdf) but is looks
> like this is not accepted by the community. Is there any process
> planned or made in this area?

I think limited time and gain killed the propoosed ABI rather than
theoretical issues raised.  Other architectures such as i386 - well,
IIRC any 32-bit ABI with more than 2GB userspace and a signed
ptrdiff_t - are suffering from them as well.

Also there's limited gain and even more limited time to implement things ...

  Ralf
