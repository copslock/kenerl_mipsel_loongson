Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jun 2009 05:43:44 +0200 (CEST)
Received: from smtp.zeugmasystems.com ([70.79.96.174]:23105 "EHLO
	zeugmasystems.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S1491820AbZFYDni convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Jun 2009 05:43:38 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Silly 100% CPU behavior on a SIG_IGN-ored SIGBUS.
Date:	Wed, 24 Jun 2009 20:39:51 -0700
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C501C35457@exchange.ZeugmaSystems.local>
In-Reply-To: <4A415121.1040602@caviumnetworks.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Silly 100% CPU behavior on a SIG_IGN-ored SIGBUS.
Thread-Index: Acn0TqVCE32IUGEPSP6MRih849j9/QA9RYCA
From:	"Kaz Kylheku" <KKylheku@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <KKylheku@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KKylheku@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

On June 23, 2009 3:03 PM, David Daney [mailto:ddaney@caviumnetworks.com]

> I wonder if it is another instance of:
> 
> http://www.linux-mips.org/git?p=linux.git;a=commitdiff;h=49cf0
> e2d68dd98dbb28eaca0284e8460ab6ad86d

Thanks for digging that up. The patch fixes it for me.
Clearly, it's not just for init. Any process can
ignore signals that shouldn't be ignored.

I'm surprised this has only been discovered
so recently. It's amazing how we sometimes find
things at around the same time.

If I may pontificate now, someone said my little
program was silly. Of course; it's a repro test case! 
Nobody would deliberately block SIGBUS and
then deliberately trigger a bus error.

But this situation happened in a large and complex real
application, leaving some of my developers scratching
their heads, and distracting them from looking for
the bad pointer!

``Hey look, we can break this 100% CPU thread with gdb, but
it always stops on the same location, which is an
indirect load through a register containing a bad pointer!
And it's spinning mostly in the kernel. Hmm!''

I gave them that little program to demonstrate how the
behavior can occur. They are now working out how
SIGBUS came to be ignored, and, of course, the
cause of the bad pointer.
