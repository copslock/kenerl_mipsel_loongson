Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Nov 2006 13:50:16 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:47281 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038555AbWKJNuO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Nov 2006 13:50:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kAADof1a017482;
	Fri, 10 Nov 2006 13:50:41 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kAADoetw017481;
	Fri, 10 Nov 2006 13:50:40 GMT
Date:	Fri, 10 Nov 2006 13:50:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Sync operation in atomic_add_return()
Message-ID: <20061110135040.GB10119@linux-mips.org>
References: <66910A579C9312469A7DF9ADB54A8B7D44D837@exchange.ZeugmaSystems.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66910A579C9312469A7DF9ADB54A8B7D44D837@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 06, 2006 at 10:17:53AM -0800, Kaz Kylheku wrote:

> > Hi,
> > I am trying to figure out why there is a sync operation in
> > linux/include/asm-mips/atomic.h:atomic_add_return(). 
> > I believe it was added in the linux-2.4.19 patch, but can't trace the
> > reason. Can anyone help?
> 
> Is it just unwarranted paranoia? There does not appear to be a need for
> the sync within the atomic_add_return code itself.

atomic_*_return() are used as synchronization points so must imply a
memory barrier on MP.

> But it might be that the code which calls this function needs the sync.
> 
> Without looking at any code whatsoever, here is a general hypothesis.
> 
> In what situation might you /care/ about the return value of an atomic
> add?
> 
> Suppose atomic increments and decrements are being used for reference
> counting. If you know that you hold the reference to an object, you can
> call atomic_add to increase the reference count without caring about the
> return value, and no sync is needed in that situation.

For example the networking code does basically:

static inline void sock_put(struct sock *sk)
{
	if (atomic_add_and_test(-11, &sk->sk_refcnt) == 0)
		sk_free(sk);
}

> Suppose, however, that atomic_add is used to pick up a reference.
> Suppose you have a pool of ``dead'' objects with reference counts of
> zero, and want to recycle an object from such a pool. You might use
> atomic_add_return to examine the reference counts of the objects in this
> pool one by one until you get a 1 return. You might get something other
> than a 1 return if racing against another processor which is tryiing to
> pick up the same object.
> 
> In this situation, if you successfully get the object, you do want to do
> a sync, since the object is being handed off between two processors.
> Before the object was put into the pool, its fields were updated, since
> it was being cleaned up. You would not want the new owner, by chance, to
> observe stale values of those fields.
> 
> I.e., to put it briefly, atomic_add_return can have "acquire" semantics.

Correct - and depending on its use it may also have release semantics.
This applies to all atomic_*_return() functions not just atomic_add_return.

  Ralf
