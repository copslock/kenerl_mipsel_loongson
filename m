Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 11:50:21 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:40598 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011315AbbHFJuURw9-U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 11:50:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=9cfcp3i06WxSzxr40UfN6GR8nDps0OLZb3kLSYpp8cQ=;
        b=MvZltvnLefCsmoe/3E4ryo5+hg0l1jr72fxeje8mCaTygxktXbusPkBFD7F1ELrk5fVeOQUNjrzanYLyV3G7wDQb+xJkZx9T1xhn491avvb7neBBjZaKk8kvTrE6BwPszzwYSGfGOK7ERhuM4EuwGxtVdttX/aSVXRwARZ4Z3g4=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32933 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1ZNHoS-000P8D-UY; Thu, 06 Aug 2015 09:50:13 +0000
Date:   Thu, 6 Aug 2015 02:50:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/7] test_user_copy improvements
Message-ID: <20150806095009.GA8498@roeck-us.net>
References: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Hi James,

On Wed, Aug 05, 2015 at 04:48:48PM +0100, James Hogan wrote:
> These patches extend the test_user_copy test module to handle lots more
> cases of user accessors which architectures can override separately, and
> in particular those which are important for checking the MIPS Enhanced
> Virtual Addressing (EVA) implementations, which need to handle
> overlapping user and kernel address spaces, with special instructions
> for accessing user address space from kernel mode.
> 
> - Checking that kernel pointers are accepted when user address limit is
>   set to KERNEL_DS, as done by the kernel when it internally invokes
>   system calls with kernel pointers.
> - Checking of the unchecked accessors (which don't call access_ok()).
>   Some of the tests are special cased for EVA at the moment which has
>   stricter hardware guarantees for bad user accesses than other
>   configurations.
> - Checking of other sets of user accessors, including the inatomic user
>   copies, copy_in_user, clear_user, the user string accessors, and the
>   user checksum functions, all of which need special handling in arch
>   code with EVA.
> 
> Tested on MIPS with and without EVA, and on x86_64.
> 
The series causes several build failures with other architectures.

From next-20150806:

Build results:
	total: 152 pass: 138 fail: 14
Failed builds:
	alpha:allmodconfig (*)
	arm:allmodconfig (*)
	arm:omap2plus_defconfig
	arm64:allmodconfig
	i386:allyesconfig (*)
	i386:allmodconfig (*)
	m68k:defconfig (*)
	m68k:allmodconfig (*)
	m68k:sun3_defconfig (*)
	mips:allmodconfig
	parisc:allmodconfig
	s390:allmodconfig
	sparc32:allmodconfig (*)
	xtensa:allmodconfig (*)

The builds marked with (*) fail because of your patch series.

Guenter
