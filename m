Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Sep 2002 22:44:21 +0200 (CEST)
Received: from mcp.csh.rit.edu ([129.21.60.9]:2470 "EHLO mcp.csh.rit.edu")
	by linux-mips.org with ESMTP id <S1122978AbSIBUoV>;
	Mon, 2 Sep 2002 22:44:21 +0200
Received: from fury.csh.rit.edu (fury.csh.rit.edu [129.21.60.5])
	by mcp.csh.rit.edu (Postfix) with ESMTP id 958D84376
	for <linux-mips@linux-mips.org>; Mon,  2 Sep 2002 16:44:08 -0400 (EDT)
Date: Mon, 2 Sep 2002 16:43:55 -0400 (EDT)
From: George Gensure <werkt@csh.rit.edu>
To: <linux-mips@linux-mips.org>
Subject: root-nfs hang and error
Message-ID: <Pine.SOL.4.31.0209021634320.24635-100000@fury.csh.rit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <werkt@csh.rit.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: werkt@csh.rit.edu
Precedence: bulk
X-list: linux-mips

I've got a problem with a diskless install on an Indy.

When trying to mount an nfs to install to, I end up with about a 5 minute
hang (afterwards, though, all file transfer is seamless).  When rebooting
to boot from that nfs root I get an rpc error from the Indy and it refuses
to mount the root.  (obviously it panics).  The kernel is 2.4.16 and has
nfs v2 and v3 installed, as well as root nfs support.  Anyone have any
suggestions for getting this root to mount correctly?

-George
werkt@csh.rit.edu
