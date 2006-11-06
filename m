Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Nov 2006 18:18:09 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:23690 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20038545AbWKFSSC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Nov 2006 18:18:02 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Sync operation in atomic_add_return()
Date:	Mon, 6 Nov 2006 10:17:53 -0800
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D44D837@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Sync operation in atomic_add_return()
Thread-Index: AccBscqczM/yLc/WQ56lzFz+PK98AwAHKqog
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Gideon Stupp wrote:
> Hi,
> I am trying to figure out why there is a sync operation in
> linux/include/asm-mips/atomic.h:atomic_add_return(). 
> I believe it was added in the linux-2.4.19 patch, but can't trace the
> reason. Can anyone help?

Is it just unwarranted paranoia? There does not appear to be a need for
the sync within the atomic_add_return code itself.

But it might be that the code which calls this function needs the sync.

Without looking at any code whatsoever, here is a general hypothesis.

In what situation might you /care/ about the return value of an atomic
add?

Suppose atomic increments and decrements are being used for reference
counting. If you know that you hold the reference to an object, you can
call atomic_add to increase the reference count without caring about the
return value, and no sync is needed in that situation.

Suppose, however, that atomic_add is used to pick up a reference.
Suppose you have a pool of ``dead'' objects with reference counts of
zero, and want to recycle an object from such a pool. You might use
atomic_add_return to examine the reference counts of the objects in this
pool one by one until you get a 1 return. You might get something other
than a 1 return if racing against another processor which is tryiing to
pick up the same object.

In this situation, if you successfully get the object, you do want to do
a sync, since the object is being handed off between two processors.
Before the object was put into the pool, its fields were updated, since
it was being cleaned up. You would not want the new owner, by chance, to
observe stale values of those fields.

I.e., to put it briefly, atomic_add_return can have "acquire" semantics.
