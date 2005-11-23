Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2005 09:52:14 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:48666 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133577AbVKWJv4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Nov 2005 09:51:56 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAN9saDn004806;
	Wed, 23 Nov 2005 09:54:36 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAN9sZN6004805;
	Wed, 23 Nov 2005 09:54:35 GMT
Date:	Wed, 23 Nov 2005 09:54:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Knittel, Brian" <Brian.Knittel@powertv.com>
Cc:	linux-mips@linux-mips.org, Dominic Sweetman <dom@mips.com>
Subject: Re: Saving arguments on the stack
Message-ID: <20051123095435.GB2699@linux-mips.org>
References: <762C0A863A7674478671627FEAF5848105AF92D5@hqmail01.powertv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <762C0A863A7674478671627FEAF5848105AF92D5@hqmail01.powertv.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 22, 2005 at 10:24:09AM -0800, Knittel, Brian wrote:

> We'd like to add arguments to the backtrace in Oops messages to make
> debugging from these reports more efficient. It is particularly useful
> for determining where the problem was generated, particularly when bad
> pointers are passed in. This is for production embedded devices with
> optimized code and which reboot immediately after storing or sending the
> Oops message. Performance is an issue, but the overhead of storing the
> arguments on the stack is likely worth the added debug info.

In this case you would probably have to modify the compiler to save all
arguments.  Another issue is actually finding the stackframe.  For a
debugger using debug information this is possible but short of that it's
hard on MIPS to produce a meaningful backtrace.  Or having something
as complicate as on ia64 ...

  Ralf
