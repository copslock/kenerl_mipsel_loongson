Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 20:21:15 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:11483 "EHLO
	bluesmobile.corp.specifix.com") by ftp.linux-mips.org with ESMTP
	id S20039283AbWI2TVN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 20:21:13 +0100
Received: from localhost.localdomain (bluesmobile.specifix.com [64.220.152.99])
	by bluesmobile.corp.specifix.com (Postfix) with ESMTP id 73E783B923;
	Fri, 29 Sep 2006 12:15:34 -0700 (PDT)
Subject: Re: HELP: opcode not supported on this processor
From:	Jim Wilson <wilson@specifix.com>
To:	David Lee <receive4me@gmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <5ee285ba0609290632m6c5e3f35nbae45307a3398b86@mail.gmail.com>
References: <5ee285ba0609290235v7b518495u2dccb1ef82b117d0@mail.gmail.com>
	 <20060929110849.GD3868@networkno.de>
	 <5ee285ba0609290632m6c5e3f35nbae45307a3398b86@mail.gmail.com>
Content-Type: text/plain
Date:	Fri, 29 Sep 2006 12:17:24 -0700
Message-Id: <1159557444.2897.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Fri, 2006-09-29 at 21:32 +0800, David Lee wrote:
> I could not figure it out in more than 2 hours. I don't even know what
> compliantion options used for kernel. I need more instructions and
> help.

To elaborate on what Thiemo said, take a look at
    http://www.linux-mips.org/wiki/Modules
In particular, see the fourth sentence of the first paragraph.  I think
this solves your problem.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
