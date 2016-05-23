Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 17:57:21 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.131]:54649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27033458AbcEWP5QB-w3E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2016 17:57:16 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue005) with ESMTPSA (Nemesis) id 0MfDvq-1atPqS08oU-00OpRz; Mon, 23 May
 2016 17:55:06 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Michal Marek <mmarek@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/2] kbuild: Remove stale asm-generic wrappers
Date:   Mon, 23 May 2016 17:55:02 +0200
Message-ID: <6113470.ejZJVBYpBf@wuerfel>
User-Agent: KMail/5.1.3 (Linux/4.4.0-22-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <1463991681-3531-1-git-send-email-james.hogan@imgtec.com>
References: <1463991681-3531-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:Uv7HTrCyxvb950Wu4RkCVASb5ks/JW1e34dY2WD41hRko9E60Df
 rMJOxD9xE4IV14jo3fg9uX9KPxYSrtwOlBWqHTglZm4dt/zKaINAQYA1uTRp4r/S9XyPRLK
 nnIuevoVtENQcOSyFnGQpEctDfq+nOjkCyNtDuz82OT7DPoGY5ZLZabUhlr//YwOuqp7gnb
 HaAaSrxUdrNx9um9+fjFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8AleXzpeRBU=:I2abN/WPb9urFbjuhVWmaQ
 ALkpYwbq4gsy1a7gwC37MbraAiZPRQMbIcfhC+feuDHPmr2zwYTgr34epL0+1+AeAmq1XrZEs
 xZwa4ATeWaGMIsX2z48wrnA05DgeRjpTL7FPZzZlRsiMgVHs7NRdmgSeNIf2IhIckaU/RAT+J
 YBrFTSNDZOSmqwC+p6p4GEJtnbxDMRzLrEZCaczEsthz/RuF1awIh2yCtwYAYlcOYAoFOqkKJ
 5HVCioDvbTS1M6A/9rmzlgKzfrB/iz3R5FsQ7ZBEodXSBDN6lF4vs8InjfuyWI7KcQlk2pY6w
 yDyiG7f8Juxd4V+RiX8BWkBXZYW5DjZe08mufWrL7uWoS1zgYaarReIA5iX4iz3+KfjzUUnXI
 1V3uA9z95PddvIupQkmXNDJ5acyQx4NybF/b+TdsykxGEOpwW86mgWV5KHLn615hZ1S/yvEWW
 cq7NVH3f7ULd83IuEqgbKPY/T2ybdLd/X1h5AMc0eYBwsFXqq4R5wW+ViUGlM43WzROhjFAzQ
 W7vfGdsiqZIvFWU2BUB69EGh59cZ9H5BU27z3ZymDw1IfJPxVYb0NxwwF58f1nId9+aIRRL6J
 +WVWPC7E6XretEB2j/ZeoTOJlfO2rxrPpg/ud39kzQsHkpZ7wwoDTp1WTdO9ajWweWEUWQGNx
 DKU/qtvVvRRRMnAaKPgOAKOfK70eFHdzFwYMkBTZf6dRv7s4oRTpKmOFzc+payBPqOuE2N3Gp
 KKiQWdlaULjWcQmp
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53616
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

On Monday, May 23, 2016 9:21:19 AM CEST James Hogan wrote:
> This patchset attempts to fix kbuild to automatically remove stale
> asm-generic wrappers, i.e. when files are removed from generic-y and
> added directly into arch/*/include/uapi/asm/, but where the existing
> wrapper in arch/*/include/generated/asm/ continues to be used.
> 
> MIPS was recently burned by this in v4.3 (see patch 2), with continuing
> reports of build failures when people upgrade their trees, which go away
> after arch/mips/include/generated is removed (or reportedly make
> mrproper/distclean). It is particularly irritating during bisection.

Nice series!

Acked-by: Arnd Bergmann <arnd@arndb.de>

There are a number of files that we leave behind after a make clean,
and I also wondered if we could remove some more of them, but I couldn't
easily figure out which of them were left intentionally.

The asm-generic wrappers certainly are not there for a good reason,
and it's good to see them gone.

	Arnd
