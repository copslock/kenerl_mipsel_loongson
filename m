Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 16:13:46 +0100 (CET)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:58692 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007660AbbCIPNodacYp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2015 16:13:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=CNSwEXM/vIwkPJ00WJ8iph/2quSSRlF5SxwmC6ct10M=;
        b=dUe3iAdgyvW7pbnKN6KFUEJeeeJCdkAaGuNvWeQADSdZL6hFJ3bhyi7Q56a1tB1dlSSSROvO4X0dlYBW9kPAhLzQerASxR73u23gLEpa/88jSifCQ7XNobk4ZX4flW5NotEsaFvv7zjTd5oe78FWNubRkZL455H78yDl2UrZHBA=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:35267)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1YUzMz-000612-Iu; Mon, 09 Mar 2015 15:13:25 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1YUzMu-0003Tf-FP; Mon, 09 Mar 2015 15:13:20 +0000
Date:   Mon, 9 Mar 2015 15:13:19 +0000
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
Subject: Re: [PATCH 4/5] mm: split ET_DYN ASLR from mmap ASLR
Message-ID: <20150309151319.GP8656@n2100.arm.linux.org.uk>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <1425341988-1599-5-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425341988-1599-5-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46292
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

On Mon, Mar 02, 2015 at 04:19:47PM -0800, Kees Cook wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 248d99cabaa8..e2f0ef9c6ee3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1,7 +1,6 @@
>  config ARM
>  	bool
>  	default y
> -	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST

This doesn't mean much on its own...

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
