Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2003 03:13:56 +0100 (BST)
Received: from kauket.visi.com ([IPv6:::ffff:209.98.98.22]:6793 "HELO
	mail-out.visi.com") by linux-mips.org with SMTP id <S8225197AbTDMCNy>;
	Sun, 13 Apr 2003 03:13:54 +0100
Received: from mehen.visi.com (mehen.visi.com [209.98.98.97])
	by mail-out.visi.com (Postfix) with ESMTP id 26BAC3735
	for <linux-mips@linux-mips.org>; Sat, 12 Apr 2003 21:13:52 -0500 (CDT)
Received: from mehen.visi.com (localhost [127.0.0.1])
	by mehen.visi.com (8.12.9/8.12.5) with ESMTP id h3D2Dq6D019755
	for <linux-mips@linux-mips.org>; Sat, 12 Apr 2003 21:13:52 -0500 (CDT)
	(envelope-from erik@greendragon.org)
Received: (from www@localhost)
	by mehen.visi.com (8.12.9/8.12.5/Submit) id h3D2Dp5N019754
	for linux-mips@linux-mips.org; Sun, 13 Apr 2003 02:13:51 GMT
X-Authentication-Warning: mehen.visi.com: www set sender to erik@greendragon.org using -f
Received: from 64-212-120-201.bras01.mnd.mn.frontiernet.net (64-212-120-201.bras01.mnd.mn.frontiernet.net [64.212.120.201]) 
	by my.visi.com (IMP) with HTTP 
	for <longshot@imap.visi.com>; Sun, 13 Apr 2003 02:13:51 +0000
Message-ID: <1050200031.3e98c7df2c227@my.visi.com>
Date: Sun, 13 Apr 2003 02:13:51 +0000
From: "Erik J. Green" <erik@greendragon.org>
To: linux-mips@linux-mips.org
Subject: Where does physical RAM start in kseg0?
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 64.212.120.201
Return-Path: <erik@greendragon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik@greendragon.org
Precedence: bulk
X-list: linux-mips



Hi again, everyone;

A question about kseg0:  Do system designers usually set things up such that
kseg0 begins at the start of physical memory, regardless of the xkphys offset at
which RAM starts?

Or is it necessary to add the offset at which RAM starts to the kseg0 base,
making it possible that the system designers could start RAM addresses high
enough (above 512M) to make kseg0 unusable?  Does anyone have an implementation
in which this is the case?  

If kseg0 provides a window beginning at physical address 0, that means I'm going
to try using Ralf's mapped kernel option, or I'll have to get the kernel up and
running in 64 bit only mode (I believe 32 bit compat binaries would still work,
since kuseg can be mapped).

Erik



-- 
Erik J. Green
erik@greendragon.org
