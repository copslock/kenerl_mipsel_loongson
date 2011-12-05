Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2011 01:15:45 +0100 (CET)
Received: from terminus.zytor.com ([198.137.202.10]:49777 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903650Ab1LEAPh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Dec 2011 01:15:37 +0100
Received: from tazenda.hos.anvin.org ([IPv6:2001:470:861f::feed:face:f00d])
        (authenticated bits=0)
        by mail.zytor.com (8.14.5/8.14.5) with ESMTP id pB50EIGm007983
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=OK);
        Sun, 4 Dec 2011 16:14:19 -0800
Message-ID: <4EDC0CD5.2090601@zytor.com>
Date:   Sun, 04 Dec 2011 16:14:13 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111115 Thunderbird/8.0
MIME-Version: 1.0
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Sven Eckelmann <sven@narfation.org>,
        linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Randy Dunlap <rdunlap@xenotime.net>,
        Paul Mackerras <paulus@samba.org>,
        Helge Deller <deller@gmx.de>, sparclinux@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>,
        Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergma nn <arnd@arndb.de>,
        Jeff Dike <jdike@addtoit.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        linux-m32r@ml.linux-m32r.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
        b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCHv5] atomic: add *_dec_not_zero
References: <1323013369-29691-1-git-send-email-sven@narfation.org>  <20111204213316.GB14542@n2100.arm.linux.org.uk>  <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>  <20111204221850.GC14542@n2100.arm.linux.org.uk> <1323038515.11728.26.camel@pasglop>
In-Reply-To: <1323038515.11728.26.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 32027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2789

On 12/04/2011 02:41 PM, Benjamin Herrenschmidt wrote:
> 
> I agree with Russell, his approach is a lot easier to maintain long run,
> we should even consider converting existing definitions.
> 

Thirded.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
