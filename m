Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2005 16:42:16 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:41744 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8224974AbVHZPl5>; Fri, 26 Aug 2005 16:41:57 +0100
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j7QFT7KW020449;
	Fri, 26 Aug 2005 11:29:07 -0400
In-Reply-To: <1125069898.14435.1215.camel@localhost.localdomain>
References: <1125006681.14435.1065.camel@localhost.localdomain> <Pine.LNX.4.61L.0508261340460.9561@blysk.ds.pg.gda.pl> <1125069898.14435.1215.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0cc66f0b0b5afa994744547699f687bf@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
From:	Dan Malek <dan@embeddededge.com>
Subject: Re: patch / rfc
Date:	Fri, 26 Aug 2005 11:47:36 -0400
To:	ppopov@embeddedalley.com
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Aug 26, 2005, at 11:24 AM, Pete Popov wrote:

>> void (*plat_setup_late)(void);
>> [...]
>> 	if (plat_setup_late)
>> 		plat_setup_late()
>>
>> or something like that.
>
> Sure, we can do that.

If you do this, I suggest using another PowerPC-ism.  They
have a ppc_md data structure that is filled with indirect function
pointers to machine dependent functions.  We could create
a mips_md that does this same thing.  The reason I like this
is it collects all machine dependent information in a single
place, so it's easy to see what functions/data are available
and what you may need to do.  It's also clear when used
that anything in this structure is a machine/board dependent
function.  In the proper places, you then do what is shown above:

	if (mips_md.plat_setup_late)
		mips_md.plat_setup_late();

Your earliest machine dependent set up can then fill this in
based upon board options, or you can statically set it up if
you need it even earlier and change it later.

Thanks.

	-- Dan
