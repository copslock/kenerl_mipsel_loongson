Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g71JHhRw012804
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 1 Aug 2002 12:17:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g71JHhu6012803
	for linux-mips-outgoing; Thu, 1 Aug 2002 12:17:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from tibook.netx4.com (154-84-51-66.reonbroadband.com [66.51.84.154])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g71JHbRw012790;
	Thu, 1 Aug 2002 12:17:37 -0700
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id g71JIpv00702;
	Thu, 1 Aug 2002 15:18:51 -0400
Message-ID: <3D49899B.5080203@embeddededge.com>
Date: Thu, 01 Aug 2002 15:18:51 -0400
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [update] [patch] linux: Cache coherency fixes
References: <20020801184929.B22824@dea.linux-mips.net> <Pine.GSO.3.96.1020801185642.8256P-100000@delta.ds2.pg.gda.pl> <20020801195820.F22824@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> Just a small detail.  Nest conditions several times and the spaghetti
> starts :-)

Other cache coherency challenged processor architectures have adopted
the same CONFIG_NONCOHERENT_IO configuration option.  Some of these
could eventually find their way into generic kernel software and clean
up the architecture specific code.


	-- Dan
