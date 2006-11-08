Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2006 08:42:08 +0000 (GMT)
Received: from david.siemens.com.cn ([194.138.202.53]:61391 "EHLO
	david.siemens.com.cn") by ftp.linux-mips.org with ESMTP
	id S20038547AbWKHImD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Nov 2006 08:42:03 +0000
Received: from ns.siemens.com.cn (ns.siemens.com.cn [194.138.237.52])
	by david.siemens.com.cn (8.11.7/8.11.7) with ESMTP id kA88fkR10203;
	Wed, 8 Nov 2006 16:41:46 +0800 (CST)
Received: from pekw905a.cn001.siemens.net (localhost [127.0.0.1])
	by ns.siemens.com.cn (8.11.7/8.11.7) with ESMTP id kA88fjX03554;
	Wed, 8 Nov 2006 16:41:45 +0800 (CST)
Received: from PEKW934A.cn001.siemens.net ([139.24.236.66]) by pekw905a.cn001.siemens.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 8 Nov 2006 16:41:44 +0800
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: MIPS processors gain GNU/Linux binary prelinker
Date:	Wed, 8 Nov 2006 16:41:42 +0800
Message-ID: <96E7D5519FC3D741BEE27AB88C738797012FA7E2@PEKW934A.cn001.siemens.net>
In-Reply-To: <000801c702fb$c96e89e0$0202fea9@swcenter.sec.samsung.co.kr>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: MIPS processors gain GNU/Linux binary prelinker
Thread-Index: AccCdlPhiEMmXaCGSkSTiB1vXSyW8wAhUCMAAAWFESA=
From:	"Fu, He Wei PSE NKG" <hewei.fu@siemens.com>
To:	=?ks_c_5601-1987?B?sei5zsL5?= <barrioskmc@gmail.com>,
	"Thiemo Seufer" <ths@networkno.de>,
	"Tim Bird" <tim.bird@am.sony.com>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 08 Nov 2006 08:41:44.0688 (UTC) FILETIME=[B86DCF00:01C70311]
Return-Path: <hewei.fu@siemens.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hewei.fu@siemens.com
Precedence: bulk
X-list: linux-mips

http://people.redhat.com/jakub/prelink.pdf
I don¡¯t know whether is it useful? 

-----Original Message-----
From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of ???
Sent: Wednesday, November 08, 2006 2:05 PM
To: 'Thiemo Seufer'; 'Tim Bird'
Cc: linux-mips@linux-mips.org
Subject: RE: MIPS processors gain GNU/Linux binary prelinker

Who know anymore about prelink for mips architecture? 
Let me know prelink for mips detaily.
Thanks in advance.


-----Original Message-----
From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.
org] On Behalf Of Thiemo Seufer
Sent: Tuesday, November 07, 2006 11:05 PM
To: Tim Bird
Cc: CE Linux Developers List; linux-mips@linux-mips.org
Subject: Re: MIPS processors gain GNU/Linux binary prelinker

Tim Bird wrote:
> FYI - For those interested in bootup time improvements on MIPS
> processors, here is some information about the recently
> developed MIPS prelinking feature, done by CodeSourcery
> and MIPS Technologies.

The patches are showing up piecemeal now on the various mailing lists,
I also dumped a debian-styleish patchset at
ftp://ftp.linux-mips.org/pub/linux/mips/people/ths/mips-prelinker-patches-
debian/


Thiemo
