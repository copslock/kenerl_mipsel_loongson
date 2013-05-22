Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 19:57:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34516 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835056Ab3EVR5YnCF0b (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 May 2013 19:57:24 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r4MHvKSh020761;
        Wed, 22 May 2013 19:57:20 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r4MHvHY6020760;
        Wed, 22 May 2013 19:57:17 +0200
Date:   Wed, 22 May 2013 19:57:17 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sanjay Lal <sanjayl@kymasys.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org
Subject: Re: [PATCH -next] ia64, metag: Do not export min_low_pfn in
 arch-specific code
Message-ID: <20130522175717.GG10769@linux-mips.org>
References: <1367086831-10740-1-git-send-email-geert@linux-m68k.org>
 <CAAG0J982gbca3XHHSpTHgqPgeGyJRtG8Lm1cWsT0HsThqdFeMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAG0J982gbca3XHHSpTHgqPgeGyJRtG8Lm1cWsT0HsThqdFeMw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36530
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

On Sun, Apr 28, 2013 at 11:24:35AM +0100, James Hogan wrote:

> On 27 April 2013 19:20, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > As of commit 787dcbe6984b3638e94f60d807dcb51bb8a07211 ("MIPS: Export
> > symbols used by KVM/MIPS module"), min_low_pfn is already exported by
> > the generic mm/bootmem.c, causing:
> >
> > WARNING: vmlinux: 'min_low_pfn' exported twice. Previous export was in vmlinux
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> This has been pointed out several times and needs fixing in the mips
> tree where the warning was introduced.

I've changed the MIPS code to no longer require the export of min_low_pfn
and dropped the export of that particular file.  I still see that IA-64
and metag export min_low_pfn so maybe it should be exported from mm/
after all?

  Ralf
