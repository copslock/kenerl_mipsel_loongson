Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 20:53:10 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:52950 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493567Ab1AQTxH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jan 2011 20:53:07 +0100
Received: by wyf22 with SMTP id 22so5262476wyf.36
        for <multiple recipients>; Mon, 17 Jan 2011 11:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=5gjEMzLF49GhTXSXM2nFfsxYWMc67ZfwJvIlZWRRRa8=;
        b=mGwPOZf6JusvIl/m61lz+VK70XLpGvKVBEJzFlYJw3mrNSJgTsRNjarmtEOajyyEKL
         44NIiapQygjOYcUqKuy72flA1AySTajCvP2sX0Vr+DKFmTIR4ZnO4qB/our3S5b57kmN
         MIyg/m3Qi9BI4XmCtntW950gMMN6t7HGfC/Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=AQ8DMfudSDFN5xZ9ZvPibXo4FBPMHacy17FktUCKgtpaj7T9ksG5QsHkJ7mlhEX0bo
         pZ7Ex1djS64niqpux2kcZ8065CtYh1Q2jrX6nNFTAgG8EHRJpfIY0ZkZPKOavRKvMGj2
         hiAcsTTv0Ce+hZZssJczOgITFd6kY2XH64wXM=
Received: by 10.216.162.70 with SMTP id x48mr305495wek.4.1295293830719; Mon,
 17 Jan 2011 11:50:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.216.3.10 with HTTP; Mon, 17 Jan 2011 11:49:40 -0800 (PST)
In-Reply-To: <1295262433.30950.53.camel@laptop>
References: <1295262433.30950.53.camel@laptop>
From:   Mike Frysinger <vapier@gentoo.org>
Date:   Mon, 17 Jan 2011 14:49:40 -0500
X-Google-Sender-Auth: eCL-FWyfVL6C8SbOp7p082cX3zY
Message-ID: <AANLkTik3hE=_34Lbs944MzKpkNzqY+kCxpxmncUM2HB7@mail.gmail.com>
Subject: Re: [uclinux-dist-devel] [PATCH] sched: provide scheduler_ipi()
 callback in response to smp_send_reschedule()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Hirokazu Takata <takata@linux-m32r.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <vapier.adi@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier@gentoo.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 17, 2011 at 06:07, Peter Zijlstra wrote:
> Also, while reading through all this, I noticed the blackfin SMP code
> looks to be broken, it simply discards any IPI when low on memory.

not really.  see changelog of commit 73a400646b8e26615f3ef1a0a4bc0cd0d5bd284c.
-mike
