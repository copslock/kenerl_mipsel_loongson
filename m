Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2017 17:20:26 +0100 (CET)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:55566
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993950AbdAMQUTEz4Si (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jan 2017 17:20:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=dH2voTm+gO6KRQro838IzHxs/0jd4Gc+XsxY9OcBZqM=;
        b=HpmyBCSxhVpORHBRpqWZ6DdjdeE89ClwzyICrrbO4RbM1TwkXPdtVkzF+CEicUp70TqwVUeOzUW4R2eLEarfgwApdOZNwgK0UKyABzzs7eQVJs+Ktou0HXZSc4rbMglsFOVzX4L82CjLVxWJBUgQIS9OzzvJ4Hb72k9L2OwUm68=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:36064)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@armlinux.org.uk>)
        id 1cS4a4-0006uM-D2; Fri, 13 Jan 2017 16:19:56 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1cS4a0-0002ky-FD; Fri, 13 Jan 2017 16:19:52 +0000
Date:   Fri, 13 Jan 2017 16:19:52 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     David Howells <dhowells@redhat.com>, arnd@arndb.de,
        linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-mtd@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-am33-list@redhat.com, linux-c6x-dev@linux-c6x.org,
        linux-rdma@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-sh@vger.kernel.org, coreteam@netfilter.org,
        fcoe-devel@open-fcoe.org, xen-devel@lists.xenproject.org,
        linux-snps-arc@lists.infradead.org, linux-media@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, linux-kbuild@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-raid@vger.kernel.org, openrisc@lists.librecores.org,
        linux-fbdev@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-alpha@vger.kernel.org, nio2-dev@lists.rocketboards.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/8] arm: put types.h in uapi
Message-ID: <20170113161951.GT14217@n2100.armlinux.org.uk>
References: <1484304406-10820-2-git-send-email-nicolas.dichtel@6wind.com>
 <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <25063.1484321803@warthog.procyon.org.uk>
 <4633e475-47f2-5627-81a9-a1747dfddbc0@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4633e475-47f2-5627-81a9-a1747dfddbc0@6wind.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@armlinux.org.uk
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

On Fri, Jan 13, 2017 at 05:01:01PM +0100, Nicolas Dichtel wrote:
> Please, do not remove the email subject when you reply. I restore it to
> ease the thread follow-up.

I mentioned it to David, and he says it's because the long list of
recipients is breaking his mailer.  I've already posed the question
about whether that's exploitable!

> Le 13/01/2017 à 16:36, David Howells a écrit :
> > Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> > 
> >> This header file is exported, thus move it to uapi.
> > 
> > Exported how?
> 
> It is listed in include/uapi/asm-generic/Kbuild.asm, which is included by
> arch/arm/include/uapi/asm/Kbuild.

We really should not be installing non-uapi header files to userland
under _any_ circumstance - this to me sounds like a bug in kbuild.

The assumption is that headers outside of uapi directories are not
part of the user visible API, and so can be freely modified - which
in the presence of this bug is untrue.

However, as it's happening, and this header has been there since 2013
(commit 09096f6a0ee2 - "ARM: 7822/1: add workaround for ambiguous C99
stdint.h types") it's now well and truely part of the user API whether
we intended it to be or not, so your patch looks to me like the correct
thing to do.

I think it needs further evaluation to make sure kbuild isn't going to
do something else silly, like subsitute include/asm-generic/types.h for
the now missing arch/arm/include/asm/types.h

I wonder how many more headers are unintentionally exported.

... what a mess. :(

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
