Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2007 19:40:25 +0000 (GMT)
Received: from mx.mips.com ([63.167.95.198]:16821 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20022131AbXCPTkV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Mar 2007 19:40:21 +0000
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l2GJXS37003712;
	Fri, 16 Mar 2007 11:33:28 -0800 (PST)
Received: from exchange.MIPS.COM (exchange [192.168.20.29])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id l2GJWg3R023160;
	Fri, 16 Mar 2007 11:32:42 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Mips SOC, Linux
Date:	Fri, 16 Mar 2007 12:32:43 -0700
Message-ID: <3CB54817FDF733459B230DD27C690CEC021D71C3@Exchange.mips.com>
In-Reply-To: <20070311135654.GA26339@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mips SOC, Linux
Thread-Index: Acdj5Y4Xe2SgcmWUTxatjCuN+A1jqAEGjt3g
From:	"Mitchell, Earl" <earlm@mips.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>,
	"PhilipS" <sphilip30@gmail.com>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <earlm@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: earlm@mips.com
Precedence: bulk
X-list: linux-mips




> But let's also look at the options you have right now:
> 
>  o Eval boards end on ebay relativly rarely, but you can try anyway.
>    Another option is something like a surplus MIPS workstation.
>  o A bunch of wireless routers and other devices such as some 
> the Linksys
>    WRT54 models have been recycled for hacking use with good success.
>  o Routerboard which is not yet supported out of tree 
> (working in cleaing
>    the patches) would be another reasonably priced option.  
> Generally you
>    may want to look at the list of platforms supported by
>    http://openwrt.org/ - many of their platforms have 
> friendly price tags.
>    Of course alot of those are purpose built hw so may be a 
> bit quirky to
>    use.
>  o Apparently AMD Alchemy boards used to be fairly cheap, on 
> the order of
>    $100.  I have not idea this is true or still true for the 
> new owner of
>    Alchemy Raza Microelectronics.
>  o For the meager investment of a few megabytes of disk space 
> Qemu is a
>    really nice and well performing system which also is 
> rapidly improving.
> 
>   Ralf

Another possible option are the Roku HD series boxes. 
The old Roku HD's (also known as Photobridge) used a
MIPS-based chip and Roku provided linux SDK for developers to download
(see http://www.rokulabs.com/community_developers_sb.php). 

That box is no longer sold.  However it appears they now have a new box
called the Brightsign HD600 http://www.rokulabs.com/digital_brightsign.php
which sells for $300. The manual says it uses a Nexperia chip. They
may eventually provide a linux SDK for this box also.  

-earlm
