Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2018 20:19:11 +0200 (CEST)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:47543 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992670AbeFLSTEumYqp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2018 20:19:04 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 36F2B3F991;
        Tue, 12 Jun 2018 20:19:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IbcMf6908D_l; Tue, 12 Jun 2018 20:19:03 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 59EC03F82F;
        Tue, 12 Jun 2018 20:19:03 +0200 (CEST)
Date:   Tue, 12 Jun 2018 20:19:01 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@linux-mips.org
Cc:     "Maciej W. Rozycki" <macro@mips.com>
Subject: Re: [RFC] MIPS: Align vmlinuz load address to a page boundary
Message-ID: <20180612181900.GA2482@localhost.localdomain>
References: <20180610182056.GA15738@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180610182056.GA15738@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

> The kexec system call seems to require that the vmlinuz loading address is
> aligned to a page boundary. 4096 bytes is a fairly common page size, but
> perhaps not the only possibility? Does kexec require additional alignments?

Sorry for the brief description. The problem, more specifically, is
reported by kexec-tools/kexec/kexec.c:343:

	/* Verify base is pagesize aligned.
	 * Finding a way to cope with this problem
	 * is important but for now error so at least
	 * we are not surprised by the code doing the wrong
	 * thing.
	 */
	if (base & (pagesize -1)) {
		die("Base address: 0x%lx is not page aligned\n", base);
	}

https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/kexec/kexec.c?id=HEAD#n343

A more pressing issue at the moment though is that initramfs in vmlinuz is
ignored when booting. Is it supposed to work with a MIPS kernel?

Fredrik

> --- a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
> +++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
> @@ -44,12 +44,8 @@ int main(int argc, char *argv[])
>  	vmlinux_size = (uint64_t)sb.st_size;
>  	vmlinuz_load_addr = vmlinux_load_addr + vmlinux_size;
>  
> -	/*
> -	 * Align with 16 bytes: "greater than that used for any standard data
> -	 * types by a MIPS compiler." -- See MIPS Run Linux (Second Edition).
> -	 */
> -
> -	vmlinuz_load_addr += (16 - vmlinux_size % 16);
> +	/* The kexec system call requires page alignment. */
> +	vmlinuz_load_addr += (4096 - vmlinux_size % 4096);
>  
>  	printf("0x%llx\n", vmlinuz_load_addr);
>  
