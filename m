Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 07:31:54 +0100 (CET)
Received: from mail-wg0-f54.google.com ([74.125.82.54]:40306 "EHLO
        mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007117AbbCEGbwRDtlQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 07:31:52 +0100
Received: by wghk14 with SMTP id k14so7450078wgh.7;
        Wed, 04 Mar 2015 22:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0P5GYZX6WZrlr2fwo0kBeRfNdoXf2n9UPFqeu/fWkxA=;
        b=1KAyGlgy6dQFRMDoJI4PVlJOW4j4MiqLF76LkxygKsalVmkf2Ab8FKBfbGtGhqs20I
         BS7NQdUx6Abg0ReHHPejyIcLE0t3+OABAt/4VNr0fCEK6PQUO2wU/ZbGcgUbgTal6BcC
         oSxnW/Dr9MHih1jmLoGcczJUiqBg4k0sI5gcnsvDPEhlsNJy1/7TTvY9VI2I6tZMUcUs
         Fp5PxcLmMDvWSIJRgMPfd81PjF8Oa0FeR99g4NUrYDkH99K0XvHuLOkMvwBgQTEkaLal
         qhI70Wvb1czeFISlKrMVStWTW67A90VzH25F/QBF0n93whWeahqYiuzuUGbyRao5YVQR
         lOvw==
X-Received: by 10.180.75.243 with SMTP id f19mr19323133wiw.94.1425537107565;
        Wed, 04 Mar 2015 22:31:47 -0800 (PST)
Received: from gmail.com (540334ED.catv.pool.telekom.hu. [84.3.52.237])
        by mx.google.com with ESMTPSA id vq9sm7423954wjc.6.2015.03.04.22.31.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2015 22:31:46 -0800 (PST)
Date:   Thu, 5 Mar 2015 07:31:43 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        Laura Abbott <lauraa@codeaurora.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 8/8] x86: switch to using asm-generic for seccomp.h
Message-ID: <20150305063143.GA23023@gmail.com>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
 <1425518828-16017-9-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425518828-16017-9-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Kees Cook <keescook@chromium.org> wrote:

> Switch to using the newly created asm-generic/seccomp.h for the 
> seccomp strict mode syscall definitions. The obsolete sigreturn 
> syscall override is retained in 32-bit mode, and the ia32 syscall 
> overrides are used in the compat case. Remaining definitions were 
> identical.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
