Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 22:14:45 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:35926
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991129AbdCNVOgkQYIP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 22:14:36 +0100
Received: by mail-wr0-x244.google.com with SMTP id l37so25352121wrc.3;
        Tue, 14 Mar 2017 14:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JafwRDcxtOSTwUrOJIR9EQWOJzc7PxCMBJ3odtqpSl0=;
        b=RfS3kbOuxCUbirZFYxoIaVis23qjTJu4sIFjSlRZ4KYaq+HJs3KHq3j/k3L569PmZO
         naPb4+29q91U+wP9s+v0dxrIAUK2nbh+dOsqLFzRE2kNctBWg0x0QqrqdUfkeDQ9tcrN
         eluP2cD5tfjzQ+VVUAYS1eiTNwyYuZIXg4atPlHdDBrpCSo09GJV0vtj8LrmyfbVlx+w
         bB806MuC7ec0tS7QQr/fvlco8kLvpgaPwj4P1UHcCikrB8ZMPVzY5EuI6njx0c2davRz
         N2ur1dsjM4n7oC3Q21+x0qJW7ESvS3U2d06OCSaK1uEtPWn/yXMTTJ2D04/3QQbv6tXs
         DRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=JafwRDcxtOSTwUrOJIR9EQWOJzc7PxCMBJ3odtqpSl0=;
        b=niFo3fBuSMlp/+ThPro79zJIjl68hrUwXxVAPCF7vd2J0tdosLBQrz6Ks8IN1SMLq3
         QKCX+G4oTKD1NoBqXLocYdCURaZq208lCTeg2hJXCjJISEfK690Ciwj/+xGD1Hyk3ueK
         gPee50trIasixqGY62ZGWIaZ1y6AZtteiiQD2snPMR63+dnK7hYly94P13YWQryQQi40
         qHGVm31HQt9D2DD6oDXtaonfYXrv1tRr6UFYryUj2nHZkGWA1RzHRtOoC5x1U96YmjOF
         EJycPs3riXRK23ie8DUg5rBK80XxmW+zmD5Xi4ATwOpMWSuzKnLVBoBHiJHbcDQLU1Vc
         FdhQ==
X-Gm-Message-State: AMke39mX8sL5L+5YEgeOmNxo3p32sbII9iVyqJret2MvsD0sLGfgI7AeiByxxe7HIMxDrg==
X-Received: by 10.223.162.205 with SMTP id t13mr37545937wra.155.1489526071261;
        Tue, 14 Mar 2017 14:14:31 -0700 (PDT)
Received: from localhost (login1.zih.tu-dresden.de. [141.76.16.140])
        by smtp.googlemail.com with ESMTPSA id c9sm1232473wmf.18.2017.03.14.14.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Mar 2017 14:14:30 -0700 (PDT)
From:   Till Smejkal <till.smejkal@googlemail.com>
X-Google-Original-From: Till Smejkal <till.smejkal@gmail.com>
Date:   Tue, 14 Mar 2017 14:14:27 -0700
To:     Chris Metcalf <cmetcalf@mellanox.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Till Smejkal <till.smejkal@googlemail.com>,
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
Message-ID: <20170314211427.7wxdyrholi3mgle5@arch-dev>
Mail-Followup-To: Chris Metcalf <cmetcalf@mellanox.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d9333d6-2f81-a9de-484e-e1d655e1d3c3@mellanox.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Return-Path: <till.smejkal@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57261
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

On Tue, 14 Mar 2017, Chris Metcalf wrote:
> On 3/14/2017 12:12 PM, Till Smejkal wrote:
> > On Mon, 13 Mar 2017, Andy Lutomirski wrote:
> > > On Mon, Mar 13, 2017 at 7:07 PM, Till Smejkal
> > > <till.smejkal@googlemail.com> wrote:
> > > > On Mon, 13 Mar 2017, Andy Lutomirski wrote:
> > > > > This sounds rather complicated.  Getting TLB flushing right seems
> > > > > tricky.  Why not just map the same thing into multiple mms?
> > > > This is exactly what happens at the end. The memory region that is described by the
> > > > VAS segment will be mapped in the ASes that use the segment.
> > > So why is this kernel feature better than just doing MAP_SHARED
> > > manually in userspace?
> > One advantage of VAS segments is that they can be globally queried by user programs
> > which means that VAS segments can be shared by applications that not necessarily have
> > to be related. If I am not mistaken, MAP_SHARED of pure in memory data will only work
> > if the tasks that share the memory region are related (aka. have a common parent that
> > initialized the shared mapping). Otherwise, the shared mapping have to be backed by a
> > file.
> 
> True, but why is this bad?  The shared mapping will be memory resident
> regardless, even if backed by a file (unless swapped out under heavy
> memory pressure, but arguably that's a feature anyway).  More importantly,
> having a file name is a simple and consistent way of identifying such
> shared memory segments.
> 
> With a little work, you can also arrange to map such files into memory
> at a fixed address in all participating processes, thus making internal
> pointers work correctly.

I don't want to say that the interface provided by MAP_SHARED is bad. I am only
arguing that VAS segments and the interface that they provide have an advantage over
the existing ones in my opinion. However, Matthew Wilcox also suggested in some
earlier mail that VAS segments could be exported to user space via a special purpose
filesystem. This would enable users of VAS segments to also just use some special
files to setup the shared memory regions. But since the VAS segment itself already
knows where at has to be mapped in the virtual address space of the process, the
establishing of the shared memory region would be very easy for the user.

> > VAS segments on the other side allow sharing of pure in memory data by
> > arbitrary related tasks without the need of a file. This becomes especially
> > interesting if one combines VAS segments with non-volatile memory since one can keep
> > data structures in the NVM and still be able to share them between multiple tasks.
> 
> I am not fully up to speed on NV/pmem stuff, but isn't that exactly what
> the DAX mode is supposed to allow you to do?  If so, isn't sharing a
> mapped file on a DAX filesystem on top of pmem equivalent to what
> you're proposing?

If I read the documentation to DAX filesystems correctly, it is indeed possible to us
them to create files that life purely in NVM. I wasn't fully aware of this feature.
Thanks for the pointer.

However, the main contribution of this patchset is actually the idea of first class
virtual address spaces and that they can be used to allow processes to have multiple
different views on the system's main memory. For us, VAS segments were another logic
step in the same direction (from first class virtual address spaces to first class
address space segments). However, if there is already functionality in the Linux
kernel to achieve the exact same behavior, there is no real need to add VAS segments.
I will continue thinking about them and either find a different situation where the
currently available interface is not sufficient/too complicated or drop VAS segments
from future version of the patch set.

Till
