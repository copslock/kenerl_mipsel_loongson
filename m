Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Mar 2005 01:46:44 +0000 (GMT)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.198]:50420 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225003AbVCKBq3>;
	Fri, 11 Mar 2005 01:46:29 +0000
Received: by wproxy.gmail.com with SMTP id 37so607632wra
        for <linux-mips@linux-mips.org>; Thu, 10 Mar 2005 17:46:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GIy2VN/LXn7g//is6gQwVltlaG0pRtbKsKXuIazKUacSasIhaO8NnLeJjbBFRaGfnc/3fPjSpmjCVQxktChrmcLdjPfMR9GHwvWuG8UanTTH6GPSVvoIhj/sOcVCDy7r+SJYbFgho4IuyMv7Z3KXX0A7yz/gCVS5/1JMVw0+4ZQ=
Received: by 10.54.65.13 with SMTP id n13mr964628wra;
        Thu, 10 Mar 2005 17:46:23 -0800 (PST)
Received: by 10.54.56.8 with HTTP; Thu, 10 Mar 2005 17:46:23 -0800 (PST)
Message-ID: <77fd3fe00503101746fed176b@mail.gmail.com>
Date:	Thu, 10 Mar 2005 17:46:23 -0800
From:	Linux Mailinglist <mailinglist.linux@gmail.com>
Reply-To: Linux Mailinglist <mailinglist.linux@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Linux 2.6 support for Brecis MSP2100 processor !
In-Reply-To: <20050309173044.GA18688@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <77fd3fe0050308202654a4432a@mail.gmail.com>
	 <20050309173044.GA18688@linux-mips.org>
Return-Path: <mailinglist.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mailinglist.linux@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf !

Thanks, but the problem with this SOC is that it does not have MMU. I
would like to know wheather we have the port for Mips 4Km processor
without MMU ?

Thanks in advance. 
Srinivasan


On Wed, 9 Mar 2005 17:30:44 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Mar 08, 2005 at 08:26:40PM -0800, Linux Mailinglist wrote:
> 
> > Is anybody have a port of Linux 2.6 kernel on Brecis MSP2100 processor ?
> 
> That's not a processor but a whole SOC and the processor is a 4Km which
> is supported.
> 
>  Ralf
>
