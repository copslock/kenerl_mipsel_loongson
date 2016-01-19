Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 15:09:39 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:64437 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010833AbcASOJg7CW-j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2016 15:09:36 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue001) with ESMTPSA (Nemesis) id 0Li5PX-1Zqdwa0u3P-00nOqx; Tue, 19 Jan
 2016 15:09:19 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 2/2] kbuild: Remove stale asm-generic wrappers
Date:   Tue, 19 Jan 2016 15:09:14 +0100
Message-ID: <1667268.iM977TQnEK@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1453210670-12596-3-git-send-email-james.hogan@imgtec.com>
References: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com> <1453210670-12596-3-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V03:K0:jE20OMq+t6LKtHoWcpAxdX+hbJPZWDumu93RclJZi2IcBmu1BB5
 ApWBlF+fqIWzp8PJTomirPu17XKl67+CVhsikWdHR9bHNzmqGvBIsY7NJt/AVPJzeQKxWsU
 2WMElwcpVHV1fNhy3cImPS7yam3WYaTzGjQHhSDzSFqWB6Qj3nhjjao+mZNGJ8iOi7HoyBm
 mCyws3ajUtyJ94eV2rLrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:megdsB3B028=:tmlHz4C1XL/U93M9ICXy7Z
 pS6KjRPBd18LUi4LWaTTZ7i7EDkFzPvAxBYsSISxQ28KCRU82tzSwOUPbRnxtkSXp1WuHDzYT
 gj4SBdUdrqi89Ncp1+OvkuGayouOMihEI1dV4PPNcxzw8fxOuktkvLaFbZPObHvc22d1tLGGP
 jY6cvnK0IKvpDo8vZlBIPPkLNLmvM+XbGH5R4Fsse+imla/Ep/keHwnTo+DW7UopMXJz42Adl
 gsQhN3/s5GEps3VBDuGRBXOaraNQNRHV9EEIOh5jeth8ZKbq6H0jUWhvt8WwlF8TnsdGvBXnb
 k4m5iBLr/cRrxjz4JmYcDenSCZDGQIDU9z731kW6jT4me0NfQg11aFX4oYUeGaGRZEJdVIEZ1
 tnPz106P2dKFZ9gXPiYCPx+X/ubetHaganCB2/J2YWoPBhXpX+AJkuS2Z0OBUedO540Li7WDa
 ymdRegr68DIx9fDcLA87I6WOyyrRIxBw2MFDzQM/iu2QEmn6/Fbj4iBoHkW96xCLiaTuevzd8
 RHG55EB8Jgk8wLawH+SU8VXiuuvA6RzFHnquiR9A9QTwZz1qi8aOqmKk5YQTcukO8uFdXQXwA
 W3jPZ1MDY8w7UCTxaIu+gQbssKGC43jnYYbU9cB5WDCJy7UvKRzF6idghLFWL8mKPnOpjpzyS
 qc00A43Njcnv1Y6kIcPnUiiUS+9XDxjs1cZ2SV15pykeTDdbhXDsXPT8D48x6AfaD89QS9EDe
 IKhzR7/1njT7QRdk
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51220
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

On Tuesday 19 January 2016 13:37:50 James Hogan wrote:
> When a header file is removed from generic-y (often accompanied by the
> addition of an arch specific header), the generated wrapper file will
> persist, and in some cases may still take precedence over the new arch
> header.
> 
> For example commit f1fe2d21f4e1 ("MIPS: Add definitions for extended
> context") removed ucontext.h from generic-y in arch/mips/include/asm/,
> and added an arch/mips/include/uapi/asm/ucontext.h. The continued use of
> the wrapper when reusing a dirty build tree resulted in build failures
> in arch/mips/kernel/signal.c:
> 
> arch/mips/kernel/signal.c: In function ‘sc_to_extcontext’:
> arch/mips/kernel/signal.c:142:12: error: ‘struct ucontext’ has no member named ‘uc_extcontext’
>   return &uc->uc_extcontext;
>             ^
> 
> Fix by detecting and removing wrapper headers in generated header
> directories that do not correspond to a filename in generic-y, genhdr-y,
> or the newly introduced generated-y.

Good idea.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Can you merge this through the mips tree, or do you need me to pick it
up through asm-generic?
