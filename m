Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2004 00:57:13 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:20672 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225288AbUKIA5I>;
	Tue, 9 Nov 2004 00:57:08 +0000
Received: from drow by nevyn.them.org with local (Exim 4.34 #1 (Debian))
	id 1CRKJj-0008Ad-83; Mon, 08 Nov 2004 19:57:03 -0500
Date: Mon, 8 Nov 2004 19:57:03 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Yoni Rabinovitch <Yoni.Rabinovich@Teledata-Networks.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Problems debugging multithreaded program wirh gdbserver via ser ial port
Message-ID: <20041109005703.GA31331@nevyn.them.org>
References: <D6FAAE89E48C5B488B41BEBBDCD746CD09E7CF@tndcmail.Teledata.Local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6FAAE89E48C5B488B41BEBBDCD746CD09E7CF@tndcmail.Teledata.Local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 08, 2004 at 05:53:40PM +0200, Yoni Rabinovitch wrote:
> Running with "set debug serial 1" gives me the following:
> 
> In the gdb session,I see lots of the following messages:
> [O][K][#][9][a][$]Packet instead of Ack, ignoring it
> 
> Simultaneously, in the gdbserver session (via minicom) I see:
> +$OK#9a

Um.... you're running with a serial port open on the same port you're
trying to debug on?  That can't work.  Use one for console and the
other for gdbserver, or come to some other arrangement if your board
only has one.

-- 
Daniel Jacobowitz
