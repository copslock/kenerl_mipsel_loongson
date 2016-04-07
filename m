Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2016 15:43:49 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025744AbcDGNnpek40e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Apr 2016 15:43:45 +0200
Date:   Thu, 7 Apr 2016 14:43:45 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Paul Burton <paul.burton@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: 4.1: XPA breaks Alchemy
In-Reply-To: <20160407055813.GD26267@linux-mips.org>
Message-ID: <alpine.LFD.2.20.1604071440320.2700@eddie.linux-mips.org>
References: <CAOLZvyHPYF2kO2EdijCCX9OSt=hdo8g-tUXzZee0sSXT=-WdDw@mail.gmail.com> <20160407000658.GA11065@NP-P-BURTON> <20160407055813.GD26267@linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Thu, 7 Apr 2016, Ralf Baechle wrote:

> Everybody is running Sibyte 64 bit; I wonder if highmem with Sibyte is
> also affected.

 Last time I tried SiByte with a 32-bit kernel (a couple years ago) it 
didn't boot at all in the first place.

 FWIW,

  Maciej
