Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62IlHRw009110
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 11:47:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62IlHYn009109
	for linux-mips-outgoing; Tue, 2 Jul 2002 11:47:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nixon.xkey.com (nixon.xkey.com [209.245.148.124])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62IlFRw009096
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 11:47:15 -0700
Received: (qmail 17733 invoked from network); 2 Jul 2002 18:51:08 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 2 Jul 2002 18:51:08 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id g62Imh701942
	for linux-mips@oss.sgi.com; Tue, 2 Jul 2002 11:48:43 -0700
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Tue, 2 Jul 2002 11:48:43 -0700
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@oss.sgi.com
Subject: Re: MIPS GOT overflow in gcc 3.2.
Message-ID: <20020702114843.B1896@wumpus.internal.keyresearch.com>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020701184640.A2043@lucon.org> <1025575632.30577.64.camel@ghostwheel.cygnus.com> <1025579401.1785.0.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1025579401.1785.0.camel@ghostwheel.cygnus.com>; from echristo@redhat.com on Mon, Jul 01, 2002 at 08:09:59PM -0700
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> AFAIK it happens to mozilla as well.

On AlphaLinux, we eventually acquired multigot. Many large apps were
tripping on this problem; many big C++ programs essentially use
whole-program compilation, and many HPC codes link a bazillion large
libraries. I don't understand if -fpic or -fPIC are as good of a
solution as multigot.

greg
