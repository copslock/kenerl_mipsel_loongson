Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2008 17:56:03 +0100 (BST)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:16140 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S20375671AbYJBQ4B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Oct 2008 17:56:01 +0100
Received: from [127.0.0.1] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id MAA31723;
	Thu, 2 Oct 2008 12:23:07 -0500
Message-ID: <48E4FDE3.9080006@paralogos.com>
Date:	Thu, 02 Oct 2008 18:59:15 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Linux MIPS Org <linux-mips@linux-mips.org>
Subject: Re: SMTC Patches [0 of 3]
References: <48C6DC4C.5040208@paralogos.com> <20081002093510.GA19177@linux-mips.org>
In-Reply-To: <20081002093510.GA19177@linux-mips.org>
X-Enigmail-Version: 0.95.7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> I've folded patch 4/3 into 1/3 and backported everything, as far as
> it seemed sensible. 
Thanks!
> One nit was that 2/3 breaks the build and 3/3 fixes
> it again.  This sort of build breakage is not uncommon but frowned
> uppon these days since it makes use of git bisect for debugging
> impossible.
>   
Oops.  I didn't think that 2 required 3, or I wouldn't have published
things that way, but I didn't actually do a test build in a separate
tree to verify.  Sorry about that.

          Regards,

          Kevin K.
