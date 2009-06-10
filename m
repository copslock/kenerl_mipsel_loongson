Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2009 15:25:11 +0100 (WEST)
Received: from web23601.mail.ird.yahoo.com ([87.248.115.44]:27816 "HELO
	web23601.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S20023044AbZFJOZF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jun 2009 15:25:05 +0100
Received: (qmail 38130 invoked by uid 60001); 10 Jun 2009 14:24:58 -0000
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s1024; t=1244643898; bh=ZLFCAuampoqwApXx+6X9l/axrRqvDZLp+MxGHRau19k=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=GgcprVT+JCEXyjq7YiExZKsbjkohkXdQVoCgO0HoZOe4m9OrsgsJD4L1+VcodGwK+wLrRec1ztbzjaio2g0STVypf/ttJkKnR1NsCCCJZblbLCKP+ZLTmD1LO65Ys1zPgua++Qpq6JwFNsEESwjNdQqY0m2sIf0gyO5R8l01T58=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=y4NjvzkS8VYNyN6WCtTR1yFldwbRSK13Rwb5lLvNkNRPUNwTl5y7sP9aEywYao4el7f+eMAXhqSmmN1W0l8YyEg3abpzZnVbOdbMDpWpF37mPJFmapVTDJeZKYoY+sOulFRHPuwcsBuzHrjWUebX1pZexgkFQ8vXY5cxEKIuIas=;
Message-ID: <149516.38062.qm@web23601.mail.ird.yahoo.com>
X-YMail-OSG: RbFuR6sVM1lDqi8xeiIVwr4WBjeXBvV6oYoZe3lVNZ7sYhrDRVDni_sW23nQsmmWQDdm5YHqocXo0ixst36myaIY1iUqa9HS3e18I6KNHV_wqKvLW3qHVcwuyHCg1dAlrSGcmdWRuBhqyfVXG_YgH88tLgHrlLqow0gYwgSZWp5YPsRikcbrFN2xyqkKLn2RqKbo8INJ45fCp_5.JCnGV42xLwi6hsmQ_0kRza0Vl76GI.v3Hnql6y04JQrTl11fGRSqLy_2wNkYWTpoMgNQh9q7Nd75GaNjxQxCbSR.JUYmkohZmkUbMRxoCwsbTLNiSrs1LAYwFduIFfcT2L.vMqpPD9s07c_1pQHLuY0fNw--
Received: from [83.166.184.142] by web23601.mail.ird.yahoo.com via HTTP; Wed, 10 Jun 2009 14:24:57 GMT
X-Mailer: YahooMailClassic/5.4.12 YahooMailWebService/0.7.289.15
Date:	Wed, 10 Jun 2009 14:24:57 +0000 (GMT)
From:	Glyn Astill <glynastill@yahoo.co.uk>
Subject: Re: Qube2 slowly dies
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <glynastill@yahoo.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glynastill@yahoo.co.uk
Precedence: bulk
X-list: linux-mips


Hi Florian,

> From: Florian Fainelli <florian@openwrt.org>

> Determine which process consumes all that memory. Can you
> describe which 
> programs you are running on your Qube2 ?
> 

That's exactly it - I couldn't see anything using excessive memory.

> 
> I have been running linux-mips git builds for about a year
> and half now on my 
> Qube2 without any troubles, the box serves as NFS/FTP
> server and works pretty 
> well and sustains bandwidth.
> 

Thats good to hear anyway.

> My guess is that you are having a hardware problem or the
> box might not be 
> cooled as it should be.

I have 2 qubes, both cooled properly and both have run netbsd as solid as a rock for the past 3 years. My usual yearly upgrade routine is prepare a fresh qube and switch them, when I do this I normally have 1 year+ uptime.

I should mention that I've been using this qube with netbsd without issue for years.

> If you want, you can test the
> following kernel which 
> I have been running on this qube2 for some months: 
> http://alphacore.org/~florian/linux-mips/qube/
> 

Thanks, I will have a go with one of those - I'll have to lookup my notes on preparing a kernel for debian though.

If it is not the kernel though (I suspect it is not) Any Ideas what I should be looking at to catch whatever is causing this? I've checked memory usage, turned off dma, and there isn't much IO load.  As it's a qube there's plenty of CPU load.

?


      
