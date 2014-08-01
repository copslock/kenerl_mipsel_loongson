Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2014 18:48:35 +0200 (CEST)
Received: from p54BA95AA.dip0.t-ipconnect.de ([84.186.149.170]:34431 "EHLO
        linux-mips.org" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6842510AbaHAQsdfv0Ih (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2014 18:48:33 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s71Gm50o017534;
        Fri, 1 Aug 2014 18:48:05 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s71Gm3fb017533;
        Fri, 1 Aug 2014 18:48:03 +0200
Date:   Fri, 1 Aug 2014 18:48:03 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Paul Burton <paul.burton@imgtec.com>, Chen Jie <chenj@lemote.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        =?utf-8?B?546L6ZSQ?= <wangr@lemote.com>
Subject: Re: [PATCH] Not preempt in CP1 exception handling
Message-ID: <20140801164803.GA17520@linux-mips.org>
References: <1405047990-12519-1-git-send-email-chenhc@lemote.com>
 <1405048453-12633-1-git-send-email-chenj@lemote.com>
 <20140711155631.GE8187@pburton-laptop>
 <CAGXxSxV2KWiArguRRKWcbC82sZJweyjiDBBpJdWPne_Ag_Z_+w@mail.gmail.com>
 <CAAhV-H5z1Xu5Mg0X68Yf_mpi8ZBg96TEYLkk4_2_Grb8=ET05Q@mail.gmail.com>
 <20140712093003.GF8187@pburton-laptop>
 <CAAhV-H4PbCLam5jdUjCdn9X9+pL6HR5=8wT_6TPWMt31qv4gMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H4PbCLam5jdUjCdn9X9+pL6HR5=8wT_6TPWMt31qv4gMA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41860
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

On Mon, Jul 14, 2014 at 10:22:47AM +0800, Huacai Chen wrote:

> What do you think about? If you also prefer to totally remove the
> BUG_ON(), I will send a new patch.

I agree, removing the BUG_ON() is the right way.

  Ralf
