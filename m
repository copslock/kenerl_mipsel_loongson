Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Sep 2002 13:15:19 +0200 (CEST)
Received: from alg133.algor.co.uk ([62.254.210.133]:19952 "EHLO
	oval.algor.co.uk") by linux-mips.org with ESMTP id <S1122960AbSITLPS>;
	Fri, 20 Sep 2002 13:15:18 +0200
Received: from mudchute.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g8KBF9r05092;
	Fri, 20 Sep 2002 12:15:09 +0100 (BST)
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id MAA15989;
	Fri, 20 Sep 2002 12:15:03 +0100 (BST)
Date: Fri, 20 Sep 2002 12:15:03 +0100 (BST)
Message-Id: <200209201115.MAA15989@mudchute.algor.co.uk>
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Gareth <g.c.bransby-99@student.lboro.ac.uk>
Cc: linux-mips@linux-mips.org
Subject: Re: Cycles for certain instructions
In-Reply-To: <20020920095623.5300295a.g.c.bransby-99@student.lboro.ac.uk>
References: <20020920095623.5300295a.g.c.bransby-99@student.lboro.ac.uk>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Return-Path: <dom@mudchute.algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


Gareth,

> I am doing an investigation with a mips malta board that has a 4kc
> processor on it. I am trying to find out how many cycles certain
> instructions take to execute.
> 
> The program I am running loops a small piece of code many
> times. After a few loops of the code the caches will have all the
> instructions in them and so accesses to memory will be few and far
> between.

Some 4Kx CPUs have write-through caches.  If yours is one of them,
write traffic will continue to flow to memory.  There's a FIFO on the
CPU to hold write address/data, but unless your writes are sparse the
FIFO will rapidly fill, and the program will run only as fast as the
memory can process the writes.

4Kx CPUs with writeback caches can still be configured with the cache
disabled or (in some cases) in write-through.

> So how many cycles do instructions such as load word and store word
> take?

One.  But the operation is pipelined: if you try to use the data you
loaded in the very next instruction, the CPU will wait one extra clock.

Strange things may happen if you put loads shortly after a store to
the same location.

> Obviosly if the data is not in the cache the time take will depend
> on the speed of the external memory.

Yes.

> If the data is in the cache is the time taken fairly predictable for
> a given core?

Very predictable!

-- 
Dominic Sweetman, 
MIPS Technologies (UK) - formerly Algorithmics
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
http://www.algor.co.uk
