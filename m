Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2003 17:05:14 +0100 (BST)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:17760 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225192AbTCaQFN>;
	Mon, 31 Mar 2003 17:05:13 +0100
Received: by trasno.mitica (Postfix, from userid 1001)
	id A2EE5720; Mon, 31 Mar 2003 18:05:07 +0200 (CEST)
To: Amit.Lubovsky@infineon.com
Cc: linux-mips@linux-mips.org
Subject: Re: mips5kc - cpu registers
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <04C8EDC5AE3FD611ABE40002B39CF69B07F37F@ntah901e.savan.com> (Amit.Lubovsky@infineon.com's
 message of "Mon, 31 Mar 2003 18:45:43 +0200")
References: <04C8EDC5AE3FD611ABE40002B39CF69B07F37F@ntah901e.savan.com>
Date: Mon, 31 Mar 2003 18:05:07 +0200
Message-ID: <863cl3a5e4.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "amit" == Amit Lubovsky <Amit.Lubovsky@infineon.com> writes:

amit> Hi,
amit> is there a possibility to use cpu registers in the code (temporarily)
amit> instead of allocating 
amit> automatic variables something like:
amit> func a()
amit> {
amit> FAST int, i, tmp;
amit> tmp = ...
amit> ...
amit> }

theorically, 
             register int i, tmp;

should de that, but I think that no modern compiler will honour the
register keyword.  Anyways, you should be doing something really
strange for the  compiler not to choose a register for a local
variable when it should automagically.

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
