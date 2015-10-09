Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Oct 2015 01:48:33 +0200 (CEST)
Received: from unicorn.mansr.com ([81.2.72.234]:50753 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010051AbbJIXs3YiA0W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Oct 2015 01:48:29 +0200
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 2B58C1538A; Sat, 10 Oct 2015 00:48:22 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-cris-kernel@axis.com,
        linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org,
        kernel@stlinux.com, linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] sched_clock: add data pointer argument to read callback
References: <1444427858-576-1-git-send-email-mans@mansr.com>
        <20151009232015.GC32536@n2100.arm.linux.org.uk>
Date:   Sat, 10 Oct 2015 00:48:22 +0100
In-Reply-To: <20151009232015.GC32536@n2100.arm.linux.org.uk> (Russell King's
        message of "Sat, 10 Oct 2015 00:20:15 +0100")
Message-ID: <yw1x4mhzioxl.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, Oct 09, 2015 at 10:57:35PM +0100, Mans Rullgard wrote:
>> This passes a data pointer specified in the sched_clock_register()
>> call to the read callback allowing simpler implementations thereof.
>> 
>> In this patch, existing uses of this interface are simply updated
>> with a null pointer.
>
> This is a bad description.  It tells us what the patch is doing,
> (which we can see by reading the patch) but not _why_.  Please include
> information on why the change is necessary - describe what you are
> trying to achieve.

Currently most of the callbacks use a global variable to store the
address of a counter register.  This has several downsides:

- Loading the address of a global variable can be more expensive than
  keeping a pointer next to the function pointer.

- It makes it impossible to have multiple instances of a driver call
  sched_clock_register() since the caller can't know which clock will
  win in the end.

- Many of the existing callbacks are practically identical and could be
  replaced with a common generic function if it had a pointer argument.

If I've missed something that makes this a stupid idea, please tell.

-- 
Måns Rullgård
mans@mansr.com
