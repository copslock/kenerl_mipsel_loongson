Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Jan 2004 14:11:13 +0000 (GMT)
Received: from netlx014.civ.utwente.nl ([IPv6:::ffff:130.89.1.88]:60312 "EHLO
	netlx014.civ.utwente.nl") by linux-mips.org with ESMTP
	id <S8225485AbUAaOLN>; Sat, 31 Jan 2004 14:11:13 +0000
Received: from ringbreak.dnd.utwente.nl (ringbreak.dnd.utwente.nl [130.89.175.240])
          by netlx014.civ.utwente.nl (8.11.7/HKD) with ESMTP id i0VEARL15841
          for <linux-mips@linux-mips.org>; Sat, 31 Jan 2004 15:10:27 +0100
Received: from jorik by ringbreak.dnd.utwente.nl with local (Exim 3.35 #1 (Debian))
	id 1AmvpL-0002sl-00
	for <linux-mips@linux-mips.org>; Sat, 31 Jan 2004 15:10:27 +0100
Date: Sat, 31 Jan 2004 15:10:27 +0100
From: Jorik Jonker <linux-mips@boeventronie.net>
To: linux-mips@linux-mips.org
Subject: Re: linux 2.4 and Indy
Message-ID: <20040131141027.GA11048@ballina>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org> <20040131030435.GA24228@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131030435.GA24228@linux-mips.org>
User-Agent: Mutt/1.3.28i
X-UTwente-MailScanner-Information: Scanned by MailScanner. Contact helpdesk@ITBE.utwente.nl for more information.
X-UTwente-MailScanner: Found to be clean
Return-Path: <jorik@dnd.utwente.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@boeventronie.net
Precedence: bulk
X-list: linux-mips

On Sat, Jan 31, 2004 at 04:04:35AM +0100, Ralf Baechle wrote:
> Over the past days a few fixes went into CVS, the last only a few minutes
> ago.  Can you retry and let me know?

Well, it a little 'better'. It now hangs while configurating the network
device, while in earlier versions the freeze appeared while calibrating the
delay loop, or mounting the root fs.
Is there something else I could try?
Until I know what's going on, I am going to look for a kernel with proper
VINO support which is 'old' enough to run without the freeze..

cheers,
-- 
Jorik Jonker
http://boeventronie.net/
