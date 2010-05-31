Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 May 2010 12:56:09 +0200 (CEST)
Received: from pqueuea.post.tele.dk ([193.162.153.9]:49756 "EHLO
        pqueuea.post.tele.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491919Ab0EaK4F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 May 2010 12:56:05 +0200
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
        by pqueuea.post.tele.dk (Postfix) with ESMTP id 00A12DBB70;
        Mon, 31 May 2010 12:56:04 +0200 (CEST)
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
        by pfepb.post.tele.dk (Postfix) with ESMTP id E9A88F84058;
        Mon, 31 May 2010 12:55:50 +0200 (CEST)
Date:   Mon, 31 May 2010 12:55:50 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH 0/6] mips: diverse Makefile updates
Message-ID: <20100531105550.GA15995@merkur.ravnborg.org>
References: <20100530141939.GA22153@merkur.ravnborg.org> <20100530153939.GA22352@merkur.ravnborg.org> <20100530231954.GA318@linux-mips.org> <20100531102954.GA12669@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100531102954.GA12669@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Mon, May 31, 2010 at 11:29:54AM +0100, Ralf Baechle wrote:
> On Mon, May 31, 2010 at 12:19:54AM +0100, Ralf Baechle wrote:
> 
> > > > Note: I tried to test a little with bigsur_defconfig
> > > > but get_user() is buggy. Or at least my gcc thinks that
> > > > first argument may be used uninitialized.
> > > > I think mips needs to fix the 64 bit variant of get_user().
> > > > I took a quick look but ran away.
> > > 
> > > My gcc:
> > > mips-linux-gcc (GCC) 4.1.2
> > > Copyright (C) 2006 Free Software Foundation, Inc.
> 
> I played with it for a bit.  The warning is present in all gcc 4.1.0 to
> 4.1.2 and it is bogus.  When I first looked into this years ago I just
> gave up on gcc 4.1 as a newer version was already available.
> 
> The variable returned by get_user is undefined in case of an error, so
> what get_user() is doing is entirely legitimate.  This is different from
> copy_from_user() which in case of an error will clear the remainder of
> the destination area which couldn't not be copied from userspace.

What I looked at:

1)	u32 word;
2)	if (unlikely(get_user(word, header)))
3)		word = 0;
4)	if (word == magic.cmp)
5)		return PAGE_SIZE;

If gcc does not see an assignment to word in line 2) then
it complains about the use line 4).

If we look at the implementation of get_user it is more or less the
following:
({
	int err = -EFAULT;
	if (access_ok(VERIFY_READ, header))
		switch (sizeof(word)) {
		case 4:
			word = *(u32 *)header;
			err = 0;
			break;
		default:
			__get_user_unknown();
			break;
		}
	err;
})

Simplified a lot - I know. But it shows my point.
(And simplifying the code also helped me understand the macros).

gcc needs to be smart enough to deduce that we always return != 0
in the cases where word is not assigned - in which case line 3)
will do the assignment.

So gcc is indeed wrong when is sas "uninitialized" but considering
the complexity of these macros I think it is excused.

The x86 version has the following assignment

    (val) = (__typeof__(*(addr))) __gu_tmp; 

unconditionally - so they avoid the " = 0" thing.
sparc has explicit "= 0" assignments.

So refactoring the macros may do the trick too.
But I do not think it is worth the effort.

	Sam
