Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jul 2004 01:17:11 +0100 (BST)
Received: (from localhost user: 'ralf' uid#501 fake: STDIN
	(ralf@3ffe:8260:2028:fffe::1)) by linux-mips.org
	id <S8224941AbUGIARC>; Fri, 9 Jul 2004 01:17:02 +0100
Date: Fri, 9 Jul 2004 01:17:02 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: New CVS Mailing List
Message-ID: <20040709001702.GA2795@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

I've created a new mailing list maltalinux-cvs@linux-mips.org for tracking
of MIPS's stable Malta tree.  Unlike the main Linux CVS repository which
is more slanted towards development maltalinux-cvs is primarily oriented
towards stability on the Malta platform and it's processors.

Subscription to maltalinux-cvs@linux-mips.org is handled via Ecartis
(ecartis@linux-mips.org), just send an email with the words subscribe
maltalinux-cvs. In order to unsubscribe, send unsubscribe maltalinux-cvs.
Sending the word help will reveal further secrets about the advanced use
of Ecartis. At http://www.linux-mips.org/ecartis you'll also find a
web-based interface to Ecartis.

Similarly as with the main CVS tree the new tree may be followed in cvsweb
at http://www.linux-mips.org/cvsweb/malta/ in xcvs and via anon cvs by

  cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs login
 (Only needed the first time you use anonymous CVS, the password is "cvs")
 cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs co malta

  Ralf
