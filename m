Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2016 12:57:47 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.130]:50708 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026982AbcDSK5pF9gz1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Apr 2016 12:57:45 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue003) with ESMTPSA (Nemesis) id 0MOmZe-1amQvP3WVi-00636e; Tue, 19 Apr
 2016 12:56:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Konstantin Khlebnikov <koct9i@gmail.com>, x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arch/defconfig: remove CONFIG_RESOURCE_COUNTERS
Date:   Tue, 19 Apr 2016 12:56:55 +0200
Message-ID: <4214150.v1WFzl5UmK@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <146105442758.18940.2792564159961963110.stgit@zurg>
References: <146105442758.18940.2792564159961963110.stgit@zurg>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:NgNtYQEEPSeNsI9mmkoqQNG+/wnczVmUmCuQygZazMHm7gwbD4O
 ApJQP8s64s+P7D9C6sn9UetkVySpb+TcHYkKRNlTRlQrMOcsYmVdLCmaMyFI4WuuV89y2WY
 nZOKqFRRgW/wY12NYXE9q6qBGQXTiOpZKocAt/V5/Wx+Q1c1YYsRAjdqDxKd3J3iz1oCOW7
 mVpk/cVLunB7cACAEDpOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CXIAVhesp0U=:22yuEGJtVcJpWaKJoSmH6x
 WHTulwVR9pyEwgNYs2PT85rNCwsJOfxP6wR/Ke3dCEsZANxAAmrjH29IdFOLRlcUKzNUxfT2r
 Y5ULEysnpbHCAt/J5JOObSkRWWthKKdmz2VnWN9HehJacCz6Aq+X8q3jgbGbzr5wnFCxpNFm/
 y5eQd8/O9HZCMwi6hgZYiCrBICb2K/Sk91JhUd2zlICiX0VX7YMxRtrb5b+4d7JfwoHPvtO3f
 B8QcQapwVgEWeWA/vFN33aOF2COr0RsC4ijzkgatyrvi6EuDaWZBqEA9eng2/IyP+oZeMuUpG
 QSEI1JIg3Z+CkbUDyRD6etkYVmPlbh+pIyQDzhMMcOjN0K4gP/L9ccoLzPTiATKNG5gCPaZZN
 HHHF35BQaBYxA4/iXDWNU3oly/U1tOkiXkajZC56o2Ay0z2Ve63fK5BSAse3eCPLLLWgbsbKG
 LHDjPDWwW+Pp/CK12J7SWTc+8hs3tAwkGQa0HwbPrv02GKs0J2joC7mfmeugz8BuFROav4QBH
 Cb1UF0ekUxGHKE7umFHi6qcoCSyxOUxUCaR2fPxsR6RBEYDpjHbskE7XkqKZxN5KnLn7hQfNV
 9CI6EC7kcPNi798X0zqbvkFZAw4xkATykGWx+CyFgqj9HwSdUn1pa5bQY2mxlLdYXzcwOj61z
 ClmGwLFgUl/9UQuqM9FTHXkOUytsAIQeX2JC+eeM+mOJ+rXSMi+EZ7cF1YX0HR4sY6G4dqwNe
 9Dex3sfITD1Cukfu
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53097
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

On Tuesday 19 April 2016 11:27:07 Konstantin Khlebnikov wrote:
> This option replaced by PAGE_COUNTER which is selected by MEMCG.
> 
> Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>
> 
Acked-by: Arnd Bergmann <arnd@arndb.de>
