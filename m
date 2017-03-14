Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 01:39:50 +0100 (CET)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:34538
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994631AbdCNAjoB4bQc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 01:39:44 +0100
Received: by mail-wr0-x241.google.com with SMTP id u48so22093957wrc.1;
        Mon, 13 Mar 2017 17:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kX6sEnfv8YQCir28cNWirD6F6mMiV4RXj8z30zPf8Ak=;
        b=PjtY74ZQsZ14g6IdKY36EUKX7qoBc5xXUCuNRxfCslG9p0o5QccUpygxJQLqjvd2m0
         32EWQjGRgq3zYWygIPGt3VTCP/lgfVYd9drRmePhM8HWFK4NP4q4z2/KMCaiULsqMZ1D
         eVejey3iP8JnKPjl4aXaIKjjIGmCSHKigcT9k6qyipsUUXPN7McrNtM1kaP0jp2Ky9PN
         X27By7qrbs6ZKA+kFTMGNtKbFHoAAmGe4Hge9WMMMNm94vBI7ikAHgTahWjBFfIg0TxL
         p4A0bes2GEuNKhcmPtCRP78w7tr56Eesl6j+3Vt/QqxVO0M6i+0pzWNsREuV13bw3wrF
         Tfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=kX6sEnfv8YQCir28cNWirD6F6mMiV4RXj8z30zPf8Ak=;
        b=obpE5z8YTdd2+0olRvgpp5ylfjzd/FWvHm72i1zbaeRE+y/OBYF4WvFJFFcH2nIk0v
         RIwPQ6AyZd/NLNA+Aq5UjJWMhKn7ADvDhIybb3/7vI0kdZmMavYINnc+SlBrwl9eC95y
         WdzM5iW/hNz9E8lajIlwUBDsAmMPOJC6/CKHOFD9pyiKqUJqlEBRQvRgDwYQyieRM9SQ
         u1Y59RpeoLhhWRIrvtuG6hZcA0YoXBPxdB3/PR2zXqb23TMqemsNe/ESzuEpbEqaSjKH
         zs9g/gwbAqOju6IxG7TKeVMidoXUUu+VwfaPxygfoTeANPllAkwwQx+qdGnwUvxILYk/
         GZ5w==
X-Gm-Message-State: AMke39nQbXXQ+43OUvYMnbmAVxm03XVLz18RS/QGGDcHAVnBCbgMvCDiRMJ8kd9OnqbsTA==
X-Received: by 10.223.129.230 with SMTP id 93mr29692349wra.41.1489451978728;
        Mon, 13 Mar 2017 17:39:38 -0700 (PDT)
Received: from localhost (login1.zih.tu-dresden.de. [141.76.16.140])
        by smtp.googlemail.com with ESMTPSA id k195sm13288084wmd.7.2017.03.13.17.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Mar 2017 17:39:37 -0700 (PDT)
From:   Till Smejkal <till.smejkal@googlemail.com>
X-Google-Original-From: Till Smejkal <till.smejkal@gmail.com>
Date:   Mon, 13 Mar 2017 17:39:35 -0700
To:     Richard Henderson <rth@twiddle.net>
Cc:     Till Smejkal <till.smejkal@googlemail.com>,
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
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
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
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
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
        linux-arch@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [RFC PATCH 00/13] Introduce first class virtual address spaces
Message-ID: <20170314003935.2jwycgajo7eojmvm@arch-dev>
Mail-Followup-To: Richard Henderson <rth@twiddle.net>,
        Till Smejkal <till.smejkal@googlemail.com>,
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
        x86@kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
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
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
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
        linux-arch@vger.kernel.org, alsa-devel@alsa-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73f62aca-d442-9e4b-3e2c-6269e2632e68@twiddle.net>
User-Agent: NeoMutt/20170306 (1.8.0)
Return-Path: <till.smejkal@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57188
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

On Tue, 14 Mar 2017, Richard Henderson wrote:
> On 03/14/2017 08:14 AM, Till Smejkal wrote:
> > At the current state of the development, first class virtual address spaces
> > have one limitation, that we haven't been able to solve so far. The feature
> > allows, that different threads of the same process can execute in different
> > AS at the same time. This is possible, because the VAS-switch operation
> > only changes the active mm_struct for the task_struct of the calling
> > thread. However, when a thread switches into a first class virtual address
> > space, some parts of its original AS are duplicated into the new one to
> > allow the thread to continue its execution at its current state.
> > Accordingly, parts of the processes AS (e.g. the code section, data
> > section, heap section and stack sections) exist in multiple AS if the
> > process has a VAS attached to it. Changes to these shared memory regions
> > are synchronized between the address spaces whenever a thread switches
> > between two of them. Unfortunately, in some scenarios the kernel is not
> > able to properly synchronize all these shared memory regions because of
> > conflicting changes. One such example happens if there are two threads, one
> > executing in an attached first class virtual address space, the other in
> > the tasks original address space. If both threads make changes to the heap
> > section that cause expansion of the underlying vm_area_struct, the kernel
> > cannot correctly synchronize these changes, because that would cause parts
> > of the virtual address space to be overwritten with unrelated data. In the
> > current implementation such conflicts are only detected but not resolved
> > and result in an error code being returned by the kernel during the VAS
> > switch operation. Unfortunately, that means for the particular thread that
> > tried to make the switch, that it cannot do this anymore in the future and
> > accordingly has to be killed.
> 
> This sounds like a fairly fundamental problem to me.

Yes I agree. This is a significant limitation of first class virtual address spaces.
However, conflict like this can be mitigated by being careful in the application
that uses multiple first class virtual address spaces. If all threads make sure that
they never resize shared memory regions when executing inside a VAS such conflicts do
not occur. Another possibility that I investigated but not yet finished is that such
resizes of shared memory regions have to be synchronized more frequently than just at
every switch between VASes. If one for example "forward" memory region resizes to all
AS that share this particular memory region during the resize operation, one can
completely eliminate this problem. Unfortunately, this introduces a significant cost
and introduces a difficult to handle race condition.

> Is this an indication that full virtual address spaces are useless?  It
> would seem like if you only use virtual address segments then you avoid all
> of the problems with executing code, active stacks, and brk.

What do you mean with *virtual address segments*? The nice part of first class
virtual address spaces is that one can share/reuse collections of address space
segments easily.

Till
