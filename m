Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 17:52:42 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:8176 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225305AbULHRwh>; Wed, 8 Dec 2004 17:52:37 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 81F9C1865E; Wed,  8 Dec 2004 09:52:34 -0800 (PST)
Message-ID: <41B73F62.40007@mvista.com>
Date: Wed, 08 Dec 2004 09:52:34 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Muruga Ganapathy <gmuruga@gdatech.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Forcing IDE to work in PIO mode
References: <200412081742.iB8Hgpp31261@gdatech.com>
In-Reply-To: <200412081742.iB8Hgpp31261@gdatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Muruga Ganapathy wrote:
> Hello, 
> 
> How do I force the IDE to work in the PIO mode by including the 
> option like "hdb=noprobe" in the setup.c?
> 
> 
> My kernel version is 2.6.6
> 
> Thanks
> G.Muruganandam
> 

Hello !

I would have thought "ide=nodma" at the command line would have worked

Thanks
Manish Lachwani
