Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 16:15:44 +0100 (CET)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:58731 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007660AbbCIPPmiwtMF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2015 16:15:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=kVnZz+NWZqbdgjiM/BYrbFmesoInH/HELC8MDVCqbtk=;
        b=Ilt27TaNtIzqSv2iGAXUabqgmvZW24aY+OQ9Lcg3WrYc0EgbWNcUw8X+LVo4JZB4d+lfx3d9tDW5NEiN9pBPC+SWTlkKx/YD31xd8Nl6HuSqUE4yZ8UPOdRMypiEyj36gFTRcN+Gl3FJNTHeC4pddxz7EuW9dAG5uoAFrVRHuyY=;
Received: from n2100.arm.linux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:44444)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1YUzP0-00062J-I9; Mon, 09 Mar 2015 15:15:30 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1YUzOx-0003VD-6f; Mon, 09 Mar 2015 15:15:27 +0000
Date:   Mon, 9 Mar 2015 15:15:26 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
        Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] split ET_DYN ASLR from mmap ASLR
Message-ID: <20150309151526.GQ8656@n2100.arm.linux.org.uk>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425341988-1599-1-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Mon, Mar 02, 2015 at 04:19:43PM -0800, Kees Cook wrote:
> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
> ASLR from mmap ASLR, as already done on s390. The architectures
> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
> and x86), have their various forms of arch_mmap_rnd() made available
> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
> arch_randomize_brk() is collapsed as well.
> 
> This is an alternative to the solutions in:
> https://lkml.org/lkml/2015/2/23/442

I've run this on one of my ARM platforms, and it looks fine.

2a05e000-2a05f000 r-xp 00000000 00:10 7750376    /root/offset2lib/get_offset2lib
2a066000-2a067000 r--p 00000000 00:10 7750376    /root/offset2lib/get_offset2lib
2a067000-2a068000 rw-p 00001000 00:10 7750376    /root/offset2lib/get_offset2lib
b6dfd000-b6ed3000 r-xp 00000000 00:10 1376508    /lib/arm-linux-gnueabihf/libc-2.15.so
b6ed3000-b6eda000 ---p 000d6000 00:10 1376508    /lib/arm-linux-gnueabihf/libc-2.15.so
b6eda000-b6edc000 r--p 000d5000 00:10 1376508    /lib/arm-linux-gnueabihf/libc-2.15.so
b6edc000-b6edd000 rw-p 000d7000 00:10 1376508    /lib/arm-linux-gnueabihf/libc-2.15.so
b6edd000-b6ee0000 rw-p 00000000 00:00 0
b6ef9000-b6f10000 r-xp 00000000 00:10 1376509    /lib/arm-linux-gnueabihf/ld-2.15.so
b6f13000-b6f17000 rw-p 00000000 00:00 0
b6f17000-b6f18000 r--p 00016000 00:10 1376509    /lib/arm-linux-gnueabihf/ld-2.15.so
b6f18000-b6f19000 rw-p 00017000 00:10 1376509    /lib/arm-linux-gnueabihf/ld-2.15.so
bea3b000-bea5c000 rw-p 00000000 00:00 0          [stack]
bec22000-bec23000 r-xp 00000000 00:00 0          [sigpage]
ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]

And offset2lib shows a random offset:

Offset2lib (libc): 0xffffffff73261000
Offset2lib (libc): 0xffffffff732ce000
Offset2lib (libc): 0xffffffff731b1000
Offset2lib (libc): 0xffffffff73252000

So, for ARM:

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
