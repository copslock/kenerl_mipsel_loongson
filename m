Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Sep 2005 10:27:44 +0100 (BST)
Received: from ylpvm29-ext.prodigy.net ([IPv6:::ffff:207.115.57.60]:51619 "EHLO
	ylpvm29.prodigy.net") by linux-mips.org with ESMTP
	id <S8225074AbVIPJ10>; Fri, 16 Sep 2005 10:27:26 +0100
Received: from pimout3-ext.prodigy.net (pimout3-int.prodigy.net [207.115.4.218])
	by ylpvm29.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j8G9R41C005225
	for <linux-mips@linux-mips.org>; Fri, 16 Sep 2005 05:27:06 -0400
X-ORBL:	[67.124.117.85]
Received: from stupidest.org (adsl-67-124-117-85.dsl.snfc21.pacbell.net [67.124.117.85])
	by pimout3-ext.prodigy.net (8.13.4 outbound domainkey aix/8.13.4) with ESMTP id j8G9RI7b420246;
	Fri, 16 Sep 2005 05:27:22 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 82428528F26; Fri, 16 Sep 2005 02:27:18 -0700 (PDT)
Date:	Fri, 16 Sep 2005 02:27:18 -0700
From:	Chris Wedgwood <cw@f00f.org>
To:	"\"Zheng BaoJian <??????>\"" <bjzheng@ict.ac.cn>
Cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: debug user-level application with ejtag
Message-ID: <20050916092718.GA15749@taniwha.stupidest.org>
References: <432A8E5E.3090703@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432A8E5E.3090703@ict.ac.cn>
Return-Path: <cw@f00f.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cw@f00f.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 16, 2005 at 05:20:30PM +0800, "Zheng BaoJian <??????>" wrote:

> I want to debug a user-level application with ejtag,during app
> running i list cpu register with ejtag,system report "Bus error",Who
> have debuged user app with ejtag?

generally speaking this won't work in any reliable manner (it probably
could be made to work reliably given enough effort but i doubt anyone
will bother)

try gdbserver instead
