Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 07:48:46 +0000 (GMT)
Received: from no-dns-yet.demon.co.uk ([80.176.203.50]:52441 "EHLO
	pangolin.localnet") by ftp.linux-mips.org with ESMTP
	id S8133648AbWASHs1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 07:48:27 +0000
Received: from sprocket.localnet ([192.168.1.27])
	by pangolin.localnet with esmtp (Exim 3.35 #1 (Debian))
	id 1EzUaY-0001hr-00; Thu, 19 Jan 2006 07:52:10 +0000
Message-ID: <43CF4526.2090104@bitbox.co.uk>
Date:	Thu, 19 Jan 2006 07:52:06 +0000
From:	Peter Horton <phorton@bitbox.co.uk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	freshy98 <freshy98@gmx.net>
CC:	linux-mips@linux-mips.org
Subject: Re: Cobalt Raq2 HD upgrade - Advice required
References: <43CEB82F.6020009@kilimandjaro.dyndns.org> <43CEDEA9.6030506@gmx.net>
In-Reply-To: <43CEDEA9.6030506@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

freshy98 wrote:
> Dominique Quatravaux wrote:
> 
>>
>> I'd like to beef up the machine, with more RAM and another HD for
>> backups. I found the appropriate Wiki page
>> (http://www.linux-mips.org/wiki/Cobalt) and I believe I can deal with
>> the RAM part. OTOH as regards the hard drive, the page is a bit evasive:
>> exactly what kind of HD can I put there (one for a laptop perhaps)? Will
>> I need any duct tape to fasten the second disk? Is there anything
>> special I should know about the operation?
>>
> 
> All you need is a new IDE cable since the default one only has the 
> Master connector and you need the Slave as well.
> Apart from that it should be easy.
> Oh, you also need a Molex splitter since the default one is only good 
> for one drive.
> 

If you have some soldering experience it's also quite easy to fit the 
components for the second IDE channel (it's just a handful of resistors, 
a diode and the connector IIRC).

P.
