Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Feb 2003 23:59:54 +0000 (GMT)
Received: from mail.ocs.com.au ([IPv6:::ffff:203.34.97.2]:11278 "HELO
	mail.ocs.com.au") by linux-mips.org with SMTP id <S8224847AbTBOX7x>;
	Sat, 15 Feb 2003 23:59:53 +0000
Received: (qmail 31024 invoked from network); 15 Feb 2003 23:59:44 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 15 Feb 2003 23:59:44 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id 358533000B8; Sun, 16 Feb 2003 10:59:41 +1100 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id 0C3898F; Sun, 16 Feb 2003 10:59:41 +1100 (EST)
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] REMOTE_DEBUG, DEBUG config cleanup 
In-reply-to: Your message of "Thu, 13 Feb 2003 12:31:08 -0800."
             <20030213123108.V7466@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 16 Feb 2003 10:59:35 +1100
Message-ID: <4706.1045353575@ocs3.intra.ocs.com.au>
Return-Path: <kaos@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@sgi.com
Precedence: bulk
X-list: linux-mips

On Thu, 13 Feb 2003 12:31:08 -0800, 
Jun Sun <jsun@mvista.com> wrote:
>Remove false dependency.  Add help info for CONFIG_DEBUG.
>+Enable run-time debugging
>+CONFIG_DEBUG
>+  If you say Y here, some debugging macros will do run-time checking.
>+  If you say N here, those macros will mostly turn to no-ops.  For
>+  MIPS boards only.  See include/asm-mips/debug.h for debuging macros.
>+  If unsure, say N.

CONFIG_DEBUG is too generic for an option that only applies to mips.
Make it CONFIG_MIPS_DEBUG.
