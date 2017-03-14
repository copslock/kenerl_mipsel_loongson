Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 01:20:00 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:34141
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994627AbdCNATxkLZVY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 01:19:53 +0100
Received: by mail-qk0-x244.google.com with SMTP id v125so39074744qkh.1;
        Mon, 13 Mar 2017 17:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=taDSwUGEKnV9WIQK0x+I3Qu8Yor/n0NsygTJeyBmzYg=;
        b=fWU1TTuuLlBNpsAWp5voybxLgZmJLHivc1bB4+GJ8Y9Hm42bf49XBvBFgz0DQRehof
         uRGjdJdox554fgZbM3JUue4gLEf/Q/UXA2yPo3SmMSKhhtybpn0nYsG1dMkyBfT6CqOH
         NeoDZ1LfEC/SEyuUYTNDmIhOx0Lbl6s1p8etrkIUxS0VE7uVCfJ1eIQuefwaKEove5hP
         mTrkqLlsST5jHz1y+6c+srOC1JTi1LqDoFiMqwQ8S4AepvQ7ANygxnsr/7hW7lFjE46J
         p1OO+CyLBMlJ91uxzaLFA5jmAsn69we5+hXQqpzOUU9nNbiuqqKN8mbWY8C1NebID3lN
         92kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=taDSwUGEKnV9WIQK0x+I3Qu8Yor/n0NsygTJeyBmzYg=;
        b=ELrTzxT0NXl0r7aY60QLm805Y3dK8ff+Kc6k9rnbXT08wv0rTpf9ZALZYsOZyPui84
         dyFzYWNlZLW8iPzfvLDGj7o9Y7Kf5zK1lPtnOwqWl0L+TH+rNGQHwKvLFLQLBqsS3X/P
         /+gjeMTn/RAhgScRSvdpySThHIyayqlh34mmmfi8O5RVJo+w81x3JDT16ojxWpe1HABu
         Bjgr8sIb+Kryc8nafs/OOB8ll1GfDnOZtY59/q7R95YhXA+QMcFSYGwabpfOKGZrb1kF
         bk91+HpBfIrCofFVQrrIpjir/km9kOnKk7mBXPHAl2fzk/0Fu0J/MA60vp6IXc6ozaax
         M05Q==
X-Gm-Message-State: AMke39nquc/c40Bzi9nxn4Qq/bMqESKM4By+Q8tyB0IkKf54sr9Jg7IdV8fK4D5ginRL3w==
X-Received: by 10.233.221.2 with SMTP id r2mr35202552qkf.159.1489450787837;
        Mon, 13 Mar 2017 17:19:47 -0700 (PDT)
Received: from bigtime.twiddle.net ([220.240.225.200])
        by smtp.googlemail.com with ESMTPSA id q40sm13338555qtq.21.2017.03.13.17.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 17:19:47 -0700 (PDT)
Subject: Re: [RFC PATCH 00/13] Introduce first class virtual address spaces
To:     Till Smejkal <till.smejkal@googlemail.com>,
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
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20170313221415.9375-1-till.smejkal@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
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
From:   Richard Henderson <rth@twiddle.net>
Message-ID: <73f62aca-d442-9e4b-3e2c-6269e2632e68@twiddle.net>
Date:   Tue, 14 Mar 2017 10:18:56 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170313221415.9375-1-till.smejkal@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <rth7680@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@twiddle.net
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

On 03/14/2017 08:14 AM, Till Smejkal wrote:
> At the current state of the development, first class virtual address spaces
> have one limitation, that we haven't been able to solve so far. The feature
> allows, that different threads of the same process can execute in different
> AS at the same time. This is possible, because the VAS-switch operation
> only changes the active mm_struct for the task_struct of the calling
> thread. However, when a thread switches into a first class virtual address
> space, some parts of its original AS are duplicated into the new one to
> allow the thread to continue its execution at its current state.
> Accordingly, parts of the processes AS (e.g. the code section, data
> section, heap section and stack sections) exist in multiple AS if the
> process has a VAS attached to it. Changes to these shared memory regions
> are synchronized between the address spaces whenever a thread switches
> between two of them. Unfortunately, in some scenarios the kernel is not
> able to properly synchronize all these shared memory regions because of
> conflicting changes. One such example happens if there are two threads, one
> executing in an attached first class virtual address space, the other in
> the tasks original address space. If both threads make changes to the heap
> section that cause expansion of the underlying vm_area_struct, the kernel
> cannot correctly synchronize these changes, because that would cause parts
> of the virtual address space to be overwritten with unrelated data. In the
> current implementation such conflicts are only detected but not resolved
> and result in an error code being returned by the kernel during the VAS
> switch operation. Unfortunately, that means for the particular thread that
> tried to make the switch, that it cannot do this anymore in the future and
> accordingly has to be killed.

This sounds like a fairly fundamental problem to me.

Is this an indication that full virtual address spaces are useless?  It would 
seem like if you only use virtual address segments then you avoid all of the 
problems with executing code, active stacks, and brk.


r~
