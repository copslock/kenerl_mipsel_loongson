Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 21:25:15 +0000 (GMT)
Received: from 154-84-51-66.reonbroadband.com ([IPv6:::ffff:66.51.84.154]:56192
	"EHLO tibook.netx4.com") by linux-mips.org with ESMTP
	id <S8225198AbTBTVZO>; Thu, 20 Feb 2003 21:25:14 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h1KLOeP01260;
	Thu, 20 Feb 2003 16:24:41 -0500
Message-ID: <3E554798.5060403@embeddededge.com>
Date: Thu, 20 Feb 2003 16:24:40 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Popov <ppopov@mvista.com>
CC: Jun Sun <jsun@mvista.com>,
	Tibor Polgar <tpolgar@freehandsystems.com>,
	Mark Salter <msalter@redhat.com>, krishnakumar@naturesoft.net,
	linux-mips@linux-mips.org
Subject: Re: Ramdisk image on flash.
References: <200302201135.09154.krishnakumar@naturesoft.net>	 <1045765647.30379.262.camel@zeus.mvista.com>	 <3E552CDF.ECD08EEF@freehandsystems.com>	 <20030220194115.2A21378A6D@deneb.localdomain>	 <3E55342D.6E1D36FF@freehandsystems.com> <3E553C03.10207@embeddededge.com>	 <20030220124456.G7466@mvista.com> <1045774664.16543.307.camel@zeus.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:

> Me too. Keep in mind too that there is no "standard" zImage support in
> mips right now.  I'm not sure what Dan is using for the zImage support,

I took what you had started, copied lots of stuff from the same thing
I did for PowerPC a long time ago, and actually improved on that (I think) :-).
It seems every Alchemy processor I work with has a different boot rom,
so like PowerPC this gives us the ability to also format kernel calling
conventions in addition to zImage/initrd booting and flexibility.

> that but that's another patch that needs to make its way in the source
> tree.

I'll get it there :-)

> ....  I added zImage support in the form of an arch/mips/zboot
> directory and supporting files, but that never made it in linux-mips.org
> because it added yet another copy of zlib (my argument was, so what, all
> the other arches do it).

Yeah, I know about zlib.  I have "fixed" this more than once on PowerPC
to use the kernel zlib, but it still hasn't stuck in the source tree :-)
I'll try to get it right when I do a MIPS patch.

Thanks.


	-- Dan
