Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Dec 2004 12:40:14 +0000 (GMT)
Received: from p508B6A65.dip.t-dialin.net ([IPv6:::ffff:80.139.106.101]:59172
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225213AbUL0MkK>; Mon, 27 Dec 2004 12:40:10 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBRCdvke026146;
	Mon, 27 Dec 2004 13:39:57 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBRCdv0G026145;
	Mon, 27 Dec 2004 13:39:57 +0100
Date: Mon, 27 Dec 2004 13:39:57 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: domen@coderock.org
Cc: linux-mips@linux-mips.org
Subject: Re: [patch 8/9] delete unused file
Message-ID: <20041227123957.GA26100@linux-mips.org>
References: <20041225172501.97E251F123@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225172501.97E251F123@trashy.coderock.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 25, 2004 at 06:25:11PM +0100, domen@coderock.org wrote:

> Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Applied,

  Ralf
