Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 03:07:24 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:36278
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994766AbdCNCHSafopb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 03:07:18 +0100
Received: by mail-wr0-x243.google.com with SMTP id l37so22117038wrc.3;
        Mon, 13 Mar 2017 19:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8lAifVLftxCDt05mTDrVYKXmHSB13ZRC+ceVMa4DhVA=;
        b=vdw3uQnAGgyp/v1sEUo4i9vPKo4qUZlDjF/dNgVLLgGC39WaioLuJsrtQ35c1AwZ9v
         gJ8ROXEuZ+776yOIwaumneHg+VWQc4S8Zmk6+SHOtIeLqvjcq0WzmedmsvG2/ojhlCh8
         7sleOFNZWAjAc2SG8lV9BJvCVAzOfCXINk4WwZEeLoSEM0vC/TeaXMa7PDS9MwQM20Ub
         dFcJi1mYbHXbkKe1wIopx2KfE/VosdPXN1/5OetHGLk102zdn/aG230SVsGm277/iB+8
         bn4yTol0FHokC58Yu+rK+O2hj9jPiMlm2icpc4BIbNcSDDfSnjVMcYZOq5JPH2nDvP6T
         0jZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8lAifVLftxCDt05mTDrVYKXmHSB13ZRC+ceVMa4DhVA=;
        b=aZ+7gRZK/GgZ2gMWUJ/ReMhWjv3c5O3tGzGZ3T7W87hTevpCODG2ZVrjt/txN6zvZC
         ZTWjNS1/hp45Vbnjuh5PGiuwS3GlubaV/RKLs20NZpHVZ5W11usayemBlZVKMPBL21BQ
         8NCpIFArYsmcR3KP/d1lVauWsk/e8FXZT91irCXVbAzCZyUNoYvWPOgGv5CLfZNXVBt4
         jfCVwgYeuqBMZTFtZ7E8P0OUx8mywyvNhmiqBHUZeZcPIXl1L0KX7nfLAenHv9SoZ3Is
         PbXqwyXPp2iLQStQ00vI+SEEe8I4k3/VlwnIlef1biQvWS/RiUfTZiPdD/BSxxmPHTHB
         TGNg==
X-Gm-Message-State: AMke39lU34gtVePX9YW1FL83UZ2yzpQMzsmeIaF6n4qf+iUj/GvPgAx2BsZmPFZgYjj9Zg==
X-Received: by 10.223.169.171 with SMTP id b40mr32421279wrd.132.1489457233070;
        Mon, 13 Mar 2017 19:07:13 -0700 (PDT)
Received: from localhost (login1.zih.tu-dresden.de. [141.76.16.140])
        by smtp.googlemail.com with ESMTPSA id 5sm27053541wrd.58.2017.03.13.19.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Mar 2017 19:07:12 -0700 (PDT)
From:   Till Smejkal <till.smejkal@googlemail.com>
X-Google-Original-From: Till Smejkal <till.smejkal@gmail.com>
Date:   Mon, 13 Mar 2017 19:07:09 -0700
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Till Smejkal <till.smejkal@googlemail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
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
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-hexagon@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-metag@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        USB list <linux-usb@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>
Subject: Re: [RFC PATCH 00/13] Introduce first class virtual address spaces
Message-ID: <20170314020709.vxeglus54k76i7rn@arch-dev>
Mail-Followup-To: Andy Lutomirski <luto@kernel.org>,
        Till Smejkal <till.smejkal@googlemail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>,
        Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
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
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        X86 ML <x86@kernel.org>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-hexagon@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-metag@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-mtd@lists.infradead.org, USB list <linux-usb@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWe8uOi3m8qXUbMA4017+rxbi1C8hzZ0bwjVHmfdE4FnQ@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Return-Path: <till.smejkal@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57193
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

On Mon, 13 Mar 2017, Andy Lutomirski wrote:
> On Mon, Mar 13, 2017 at 3:14 PM, Till Smejkal
> <till.smejkal@googlemail.com> wrote:
> > This patchset extends the kernel memory management subsystem with a new
> > type of address spaces (called VAS) which can be created and destroyed
> > independently of processes by a user in the system. During its lifetime
> > such a VAS can be attached to processes by the user which allows a process
> > to have multiple address spaces and thereby multiple, potentially
> > different, views on the system's main memory. During its execution the
> > threads belonging to the process are able to switch freely between the
> > different attached VAS and the process' original AS enabling them to
> > utilize the different available views on the memory.
> 
> Sounds like the old SKAS feature for UML.

I haven't heard of this feature before, but after shortly looking at the description
on the UML website it actually has some similarities with what I am proposing. But as
far as I can see this was not merged into the mainline kernel, was it? In addition, I
think that first class virtual address spaces goes even one step further by allowing
AS to live independently of processes.

> > In addition to the concept of first class virtual address spaces, this
> > patchset introduces yet another feature called VAS segments. VAS segments
> > are memory regions which have a fixed size and position in the virtual
> > address space and can be shared between multiple first class virtual
> > address spaces. Such shareable memory regions are especially useful for
> > in-memory pointer-based data structures or other pure in-memory data.
> 
> This sounds rather complicated.  Getting TLB flushing right seems
> tricky.  Why not just map the same thing into multiple mms?

This is exactly what happens at the end. The memory region that is described by the
VAS segment will be mapped in the ASes that use the segment.

> >
> >             |     VAS     |  processes  |
> >     -------------------------------------
> >     switch  |       468ns |      1944ns |
> 
> The solution here is IMO to fix the scheduler.

IMHO it will be very difficult for the scheduler code to reach the same switching
time as the pure VAS switch because switching between VAS does not involve saving any
registers or FPU state and does not require selecting the next runnable task. VAS
switch is basically a system call that just changes the AS of the current thread
which makes it a very lightweight operation.

> Also, FWIW, I have patches (that need a little work) that will make
> switch_mm() waaaay faster on x86.

These patches will also improve the speed of the VAS switch operation. We are also
using the switch_mm function in the background to perform the actual hardware switch
between the two ASes. The main reason why the VAS switch is faster than the task
switch is that it just has to do fewer things.

> > At the current state of the development, first class virtual address spaces
> > have one limitation, that we haven't been able to solve so far. The feature
> > allows, that different threads of the same process can execute in different
> > AS at the same time. This is possible, because the VAS-switch operation
> > only changes the active mm_struct for the task_struct of the calling
> > thread. However, when a thread switches into a first class virtual address
> > space, some parts of its original AS are duplicated into the new one to
> > allow the thread to continue its execution at its current state.
> 
> Ick.  Please don't do this.  Can we please keep an mm as just an mm
> and not make it look magically different depending on which process
> maps it?  If you need a trampoline (which you do, of course), just
> write a trampoline in regular user code and map it manually.

Did I understand you correctly that you are proposing that the switching thread
should make sure by itself that its code, stack, … memory regions are properly setup
in the new AS before/after switching into it? I think, this would make using first
class virtual address spaces much more difficult for user applications to the extend
that I am not even sure if they can be used at all. At the moment, switching into a
VAS is a very simple operation for an application because the kernel will just simply
do the right thing.

Till
