Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 05:19:52 +0100 (BST)
Received: from m205-235.dsl.tsoft.com ([IPv6:::ffff:198.144.205.235]:32908
	"EHLO lists.herlein.com") by linux-mips.org with ESMTP
	id <S8225296AbTJVETu>; Wed, 22 Oct 2003 05:19:50 +0100
Received: from io.herlein.com (io.herlein.com [192.168.70.244])
	by lists.herlein.com (Postfix) with ESMTP
	id 344EFA32; Tue, 21 Oct 2003 21:28:06 -0700 (PDT)
Date: Tue, 21 Oct 2003 19:16:37 -0700 (PDT)
From: Greg Herlein <gherlein@herlein.com>
To: Pete Popov <ppopov@mvista.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Au1500 kernel?
In-Reply-To: <1066782264.21027.164.camel@zeus.mvista.com>
Message-ID: <Pine.LNX.4.44.0310211913380.3164-100000@io.herlein.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <gherlein@herlein.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gherlein@herlein.com
Precedence: bulk
X-list: linux-mips

> I think I had the same problem, if I remember correctly, so I used the
> 2.95 compiler on linux-mips.org.

Unfortunately when I try to install that it fails due to rpm hell 
(ie, dependencies).  Sigh.  OK, I can go rebuild it all from 
source.

> BTW, only serial console, ethernet, and MTD have been updated in 2.6. I
> haven't had time for anything else yet, including the 36 bit address
> support.

OK, I don't need the latest 2.6 stuff - where can I grab some 
tarballs of older 2.4 kernels with the mips patches applied - 
does such a thing exist?

Greg
