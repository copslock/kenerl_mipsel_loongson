Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2003 01:21:51 +0000 (GMT)
Received: from ppp-66-122-194-201.aonnetworks.com ([IPv6:::ffff:66.122.194.201]:3972
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225240AbTAQBVu>; Fri, 17 Jan 2003 01:21:50 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.5/8.12.5) with ESMTP id h0H1QiL7002069
	for <linux-mips@linux-mips.org>; Thu, 16 Jan 2003 17:26:44 -0800
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.5/8.12.5/Submit) id h0H1QiZx002067
	for linux-mips@linux-mips.org; Thu, 16 Jan 2003 17:26:44 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Thu, 16 Jan 2003 17:26:44 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Anyone running crashme?
Message-ID: <20030117012644.GA2058@wumpus.internal.keyresearch.com>
Mail-Followup-To: linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

I've been running crashme a little against Linux mips, and from the
bugs I immediately found I suspect that no one's been running it.
Crashme generates random bytes and then executes them, catching the
resulting signals and generating more random bytes. The random number
seed is provided by the user, so that problems are repeatable.

If you like debugging, you can find the source at:

http://people.delphiforums.com/gjc/crashme.html

-- greg
