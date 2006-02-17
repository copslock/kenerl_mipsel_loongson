Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 12:32:13 +0000 (GMT)
Received: from omx1-ext.sgi.com ([192.48.179.11]:33701 "EHLO
	omx1.americas.sgi.com") by ftp.linux-mips.org with ESMTP
	id S8133645AbWBQMcF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Feb 2006 12:32:05 +0000
Received: from imr2.americas.sgi.com (imr2.americas.sgi.com [198.149.16.18])
	by omx1.americas.sgi.com (8.12.10/8.12.9/linux-outbound_gateway-1.1) with ESMTP id k1HCcdOX002728;
	Fri, 17 Feb 2006 06:38:40 -0600
Received: from daisy-e236.americas.sgi.com (daisy-e236.americas.sgi.com [128.162.236.214])
	by imr2.americas.sgi.com (8.12.9/8.12.10/SGI_generic_relay-1.2) with ESMTP id k1HCtXa514804457;
	Fri, 17 Feb 2006 04:55:33 -0800 (PST)
Received: from [127.0.0.1] (daisy-e236.americas.sgi.com [128.162.236.214]) by daisy-e236.americas.sgi.com (8.12.9/SGI-server-1.8) with ESMTP id k1HCcaQq1630112; Fri, 17 Feb 2006 06:38:37 -0600 (CST)
Message-ID: <43F5C300.10108@sgi.com>
Date:	Fri, 17 Feb 2006 13:35:12 +0100
From:	Jes Sorensen <jes@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Please pull drivers/scsi/dec_esp.c from Linus' git
References: <20060213225331.GA5315@deprecation.cyrius.com> <20060215150839.GA27719@linux-mips.org> <Pine.LNX.4.64N.0602161016260.7169@blysk.ds.pg.gda.pl> <20060216145931.GA1633@linux-mips.org> <Pine.LNX.4.64N.0602161504230.7169@blysk.ds.pg.gda.pl> <yq0pslmxsb7.fsf@jaguar.mkp.net> <Pine.LNX.4.64N.0602171039320.7169@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0602171039320.7169@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jes@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jes@sgi.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Fri, 17 Feb 2006, Jes Sorensen wrote:
> 
> 
>>Just make mmiowb() strong enough on those platforms. There's really no
>>reason to introduce yet another variation at this point.
> 
> 
>  It's just horribly slow and an overkill if it's only ordering of 
> consecutive writes rather than ordering of a read after a write that has 
> to be guaranteed.  But perhaps we could keep abusing wmb() for the 
> former...

Depends on where it's happening. If it's the CPU doing it before it hits
the bus then wmb() would probably be ok.

Jes
