Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2003 19:10:00 +0000 (GMT)
Received: from ppp-66-122-194-201.aonnetworks.com ([IPv6:::ffff:66.122.194.201]:21376
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8224939AbTANTJ7>; Tue, 14 Jan 2003 19:09:59 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.5/8.12.5) with ESMTP id h0EJEJl5001353
	for <linux-mips@linux-mips.org>; Tue, 14 Jan 2003 11:14:19 -0800
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.5/8.12.5/Submit) id h0EJEIxT001351
	for linux-mips@linux-mips.org; Tue, 14 Jan 2003 11:14:18 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Tue, 14 Jan 2003 11:14:18 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: insmod failure: "Unhandled relocation" errors
Message-ID: <20030114191417.GA1243@wumpus.internal.keyresearch.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <001801c2bbb4$a6177de0$7100000a@riverhead.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001801c2bbb4$a6177de0$7100000a@riverhead.com>
User-Agent: Mutt/1.4i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Tue, Jan 14, 2003 at 12:06:46PM +0200, Gilad Benjamini wrote:

> I am now trying to insert a module, a standard module from
> the kernel tree, and get lots of errors such as:
> "Unhandled relocation of type 18 for"
> or
> "Unhandled relocation of type 18 for <function_name>"

I'm impressed that it got this far -- let me guess, big endian?
Little endian didn't even get that far last time I tried it.

greg
