Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 03:34:42 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:33821
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994780AbdCNCef0JP8s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 03:34:35 +0100
Received: by mail-wm0-x244.google.com with SMTP id u132so12651507wmg.1;
        Mon, 13 Mar 2017 19:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rzoZ0WpHhTa1ozY/Hj3badVzkI9GlDpY617mrc0W+1o=;
        b=M3t7EuONgWQOz8TbT50Qy+aUouMzK0R6NmqnkuSIktSdYHIUM+kkZr0t5pydvkcHa5
         Hv/Qd9N9qJRBwW7t4zc7TJvRwCfwUmzrSxZ1h89mWcLC6JAqxaO4BerX+GB8Xk7bUgoP
         BxKno65YF+k03QWRqZIB2BxegEwDt/f4Vrtk7Q2G1dzaT3my4cl//clNkckFDFH1YJjX
         M0dokuHFuQP7reyp/yJ3zdM6V6B521zQ/LNNBrIHCNchiIPE++hpi0y58GOT3oT49zci
         loEGVM+B+cW3iWHacNsSbBy80T1u2VxKt91jiwD5dl8Leauc5jS8NJZGSfkXzREX+Wiu
         OSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=rzoZ0WpHhTa1ozY/Hj3badVzkI9GlDpY617mrc0W+1o=;
        b=En7n9VQZySlyDJNgiHgzBMuxNM/NjCJiqVpbLzFhQJjRXHY5PGoGhu67mjXsvhTQLN
         9mncA8LFuBEogDZNcZB+wrvHaMiQ35s80URMcrNlzLHS9BQYN92pk4Ujfxna0dMawz3U
         LE966Tb5We5ysTp+dNri3l1yMqM9xMOzJkkI8119AzUNLpPZdzyAoNYYzvyr+zla+cBt
         KUqVTDai0JrXLC9Ir6kO4kGnRLU/2ZT3bhaeo0qvM5etZ/KCR2We4ZAAC62M/42Cad91
         uf3QgwRiSRVlO8G7hM2A28uuqxjo+DoIELWQQ+8HG3resjt9uOFJ94irV2BifegslLr3
         rbvQ==
X-Gm-Message-State: AFeK/H15zAp90/QiFxKaKyK+8LtdgHWVpQ8QRVZ5n/PHng0vjKPH8aePylkU16dpQan/6g==
X-Received: by 10.28.193.197 with SMTP id r188mr12797994wmf.116.1489458870118;
        Mon, 13 Mar 2017 19:34:30 -0700 (PDT)
Received: from localhost (login1.zih.tu-dresden.de. [141.76.16.140])
        by smtp.googlemail.com with ESMTPSA id t63sm13426962wme.16.2017.03.13.19.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Mar 2017 19:34:29 -0700 (PDT)
From:   Till Smejkal <till.smejkal@googlemail.com>
X-Google-Original-From: Till Smejkal <till.smejkal@gmail.com>
Date:   Mon, 13 Mar 2017 19:34:27 -0700
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Till Smejkal <till.smejkal@googlemail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Miao <realmz6@gmail.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@synopsys.COM>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-mm@kvack.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, alsa-devel@alsa-project.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 10/13] mm: Introduce first class virtual address
 spaces
Message-ID: <20170314023427.3p4a5qxtl5eh5epi@arch-dev>
Mail-Followup-To: Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Till Smejkal <till.smejkal@googlemail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>,
        Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J.  Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@synopsys.COM>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-mm@kvack.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, alsa-devel@alsa-project.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd1adda8-bf6a-47ad-bff3-5bc6626ac100@synopsys.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Return-Path: <till.smejkal@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: till.smejkal@googlemail.com
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

Hi Vineet,

On Mon, 13 Mar 2017, Vineet Gupta wrote:
> I've not looked at the patches closely (or read the references paper fully yet),
> but at first glance it seems on ARC architecture, we can can potentially
> use/leverage this mechanism to implement the shared TLB entries. Before anyone
> shouts these are not same as the IA64/x86 protection keys which allow TLB entries
> with different protection bits across processes etc. These TLB entries are
> actually *shared* by processes.
> 
> Conceptually there's shared address spaces, independent of processes. e.g. ldso
> code is shared address space #1, libc (code) #2 .... System can support a limited
> number of shared addr spaces (say 64, enough for typical embedded sys).
> 
> While Normal TLB entries are tagged with ASID (Addr space ID) to keep them unique
> across processes, Shared TLB entries are tagged with Shared address space ID.
> 
> A process MMU context consists of ASID (a single number) and a SASID bitmap (to
> allow "subscription" to multiple Shared spaces. The subscriptions are set up bu
> userspace ld.so which knows about the libs process wants to map.
> 
> The restriction ofcourse is that the spaces are mapped at *same* vaddr is all
> participating processes. I know this goes against whole security, address space
> randomization - but it gives much better real time performance. Why does each
> process need to take a MMU exception for libc code...
> 
> So long story short - it seems there can be multiple uses of this infrastructure !

During the development of this code, we also looked at shared TLB entries, but
the other way around. We wanted to use them to prevent flushing of TLB entries of
shared memory regions when switching between multiple ASes. Unfortunately, we never
finished this part of the code.

However, we also investigated into a different use-case for first class virtual
address spaces that is related to what you propose if I didn't understand something
wrong. The idea is to move shared libraries into their own first class virtual
address space and only load some small trampoline code in the application AS. This
trampoline code performs the VAS switch in the libraries AS and execute the requested
function there. If we combine this architecture with tagged TLB entries to prevent
TLB flushes during the switch operation, it can also reach an acceptable performance.
A side effect of moving the shared library into its own AS is that it can not be used
by ROP-attacks because it is not accessible in the application's AS.

Till
