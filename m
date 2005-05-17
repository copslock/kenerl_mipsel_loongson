Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2005 15:59:14 +0100 (BST)
Received: from smtp007.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.10]:33172
	"HELO smtp007.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8226233AbVEQO65>; Tue, 17 May 2005 15:58:57 +0100
Received: from unknown (HELO ?192.168.1.105?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp007.bizmail.sc5.yahoo.com with SMTP; 17 May 2005 14:58:52 -0000
Subject: Re: au1200 status
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	"Ruslan V.Pisarev" <jerry@izmiran.rssi.ru>
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1547700103.20050517142217@izmiran.rssi.ru>
References: <1547700103.20050517142217@izmiran.rssi.ru>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Tue, 17 May 2005 07:59:02 -0700
Message-Id: <1116341942.5802.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Tue, 2005-05-17 at 14:22 +0300, Ruslan V.Pisarev wrote:
>   Hello all
> 
>   Dealing with my new DBau1200 board and last 2.6 kernel I found that
> there's a few things came into from 2.4 kernel, which is distributed
> by AMD with this board. In 2.6 we have no ethernet driver (thanks to
> Pete I solved this issue (temporarily?)), furthermore we have no LCD
> driver, no sound driver, etc... What status of it? Will these drivers
> migrate from 2.4 to 2.6 tree (and how soon?)  Or there's something
> different politics?

The Au1200 support will from migrate from 2.4 to 2.6 when either someone
funds the effort or someone has time to do it for fun.

>   Some time ago I saw a old report for some au1* boards usability and
> patches for them - maybe I should look for them?
> 
>   In addition, somewhere I met the info that such things like MAE,
> AES, MTD drivers must be done (by AMD?) in 1st quarter 2005. Anyhow, I
> see no any info about them.. Did I missed something?

Perhaps they were talking about 2.4, not 2.6.

Pete
