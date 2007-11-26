Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 19:54:53 +0000 (GMT)
Received: from mx.mips.com ([63.167.95.198]:65266 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20039613AbXKZTyn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Nov 2007 19:54:43 +0000
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id lAQJs5HN022411;
	Mon, 26 Nov 2007 11:54:05 -0800 (PST)
Received: from exchange.MIPS.COM (exchange [192.168.20.29])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id lAQJsZsN027248;
	Mon, 26 Nov 2007 11:54:36 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Tool chain for linux using mips
Date:	Mon, 26 Nov 2007 11:54:58 -0800
Message-ID: <3CB54817FDF733459B230DD27C690CEC04FCB3FF@Exchange.mips.com>
In-Reply-To: <4749C258.8020400@saville.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Tool chain for linux using mips
Thread-Index: Acgvk0DVQs4q6TYjQQaAW9CUn5ew3gA0jXAQ
From:	"Mitchell, Earl" <earlm@mips.com>
To:	"Wink Saville" <wink@saville.com>, <linux-mips@linux-mips.org>
Return-Path: <earlm@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: earlm@mips.com
Precedence: bulk
X-list: linux-mips


Few months ago I was able to successfully build using 
crosstools-0.43. I used demo-mipsel.sh to build c,c++ using 
the following command line ... 

eval `cat mips.dat gcc-3.4.5-glibc-2.3.6-tls.dat` sh all.sh --notest --gdb

-earlm

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Wink Saville
> Sent: Sunday, November 25, 2007 10:44 AM
> To: linux-mips@linux-mips.org
> Subject: Tool chain for linux using mips
> 
> 
> Hello,
> 
> I was wondering which MIPS tool chains people are
> using and recommend, prebuilt and/or roll-your-own.
>  From http://www.kegel.com/crosstool/crosstool-0.43/buildlogs/
> there doesn't seem to be any combination that builds cleanly
> for the mips/mipsel.
> 
> Regards,
> 
> Wink Saville
> 
> 
> 
