Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f326qEi29792
	for linux-mips-outgoing; Sun, 1 Apr 2001 23:52:14 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f326qDM29789
	for <linux-mips@oss.sgi.com>; Sun, 1 Apr 2001 23:52:13 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP id CE43E109DD
	for <linux-mips@oss.sgi.com>; Sun,  1 Apr 2001 23:52:12 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 90D6F1F428; Sun,  1 Apr 2001 23:52:12 -0700 (PDT)
Date: Sun, 1 Apr 2001 23:52:12 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: linux-mips@oss.sgi.com
Subject: RFC: Cleanup/detection patch
Message-ID: <20010401235212.B9737@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have posted an initial copy of my patch for machine detection,
namespace cleanup, and promlib abstraction at
http://foobazco.org/~wesolows/mips64-machine.diff.  This is against
2.4.2 CURRENT oss.  It currently passes my regression testsuite which
unfortunately does not include an ip27 boot test.

There are several goals to this patch: to be able to support multiple
machines with a single kernel binary; to reduce code duplication among
the various machines, and to provide a well-defined architecture for a
future increase in the number and diversity of systems we support.

This patch affects mips64 only at this time.  However, it will be
ported to the 32-bit mips tree following comment.  It is also
incomplete - I know for a fact that certain pci functions need this
kind of abstraction as well, and the promlib support is fairly
minimal.  The accompanying documentation, while useful especially for
new porters, is slightly out of date already.

For those (embedded systems people) who think the ability to support
multiple machines in a single kernel is useless bloat, consider
instead that you will have significantly less code to maintain and to
write, since more functionality will be provided by generic functions.
No more copying the generic files, changing three lines, and having to
maintain the copies forever.  This patch as written adds less than 300
net lines of code to the kernel (the entire difference is contained in
__init functions), and when finished will probably result in
single-machine kernels which are approximately the same size as
current versions.

Please offer your comments.  Barring a shockingly brutal rejection of
the fundamental principles, I fully expect this to be integrated by
2.5.x for mips and mips64.  Speak now or forever hold your peace.

If you are interested, this code is also being maintained in cvs at
cvs.foobazco.org, username cvs, password cvs, repository linux.  This
is not a fork; the patches will either be put into oss or dropped.
This tree also has early 64-bit SGI O2 support based on work by Harald
Koerfgen, nick@snowman.net, and me.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
"I should have crushed his marketing-addled skull with a fucking bat."
