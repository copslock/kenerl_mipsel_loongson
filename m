Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 15:05:40 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:46318 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870501Ab2JJNFdEGhv0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2012 15:05:33 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1TLvqO-0003Ay-00
        for linux-mips@linux-mips.org; Wed, 10 Oct 2012 12:57:00 +0000
Date:   Wed, 10 Oct 2012 08:57:00 -0400
To:     linux-mips@linux-mips.org
Subject: Re: 2GB userspace limitation in ABI N32
Message-ID: <20121010125700.GR254@brightrain.aerifal.cx>
References: <CAMJ=MEfFsJH6Cqkow7-w3a352iYiWWi+ubOSJaqhh2bp2MqPZg@mail.gmail.com>
 <20121010080756.GC6740@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121010080756.GC6740@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   Rich Felker <dalias@aerifal.cx>
X-archive-position: 34672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dalias@aerifal.cx
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

On Wed, Oct 10, 2012 at 10:07:56AM +0200, Ralf Baechle wrote:
> On Wed, Oct 10, 2012 at 08:32:47AM +0200, Ronny Meeus wrote:
> 
> > I have a legacy application that we want to port to a MIPS (Cavium)
> > architecture from a PPC based one.
> > The board has 4GB memory of which we actually need almost 3GB in
> > application space. On the PPC this is no issue since the split
> > user/kernel is 3GB/1GB.
> > We have to use the N32 ABI Initial tests on MIPS showed me the
> > user-space limit of 2GB.
> > We do not want to port the application to a 64bit
> > 
> > Now the question is: are there any workarounds, tricks existing to get
> > around this limitation?
> > I found some mailthreads on this subject (n32-big ABI -
> > http://gcc.gnu.org/ml/gcc/2011-02/msg00278.html,
> > http://elinux.org/images/1/1f/New-tricks-mips-linux.pdf) but is looks
> > like this is not accepted by the community. Is there any process
> > planned or made in this area?
> 
> I think limited time and gain killed the propoosed ABI rather than
> theoretical issues raised.  Other architectures such as i386 - well,
> IIRC any 32-bit ABI with more than 2GB userspace and a signed
> ptrdiff_t - are suffering from them as well.

There's no issue with ptrdiff_t being signed 32-bit as long as the
implementation does not allow individual objects larger than 2GB.
Taking differences between pointers into different objects is UB.

Rich
