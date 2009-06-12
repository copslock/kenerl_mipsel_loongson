Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jun 2009 23:09:19 +0200 (CEST)
Received: from gateway09.websitewelcome.com ([67.18.22.68]:56038 "HELO
	gateway09.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1492156AbZFLVJN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 Jun 2009 23:09:13 +0200
Received: (qmail 15525 invoked from network); 12 Jun 2009 21:13:54 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway09.websitewelcome.com with SMTP; 12 Jun 2009 21:13:54 -0000
Received: from 216-239-45-4.google.com ([216.239.45.4]:15866 helo=epiktistes.mtv.corp.google.com)
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1MFDzg-0005Yo-5S; Fri, 12 Jun 2009 16:09:00 -0500
Message-ID: <4A32C3EC.4060606@paralogos.com>
Date:	Fri, 12 Jun 2009 14:09:00 -0700
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	Anoop P A <an4linu@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: smtc support
References: <eefc325c0906121335i6b575864kd10ca52948c36bd8@mail.gmail.com>
In-Reply-To: <eefc325c0906121335i6b575864kd10ca52948c36bd8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

As the guy who wrote the SMTC stuff, I'd recommend picking up something 
newer.  Ralf has merged some of the subsequent improvements and fixes 
into 2.6.18, but not the patches that I made last year to allow tickless 
support, which is actually a very, very good thing to have for SMTC.  
That support was initially available in 2.6.24, but subsequently got 
broken by some changes to control register manipulation APIs that I 
identified and fixed a few months ago.  Ralf back-merged them into 
several recent baselines, but I'm not sure which ones. 2.6.29-stable 
seems to have all the right patches applied for SMTC, but of course I 
can't tell whether there would be other issues for your platform.

          Regards,

          Kevin K.

Anoop P A wrote:
> Hi List,
>
> I have got a reference board with mips 34k core SOC.I am planning to 
> enable smtc/smp support . The reference kernel I am having is 
> linux-2.6.18 which is in uniprocessor mode.
>
>  Could any of you suggest me in which way i have to proceed?. Does it 
> make sense to continue using 2.6.18 or port newer kernel version ( 
> which might be having better SMTC/SMP support)? 
>
> Thanks
> An
