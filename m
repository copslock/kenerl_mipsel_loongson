Received:  by oss.sgi.com id <S553673AbRCLToL>;
	Mon, 12 Mar 2001 11:44:11 -0800
Received: from u-143-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.143]:14087
        "EHLO u-143-19.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553652AbRCLTny>; Mon, 12 Mar 2001 11:43:54 -0800
Received: from dea ([193.98.169.28]:17024 "EHLO dea.waldorf-gmbh.de")
	by bacchus.dhis.org with ESMTP id <S867210AbRCLTnh>;
	Mon, 12 Mar 2001 20:43:37 +0100
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2CJhKY19682;
	Mon, 12 Mar 2001 20:43:20 +0100
Date:	Mon, 12 Mar 2001 20:43:20 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Dan Aizenstros <dan@vcubed.com>
Cc:	"linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Error in set_cp0_ functions
Message-ID: <20010312204320.A19579@bacchus.dhis.org>
References: <3AAD0CB9.FAE7C050@vcubed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AAD0CB9.FAE7C050@vcubed.com>; from dan@vcubed.com on Mon, Mar 12, 2001 at 12:51:53PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Mar 12, 2001 at 12:51:53PM -0500, Dan Aizenstros wrote:

> There appears to be an error in the new set_cp0_ functions in
> the mipsregs.h file.

Thanks for the report, fixed.

  Ralf
