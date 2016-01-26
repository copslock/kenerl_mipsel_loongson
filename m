Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 18:44:51 +0100 (CET)
Received: from asavdk4.altibox.net ([109.247.116.15]:45410 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011634AbcAZRou3BO8s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 18:44:50 +0100
Received: from ravnborg.org (unknown [188.228.89.252])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 8ACBA802DE;
        Tue, 26 Jan 2016 18:44:43 +0100 (CET)
Date:   Tue, 26 Jan 2016 18:44:41 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     David Miller <davem@davemloft.net>
Cc:     luto@kernel.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, cmetcalf@ezchip.com,
        linux-parisc@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 02/16] sparc/compat: Provide an accurate
 in_compat_syscall implementation
Message-ID: <20160126174441.GA18873@ravnborg.org>
References: <cover.1453759363.git.luto@kernel.org>
 <e520030f750b29d14486aa1e99c271a0fa18f19e.1453759363.git.luto@kernel.org>
 <20160126062951.GA17107@ravnborg.org>
 <20160125.225100.1932707129794761764.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160125.225100.1932707129794761764.davem@davemloft.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.1 cv=OIGHpXuB c=1 sm=1 tr=0
        a=Ij76tQDYWdb01v2+RnYW5w==:117 a=Ij76tQDYWdb01v2+RnYW5w==:17
        a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
        a=7gkXJVJtAAAA:8 a=5QF_Gm3nSdwT_-_sU7YA:9 a=CjuIK1q_8ugA:10
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
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

On Mon, Jan 25, 2016 at 10:51:00PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 26 Jan 2016 07:29:51 +0100
> 
> > Could you please add a comment about where 0x110 comes from.
> > I at least failed to track this down.
> 
> Frankly I'm fine with this.  Someone who understands sparc64 can look
> at the trap table around entry 0x110 and see:
> 
> tl0_resv10e:	BTRAP(0x10e) BTRAP(0x10f)
> tl0_linux32:	LINUX_32BIT_SYSCALL_TRAP
> tl0_oldlinux64:	LINUX_64BIT_SYSCALL_TRAP

If one realise to look in the trap table in the first place - yes.

Adding a short:

/* Check if this is LINUX_32BIT_SYSCALL_TRAP */
Would make wonders to readability.

	Sam
