Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 17:12:13 +0100 (CET)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:60751 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006513AbcADQMHi1lFV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 17:12:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=5cmVXa6Fw5SeJ9x2CW3yGFzjMUnwhVS2N9PDGqW4tvg=;
        b=nI/xwnuorOat6jBLTEp2Ull/oh4AkTAQ2IwL5aZQama/ZqU1mqQWjBHbVeGhEifcgFhD8+qvGQ3IhoOTHcVkxMZpoHf6SfayXzx/MMJR62gWFby2GMnO/N714zWt4fhrv2W35+yL1Aiwpemee3jrPYG8RkPTFLi0hil7Jwgy3VU=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:37663)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1aG7jD-0001iN-Po; Mon, 04 Jan 2016 16:11:27 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1aG7jA-0001Yd-3M; Mon, 04 Jan 2016 16:11:24 +0000
Date:   Mon, 4 Jan 2016 16:11:23 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Joe Perches <joe@perches.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Cc : Andy Whitcroft" <apw@canonical.com>,
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
Subject: Re: [PATCH 1/3] checkpatch.pl: add missing memory barriers
Message-ID: <20160104161123.GJ19062@n2100.arm.linux.org.uk>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
 <1451907395-15978-2-git-send-email-mst@redhat.com>
 <1451923660.4334.83.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451923660.4334.83.camel@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50860
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

On Mon, Jan 04, 2016 at 08:07:40AM -0800, Joe Perches wrote:
> On Mon, 2016-01-04 at 13:36 +0200, Michael S. Tsirkin wrote:
> > +		my $all_barriers = join('|', (@barriers, @smp_barriers));
> > +
> > +		if ($line =~ /\b($all_barriers)\(/) {
> 
> It would be better to use /\b$all_barriers\s*\(/
> as there's no reason for the capture and there
> could be a space between the function and the
> open parenthesis.

I think you mean

	/\b(?:$all_barriers)\s*\(/

as 'all_barriers' will be:

	mb|wmb|rmb|smp_mb|smp_wmb|smp_rmb

and putting that into your suggestion results in:

	/\bmb|wmb|rmb|smp_mb|smp_wmb|smp_rmb\s*\(/

which is clearly wrong - the \b only applies to 'mb' and the \s*\( only
applies to smp_rmb.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
