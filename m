Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 19:04:40 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:58794 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011645AbcAZSEez5mXs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 19:04:34 +0100
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 706655A78D8;
        Tue, 26 Jan 2016 10:04:31 -0800 (PST)
Date:   Tue, 26 Jan 2016 10:04:28 -0800 (PST)
Message-Id: <20160126.100428.940114886943875601.davem@davemloft.net>
To:     sam@ravnborg.org
Cc:     luto@kernel.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, cmetcalf@ezchip.com,
        linux-parisc@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 02/16] sparc/compat: Provide an accurate
 in_compat_syscall implementation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20160126174441.GA18873@ravnborg.org>
References: <20160126062951.GA17107@ravnborg.org>
        <20160125.225100.1932707129794761764.davem@davemloft.net>
        <20160126174441.GA18873@ravnborg.org>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Jan 2016 10:04:31 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 26 Jan 2016 18:44:41 +0100

> On Mon, Jan 25, 2016 at 10:51:00PM -0800, David Miller wrote:
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Tue, 26 Jan 2016 07:29:51 +0100
>> 
>> > Could you please add a comment about where 0x110 comes from.
>> > I at least failed to track this down.
>> 
>> Frankly I'm fine with this.  Someone who understands sparc64 can look
>> at the trap table around entry 0x110 and see:
>> 
>> tl0_resv10e:	BTRAP(0x10e) BTRAP(0x10f)
>> tl0_linux32:	LINUX_32BIT_SYSCALL_TRAP
>> tl0_oldlinux64:	LINUX_64BIT_SYSCALL_TRAP
> 
> If one realise to look in the trap table in the first place - yes.
> 
> Adding a short:
> 
> /* Check if this is LINUX_32BIT_SYSCALL_TRAP */
> Would make wonders to readability.

Fair enough.
