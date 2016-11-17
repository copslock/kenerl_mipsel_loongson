Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2016 15:14:19 +0100 (CET)
Received: from mout.kundenserver.de ([217.72.192.75]:62758 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990451AbcKQOOLqdo8o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2016 15:14:11 +0100
Received: from wuerfel.localnet ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPSA (Nemesis) id
 0LZf8m-1cUIf30iGS-00lUGO; Thu, 17 Nov 2016 15:13:57 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH] of: base: add support to get machine model name
Date:   Thu, 17 Nov 2016 15:13:53 +0100
Message-ID: <2202339.ajrKjCY7Ro@wuerfel>
User-Agent: KMail/5.1.3 (Linux/4.4.0-34-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <622ddcbc-69b9-98f2-51f3-e256764ecb93@arm.com>
References: <1479383450-19183-1-git-send-email-sudeep.holla@arm.com> <3670336.mMHByOpDl4@wuerfel> <622ddcbc-69b9-98f2-51f3-e256764ecb93@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:uRXQoiLkT7EZ5pCzdMETDRlykeqWTqoYcHKePpkM/FVbXlwqhAr
 sGEe12EOK8ep7B+9oSQvLb8IDNuNvbYkOL6ChpMl1v0FZm4Fr4X+0Syl/JqeVRZHmlvz2NJ
 7ky9t7KaT/0qFXOPZH2kzvJoG1pXTZbCqKNupB/AjAwKNYxbInLt7H3cxvf7OktXP5kNm8Y
 0axhKVsN+wpDQkO5kMb8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9trrtasJ/oA=:APDDVbSZYh/TQmLy3wnyH/
 O+c0Oqj0JAS47p7Tq1MsaZcyO1vuNJP04NRztmaL32oX9/N3UmIfgXpeGKqEef+aWlEJl13IZ
 7lWX5G3roEvCE/qtAu4YnG+mj3p2XsBUlx/Bc71tBgQuw3LahBdTi/bLZAJiup7CpCA2jaa4M
 byAcToJSeXBFW0LbpLg0aibNucCQ3chZTmLP/GVvY/3FvCoLL+/HZQWjo2LFDOoLwvwqrd5PW
 W7lh/NsYvyaMwKzlUZdYHYwiYWySxrvINxBQl6jhUySTdXmCpsyY0NwvUqRtST3kFK2QUnVjK
 R93JETizqAs5V4k1CdFM+IrhJqrB/AVu9sfteqcFWjQr6sheYVq7Jy7w6Fpk4yt3PqT7QlZfo
 zidSdS3r/gNbPeVVb5gTQZK2eZuvl5en2CPUrwUUuMfq4I7V9dTBYA+UGcWp6ecYAkCqZNr8y
 2iktbkZROr/Fa06AOEkScLIdy58SNm3MtXCzWEBJeqiWh1ThoTvs9UGIFHSsdgs06iqRi0YNG
 z5uKNR7AG5qnqM1SPv7btmfFzXMp4V5iM22q5Tj6NBcjEvZPN/4BMOqls3bYgzVYdPvHQ1ReH
 Ho7GUtK+urHC1+lI/yt1kYxwH3pR3+n6v5Rm+y5Ecd8aFHahj2qepfgEA39EU3fpwzqEox+Ic
 s/IUkOhX8RaP6GLSjfeGabLSr4uWpq6NFkjj8fGpOBLSlElCZClD2aVFr9VXteDDhohCv96/i
 iTqAX3A+Zx0hoKES
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thursday, November 17, 2016 2:08:30 PM CET Sudeep Holla wrote:
> On 17/11/16 13:50, Arnd Bergmann wrote:
> > On Thursday, November 17, 2016 11:50:50 AM CET Sudeep Holla wrote:
> >> Currently platforms/drivers needing to get the machine model name are
> >> replicating the same snippet of code. In some case, the OF reference
> >> counting is either missing or incorrect.
> >>
> >> This patch adds support to read the machine model name either using
> >> the "model" or the "compatible" property in the device tree root node.
> >>
> >> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > I like the idea. One small comment:
> >
> 
> Thanks. I prefer it as single patch but it can't be applied to any tree.
> Any suggestions on handling this patch to fix the warning in -next ?
> 
The patch that causes the warning is currently in the mmc tree, and I
don't think it would be good to have your entire patch in there too.

It's probably best to just fix the warning there now by adding another
open-coded copy of that function, and then apply your patch on top
for v4.11.

	Arnd
