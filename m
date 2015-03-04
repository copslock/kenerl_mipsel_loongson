Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 05:16:50 +0100 (CET)
Received: from ozlabs.org ([103.22.144.67]:36665 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006674AbbCDEQruUQ6d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Mar 2015 05:16:47 +0100
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 3A87A14016A;
        Wed,  4 Mar 2015 15:16:42 +1100 (AEDT)
Message-ID: <1425442601.9084.9.camel@ellerman.id.au>
Subject: Re: [PATCH 4/5] mm: split ET_DYN ASLR from mmap ASLR
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Borislav Petkov <bp@suse.de>,
        Jan-Simon =?ISO-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 04 Mar 2015 15:16:41 +1100
In-Reply-To: <1425341988-1599-5-git-send-email-keescook@chromium.org>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
         <1425341988-1599-5-git-send-email-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

On Mon, 2015-03-02 at 16:19 -0800, Kees Cook wrote:
> This fixes the "offset2lib" weakness in ASLR for arm, arm64, mips,
> powerpc, and x86. The problem is that if there is a leak of ASLR from
> the executable (ET_DYN), it means a leak of shared library offset as
> well (mmap), and vice versa. Further details and a PoC of this attack
> are available here:
> http://cybersecurity.upv.es/attacks/offset2lib/offset2lib.html
> 
> With this patch, a PIE linked executable (ET_DYN) has its own ASLR region:
> 
> $ ./show_mmaps_pie
> 54859ccd6000-54859ccd7000 r-xp  ...  /tmp/show_mmaps_pie
> 54859ced6000-54859ced7000 r--p  ...  /tmp/show_mmaps_pie
> 54859ced7000-54859ced8000 rw-p  ...  /tmp/show_mmaps_pie

Just to be clear, it's the fact that the above vmas are in a different
address range to those below that shows the patch is working, right?

> 7f75be764000-7f75be91f000 r-xp  ...  /lib/x86_64-linux-gnu/libc.so.6
> 7f75be91f000-7f75beb1f000 ---p  ...  /lib/x86_64-linux-gnu/libc.so.6


On powerpc I'm seeing:

# /bin/dash
# cat /proc/$$/maps
524e0000-52510000 r-xp 00000000 08:03 129814                             /bin/dash
52510000-52520000 rw-p 00020000 08:03 129814                             /bin/dash
10034f20000-10034f50000 rw-p 00000000 00:00 0                            [heap]
3fffaeaf0000-3fffaeca0000 r-xp 00000000 08:03 13529                      /lib/powerpc64le-linux-gnu/libc-2.19.so
3fffaeca0000-3fffaecb0000 rw-p 001a0000 08:03 13529                      /lib/powerpc64le-linux-gnu/libc-2.19.so
3fffaecc0000-3fffaecd0000 rw-p 00000000 00:00 0 
3fffaecd0000-3fffaecf0000 r-xp 00000000 00:00 0                          [vdso]
3fffaecf0000-3fffaed20000 r-xp 00000000 08:03 13539                      /lib/powerpc64le-linux-gnu/ld-2.19.so
3fffaed20000-3fffaed30000 rw-p 00020000 08:03 13539                      /lib/powerpc64le-linux-gnu/ld-2.19.so
3fffc7070000-3fffc70a0000 rw-p 00000000 00:00 0                          [stack]


Whereas previously the /bin/dash vmas were up at 3fff..

So looks good to me for powerpc.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
