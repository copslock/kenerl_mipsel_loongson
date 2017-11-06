Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Nov 2017 06:07:50 +0100 (CET)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35785 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990395AbdKFFHkifRdZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Nov 2017 06:07:40 +0100
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id vA657aES015535;
        Mon, 6 Nov 2017 06:07:36 +0100
Date:   Mon, 6 Nov 2017 06:07:36 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3.10 021/139] MIPS: Send SIGILL for BPOSGE32 in
 `__compute_return_epc_for_insn'
Message-ID: <20171106050736.GA15445@1wt.eu>
References: <1509571159-4405-1-git-send-email-w@1wt.eu>
 <1509571159-4405-22-git-send-email-w@1wt.eu>
 <CAAhV-H6aqeSga3bx9SDDXW23KTi=YWHwKCaXoD-kWUYg9JCyzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6aqeSga3bx9SDDXW23KTi=YWHwKCaXoD-kWUYg9JCyzA@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

Hi Huacai,

On Mon, Nov 06, 2017 at 12:41:48PM +0800, Huacai Chen wrote:
> Hi, Willy,
> 
> Does these two patches really needed for 3.10? They are marked for 4.4 and 4.6.
> 
> ext4: avoid deadlock when expanding inode size
> 
> ext4: in ext4_seek_{hole,data}, return -ENXIO for negative offsets

Ted provided stable backports of these patches for older kernels back
to 3.18, thus I understood that they were valid before 4.4/4.6.

Regards,
Willy
