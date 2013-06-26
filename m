Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 01:48:56 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:40171 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835008Ab3FZXsfkxpr8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 01:48:35 +0200
Message-ID: <51CB7D83.4030904@imgtec.com>
Date:   Wed, 26 Jun 2013 16:47:15 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH v2] Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account
 for PHYS_OFFSET"
References: <1371742590-10138-1-git-send-email-Steven.Hill@imgtec.com> <20130626145234.GB7171@linux-mips.org> <gjxqcs1k6ixh0k608l2d5c4p.1372261412004@email.android.com> <20130626162302.GE7171@linux-mips.org> <nh7ue18fnbn1tbs2wsphlis9.1372265400519@email.android.com> <20130626175015.GH7171@linux-mips.org> <51CB3B04.1070903@imgtec.com> <alpine.LFD.2.03.1306262233250.32101@linux-mips.org>
In-Reply-To: <alpine.LFD.2.03.1306262233250.32101@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
X-SEF-Processed: 7_3_0_01192__2013_06_27_00_48_21
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 06/26/2013 02:41 PM, Maciej W. Rozycki wrote:
> Ralf,
>   To complete the image, there is a set of new memory access instructions
> added (including but not limited to CACHE) that in the kernel mode
> separates accesses to the user space from accesses to the kernel space,
> i.e. the same virtual address can map differently depending on which
> instruction set it is used with.  I encourage you to have at least a skim
> over the most recent set of MIPS architecture manuals publicly available
> where it all is documented.
>
>    Maciej

Look into http://www.mips.com/auth/MD00091-2B-MIPS64PRA-AFP-03.52.pdf
(registration required). Read sections 4.13, 4.12 and 9.13-9.15.
Ignore anything for 64bit core.

Sorry, I asked David Lau to update MIPS32 actual docs but it can take time.
Right now it is from 2011 year.

- Leonid.
