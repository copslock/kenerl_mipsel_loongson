Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2014 18:16:48 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58478 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007547AbaK1RQqUNUuW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Nov 2014 18:16:46 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sASHGhhr017914;
        Fri, 28 Nov 2014 18:16:43 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sASHGdmq017913;
        Fri, 28 Nov 2014 18:16:39 +0100
Date:   Fri, 28 Nov 2014 18:16:39 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Walmsley <paul@pwsan.com>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Kumar Gala <galak@codeaurora.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sandeep Nair <sandeep_n@ti.com>, linux-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] MIPS: BCM47XX: Move NVRAM driver to the drivers/soc/
Message-ID: <20141128171639.GC30648@linux-mips.org>
References: <1416736241-12723-1-git-send-email-zajec5@gmail.com>
 <1416778509-31502-1-git-send-email-zajec5@gmail.com>
 <alpine.DEB.2.02.1411240910100.16047@utopia.booyaka.com>
 <CACna6rxwwn5_e86278TAiOFZ3sVu_Exfm2x94vN2KiTJfsFujQ@mail.gmail.com>
 <alpine.DEB.2.02.1411251407290.16047@utopia.booyaka.com>
 <CACna6rxj8=V8me1_L8SxhV3=kgYRyKeBHkxShSMZa4kbcHimLg@mail.gmail.com>
 <alpine.DEB.2.02.1411271926560.1406@utopia.booyaka.com>
 <CACna6rwMjOfmnA-926udNx7jQHQ2JMnmiutQZkTxtJ85qmUw8A@mail.gmail.com>
 <alpine.DEB.2.02.1411281659190.1406@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1411281659190.1406@utopia.booyaka.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44516
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

On Fri, Nov 28, 2014 at 05:07:12PM +0000, Paul Walmsley wrote:

> If I were in your shoes, I would suggest either
> 
> 1. asking Ralf to merge your patches that touch drivers/firmware, since 
> he'll also presumably be merging the parts that touch arch/mips
> 
> or 
> 
> 2. asking Greg KH to merge those patches
> 
> And of course it would not hurt to collect some Reviewed-By:s from other 
> folks.  (See below...)

I surely can carry this patch.

  Ralf
