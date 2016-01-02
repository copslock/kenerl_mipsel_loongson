Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jan 2016 12:21:06 +0100 (CET)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:56499 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008444AbcABLVD4AMDK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Jan 2016 12:21:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=GgXmZAJDhPYwuy6nYQTT9F7JtMCo7eMUafXLol0zsIU=;
        b=OOHezgD0IfeKGa2PQ/cRF7zE6DhlwY7Cp1+Ncwc2oR+516EKPuP4YtuxGqtcsLVX7Tx8630hjHLO/uFil5ZWik4FnlKMxkV34gz6ZaWaFYGhBU7UDBR9bqIxg/jdrsikbFv63qo6at/yrEyJTydNJe0lRkbDlREaQJxRwGt4D3o=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:33322)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1aFKEL-0000BH-6Z; Sat, 02 Jan 2016 11:20:17 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1aFKEH-0008Tl-5Y; Sat, 02 Jan 2016 11:20:13 +0000
Date:   Sat, 2 Jan 2016 11:20:12 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 08/32] arm: reuse asm-generic/barrier.h
Message-ID: <20160102112011.GT8644@n2100.arm.linux.org.uk>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-9-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451572003-2440-9-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50816
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

On Thu, Dec 31, 2015 at 09:06:46PM +0200, Michael S. Tsirkin wrote:
> On arm smp_store_mb, read_barrier_depends, smp_read_barrier_depends,
> smp_store_release, smp_load_acquire, smp_mb__before_atomic and
> smp_mb__after_atomic match the asm-generic variants exactly. Drop the
> local definitions and pull in asm-generic/barrier.h instead.
> 
> This is in preparation to refactoring this code area.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks, the asm-generic versions looks identical to me, so this should
result in no code generation difference.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
