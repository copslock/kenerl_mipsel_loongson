Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jun 2004 04:57:26 +0100 (BST)
Received: from fw.osdl.org ([IPv6:::ffff:65.172.181.6]:61862 "EHLO
	mail.osdl.org") by linux-mips.org with ESMTP id <S8224791AbUFPD5W>;
	Wed, 16 Jun 2004 04:57:22 +0100
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i5G3v0r06879;
	Tue, 15 Jun 2004 20:57:00 -0700
Date: Tue, 15 Jun 2004 20:56:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [PATCH] make ps2 mouse work ...
Message-Id: <20040615205611.1e9cbfcc.akpm@osdl.org>
In-Reply-To: <20040615191023.G28403@mvista.com>
References: <20040615191023.G28403@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

Jun Sun <jsun@mvista.com> wrote:
>
> 
> I found this problem on a MIPS machine.  The problem is 
> likely to happen on other register-rich RISC arches too.
> 
> cmdcnt needs to be volatile since it is modified by
> irq routine and read by normal process context.

volatile is not the preferred way to fix this up.  This points at either a
locking error in the psmouse driver or a missing "memory" thingy in the
mips port somewhere.

Please describe the bug which led to this patch.  Where was it getting stuck?
