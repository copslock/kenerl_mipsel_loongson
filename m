Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2018 18:49:19 +0200 (CEST)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:37883
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994609AbeHaQtP01PLQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Aug 2018 18:49:15 +0200
Received: by mail-pg1-x543.google.com with SMTP id 2-v6so5176732pgo.4
        for <linux-mips@linux-mips.org>; Fri, 31 Aug 2018 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCAuXK2OzX1Y32o4nfX28eLgRp+6m9IIcFWuemVE5WY=;
        b=N18YRpr8Sb1LGBugLd2WKciz/6inmAgY4pGO/BJSgASuLXw3cUZK9Fc91sHLPyPzur
         h59KQ9BlIUiAigm8ubE55V4N6/53+5jD/Kbcq0N4xoPSeBxIkDwJwdwSUWzEzVMbb0TZ
         MFQdDCBv+rpJUkfTRi2D3PtRo5/qh6AEEdTLb/aEIliVhnpYKjp4Q2bakgARP51iJNrC
         01+GpwMzT5JyHtVWTwLziSLHTD5MwGA+OqGWBpU6VPF6Pu/NKBJ6SM3aDjR6VSQ6Wq36
         zTPjlA8/quUpxZwtwYw69Qzm4KCXQAHE0iJNTjbS/JujWES9LuRc4lxfgVtesjPXWf5A
         nGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCAuXK2OzX1Y32o4nfX28eLgRp+6m9IIcFWuemVE5WY=;
        b=eFLN4TbmCVMZepmCugDhEvLKtrxos6JohXUvJC4vmvxbxflBpg1jmch6qax0gRoiix
         BWpFZR/TxDWXmQa/pOleh6FC9KOAKKY5mrsKB07P6ZYM/odmMfRym5Iqb/isAIczEHU/
         gWlBSNcM1z2wSZ8905x6JmrBarrMpxgrKe0xTw7lftMTSiQFbPY/hzo43RlA4kSauvSl
         Z63kVtVzWYvW2T4dt9wKYVrxDRzDrRa1IpojY0q/8DeJqJcX9GROmYU481NhTSS5Pb+p
         6AHbyIl87D9XJnV645Qc5LNzpovwMCW7nwncBMuciqm/wBnK1/nBLWhZ/ghA7W8Frwqi
         s6Gg==
X-Gm-Message-State: APzg51DN7gqA63/YuG1umlISW59dIfTv7GLwmm9BujqDG2cCdrebTJGu
        LZuT+ZAj7sQOQT8cNzmUMgpLkND70a681Z7VAPBbxQ==
X-Google-Smtp-Source: ANB0VdbRCc3PpGAdVeCprV2/GhB/CLIRt66A5Es0TtK/QPaElj4MkPRSFfBiaWIFkeOLJu35AGY3WpglDxV6XSZ036A=
X-Received: by 2002:a63:c245:: with SMTP id l5-v6mr15273352pgg.255.1535734148077;
 Fri, 31 Aug 2018 09:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de> <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com> <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com> <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
 <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
 <20180827073358.GV24124@hirez.programming.kicks-ass.net> <f9896d68-4a49-e666-cea5-a9c0522f1658@zytor.com>
 <20180827131103.GD24124@hirez.programming.kicks-ass.net> <4d1a8f35-e2fc-70d2-ca0e-44b8574c86f1@zytor.com>
In-Reply-To: <4d1a8f35-e2fc-70d2-ca0e-44b8574c86f1@zytor.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 31 Aug 2018 09:48:56 -0700
Message-ID: <CAKwvOdmXhRZJ5bQw+W0Ro+oeWSTRJzG1UAJnjyjciR1JFs+ubA@mail.gmail.com>
Subject: Re: [PATCH] treewide: remove current_text_addr
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, deller@gmx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Simon Horman <horms@verge.net.au>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, Matt Turner <mattst88@gmail.com>,
        vgupta@synopsys.com, linux@armlinux.org.uk,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, msalter@redhat.com,
        jacquiot.aurelien@gmail.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org,
        Green Hu <green.hu@gmail.com>, deanbo422@gmail.com,
        lftan@altera.com, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>, jejb@parisc-linux.org,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        palmer@sifive.com, aou@eecs.berkeley.edu, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, dalias@libc.org,
        "David S. Miller" <davem@davemloft.net>, gxt@pku.edu.cn,
        x86@kernel.org, jdike@addtoit.com, richard@nod.at,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>, noamc@ezchip.com,
        mickael.guene@st.com, Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Mark Rutland <mark.rutland@arm.com>, chenhc@lemote.com,
        macro@mips.com, Arnd Bergmann <arnd@arndb.de>, dhowells@redhat.com,
        sukadev@linux.vnet.ibm.com, Nicholas Piggin <npiggin@gmail.com>,
        aneesh.kumar@linux.vnet.ibm.com, felix@linux.vnet.ibm.com,
        linuxram@us.ibm.com, christophe.leroy@c-s.fr, cohuck@redhat.com,
        gor@linux.vnet.ibm.com, nick.alcock@oracle.com,
        shannon.nelson@oracle.com,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        luto@kernel.org, bp@suse.de, dave.hansen@linux.intel.com,
        vkuznets@redhat.com, jkosina@suse.cz, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, hpa@zytor.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ndesaulniers@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ndesaulniers@google.com
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

On Mon, Aug 27, 2018 at 6:34 AM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 08/27/18 06:11, Peter Zijlstra wrote:
> > On Mon, Aug 27, 2018 at 05:26:53AM -0700, H. Peter Anvin wrote:
> >
> >> _THIS_IP_, however, is completely ill-defined, other than being an
> >> address *somewhere* in the same global function (not even necessarily
> >> the same function if the function is static!)  As my experiment show, in
> >> many (nearly) cases gcc will hoist the address all the way to the top of
> >> the function, at least for the current generic implementation.
> >
> > It seems to have mostly worked so far... did anything change?
> >
>
> Most likely because the major architectures contain a arch-specific
> assembly implementation.  The generic implementation used in some places
> is completely broken, as my experiments show.
>
> >> For the case where _THIS_IP_ is passed to an out-of-line function in all
> >> cases, it is extra pointless because all it does is increase the
> >> footprint of every caller: _RET_IP_ is inherently passed to the function
> >> anyway, and with tailcall protection it will uniquely identify a callsite.
> >
> > So I think we can convert many of the lockdep _THIS_IP_ calls to
> > _RET_IP_ on the other side, with a wee bit of care.
> >
> > A little something like so perhaps...
>
> I don't have time to look at this right now (I'm on sabbatical, and I'm
> dealing with personal legal stuff right at the moment), but I think it
> is the right direction.
>
>         -hpa

Linus,
Can this patch please be merged?  Then we can polish off Peter's
change to lockdep to not even use _THIS_IP_.

-- 
Thanks,
~Nick Desaulniers
