Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 00:40:31 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:4343 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225278AbTDOXka> convert rfc822-to-8bit;
	Wed, 16 Apr 2003 00:40:30 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3FNeRQ25748;
	Tue, 15 Apr 2003 16:40:27 -0700
Date: Tue, 15 Apr 2003 16:40:27 -0700
From: Jun Sun <jsun@mvista.com>
To: Steve Taylor <godzilla1357@yahoo.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Basic cache questions
Message-ID: <20030415164027.T1642@mvista.com>
References: <20030415221914.47873.qmail@web14503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030415221914.47873.qmail@web14503.mail.yahoo.com>; from godzilla1357@yahoo.com on Tue, Apr 15, 2003 at 03:19:14PM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Apr 15, 2003 at 03:19:14PM -0700, Steve Taylor wrote:
> Hello All,   I am hoping some of you mips-linux gurus will be able to help me give me some tips and help me get started on some cache stuff which I want to do. (I know decently well about caches - but only at a theoretical Hennessy & Patterson level - and have just started looking under arch/mips/mm to familiarize myself with the mips-linux implementation).   Here's what I want to do - I have a CPU with 4 way SA I and D caches, and I want to write a module that will lock a certain memory region in these caches (for example, let's say I want to lock the ISR in the I-cache). So my questions are a) Is the kernel going to crash if I try to mess around with the caches like locking out a particular way of the cache or something like that? b) I'm sure there are many issues and complications involved in this that I probably havent even thought of  - any obvious and/or subtle pitfalls? and c) Do you think locking out, say, an entire way of a 4-way cache for a dedicated frequently used !
> !
> routine improves or degrades overall system performance?   TIA, -Steve.

If the cache locking can survive flushing, i.e., locked cache line
remained valid and locked even after cache invalidation ops, I guess
you are probably OK.

I have looked the performance issues with cache locking on a two-way
cache system.  There was not much performance gain.

Jun
