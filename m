Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Sep 2015 14:09:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46909 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008006AbbI2MJKQk0Vf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Sep 2015 14:09:10 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t8TC99sq002940;
        Tue, 29 Sep 2015 14:09:09 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t8TC993k002939;
        Tue, 29 Sep 2015 14:09:09 +0200
Date:   Tue, 29 Sep 2015 14:09:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Use ARCH_USE_BUILTIN_BSWAP.
Message-ID: <20150929120908.GB2505@linux-mips.org>
References: <20150929102855.GA1319@linux-mips.org>
 <20150929115222.GA2505@linux-mips.org>
 <yw1x612tqvur.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x612tqvur.fsf@unicorn.mansr.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49396
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

On Tue, Sep 29, 2015 at 12:59:56PM +0100, Måns Rullgård wrote:

> Ralf Baechle <ralf@linux-mips.org> writes:
> 
> > On Tue, Sep 29, 2015 at 12:28:55PM +0200, Ralf Baechle wrote:
> >
> >>    text    data     bss     dec     hex filename
> >> 3996071  155804   88992 4240867  40b5e3 vmlinux         ip22 baseline
> >> 3985687  159900   88992 4234579  409d53 vmlinux         ip22 + bswap patch
> >> 6913157  378552  251024 7542733  7317cd vmlinux         ip27 baseline
> >> 6878581  378552  251024 7508157  7290bd vmlinux         ip27 + bswap patch
> >> 5773777  268752  187424 6229953  5f0fc1 vmlinux         malta baseline
> >> 5773401  268752  187424 6229577  5f0e49 vmlinux         malta + bswap patch
> >
> > A still unexplained effect of this patch and the reason why I have not
> > committed this patch is the increase of the data size for the ip22
> > configuration by 4096 bytes.  There is no change in data size expected.
> > Also this affects only the test with ip22_defconfig not any of the others
> > I've tried.
> 
> Have you checked which object file(s) the increase comes from?

Working on that.

  Ralf
