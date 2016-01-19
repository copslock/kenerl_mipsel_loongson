Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 15:27:44 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.134]:54052 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010890AbcASO1mIEB8V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2016 15:27:42 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0MR97T-1aiKEk20AJ-00UZ4f; Tue, 19 Jan
 2016 15:27:25 +0100
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
Date:   Tue, 19 Jan 2016 15:27:24 +0100
Message-ID: <4206493.gjdgtfndZ8@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <20160119142213.GA12679@jhogan-linux.le.imgtec.org>
References: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com> <1667268.iM977TQnEK@wuerfel> <20160119142213.GA12679@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V03:K0:JiunNZpSLt/ZMF48wjqdovFpbGJUmgrHHYAQTGa8ofvdNOWGDN3
 mo0RirB7U/VNnXEA/C3RiQ6yOZyRHHTCQxy/TP6nxt9fCkTKTzXALrETWTatzfUUBXrUgEw
 pQO6K01Pw0Xx4N6fm1IkHbpaRHrQoQIx0HijgBo+qaYlweYQ817LrfPSlHZOk7bmj5IXxsJ
 eRzP/6RDc9QsErxif3Ohw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xW6S5zy1UH4=:EU3qA4dZvU4KfNLL1qTZ0B
 TrVYh4b16fEe54eDeplm3MdWI1/HmKTD7zlODp0Dz+VsSZP33mbhNslIXGpejGvFZLTP/+No+
 dmp2YzRM4guMRRGhiuRH+iIAZisqr2/ApQROSMj3vaPgUM2yY41qYDctcRdnmMfIpgD0dsEjC
 oeSVeXqg/cTMbAJU5KDwZsoVrn+vBhAfllhU4mDxaWJDAkmjVmaH0Mu7APY3Z88ETsjpZxCF7
 xH98luyqnOuGVvc37S0yOOz0r2CjyBEoZm8GR9mtjCFf7/XPTPq+Btmnh1V7RV+WKbIlpyCLn
 ZfSzERixsmU4jnQiXFO9i6X+7W6DkMko6dQocWu548w4uLz/3L7X2g4U2cwsOMw3ZwEOppDTd
 FsdLXuAp2ymdpsPtykL/OiVAfNUWxIarelAGQVF7YlrmgcgUZbkkqCr8yqp8U2n55YzTvSM9Y
 9V8o8j35LK+JiuCLxQxiGwGjVPOFDfyweEC2OZdSmqs6hAPRvPLTaz+uCc6w2+bAZ1gcZ0Bex
 uDz0G9Vu+4CNzeW6PnGJzfRrbpZjw4LVPupGS5AIN8p3TapZzXXNdoIosY2AiTxEoBqYEJb95
 2r3AO1v5Vd20UmSZAxzLtAt/eLFSkPQkmT7IP5Qxi269aJXk+g5UAfGTkxIARCPAlxXIwAavd
 URerpZACZLyHttxqN1w9Db0hvrZ1W4YZZ/liZcWwt+MxfPgi/pEzx1ToBcX0TunprCosAnOcB
 SBqxWp553i8kzPsH
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51223
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

On Tuesday 19 January 2016 14:22:13 James Hogan wrote:
> On Tue, Jan 19, 2016 at 03:09:14PM +0100, Arnd Bergmann wrote:
> > On Tuesday 19 January 2016 13:37:50 James Hogan wrote:
> > > When a header file is removed from generic-y (often accompanied by the
> > > addition of an arch specific header), the generated wrapper file will
> > > persist, and in some cases may still take precedence over the new arch
> > > header.
> > > 
> > > For example commit f1fe2d21f4e1 ("MIPS: Add definitions for extended
> > > context") removed ucontext.h from generic-y in arch/mips/include/asm/,
> > > and added an arch/mips/include/uapi/asm/ucontext.h. The continued use of
> > > the wrapper when reusing a dirty build tree resulted in build failures
> > > in arch/mips/kernel/signal.c:
> > > 
> > > arch/mips/kernel/signal.c: In function ‘sc_to_extcontext’:
> > > arch/mips/kernel/signal.c:142:12: error: ‘struct ucontext’ has no member named ‘uc_extcontext’
> > >   return &uc->uc_extcontext;
> > >             ^
> > > 
> > > Fix by detecting and removing wrapper headers in generated header
> > > directories that do not correspond to a filename in generic-y, genhdr-y,
> > > or the newly introduced generated-y.
> > 
> > Good idea.
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks Arnd
> 
> > Can you merge this through the mips tree, or do you need me to pick it
> > up through asm-generic?
> 
> I was envisaging the kbuild tree tbh, but I don't really mind how it
> gets merged. This patch depends on patch 1, which adds generated-y to
> x86 so we don't delete their other generated headers, but other than
> that it doesn't really have any dependencies.

Ok, the kbuild tree works fine too, and I guess the x86 tree would
also be fine if that helps avoid the dependency.

	Arnd
