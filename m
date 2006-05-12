Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 May 2006 18:24:47 +0200 (CEST)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:1127 "EHLO
	sj-iport-5.cisco.com") by ftp.linux-mips.org with ESMTP
	id S8126579AbWELQYi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 May 2006 18:24:38 +0200
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-5.cisco.com with ESMTP; 12 May 2006 09:24:27 -0700
X-IronPort-AV: i="4.05,122,1146466800"; 
   d="scan'208"; a="275885728:sNHT47624892"
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id k4CGORvo018364;
	Fri, 12 May 2006 09:24:27 -0700
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id k4CGORB9027629;
	Fri, 12 May 2006 09:24:27 -0700 (PDT)
Received: from xmb-sjc-237.amer.cisco.com ([128.107.191.123]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 12 May 2006 09:24:26 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: SOAP
Date:	Fri, 12 May 2006 09:24:25 -0700
Message-ID: <27801B4D04E7CA45825B0E0CE60FE10A01E51ED3@xmb-sjc-237.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SOAP
Thread-Index: AcZ1mPBlvPMpXG2bSsmNcKCCEepW8wAR1FYQ
From:	"Ratin Rahman \(mratin\)" <mratin@cisco.com>
To:	"Ralf Roesch" <ralf.roesch@rw-gmbh.de>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 12 May 2006 16:24:26.0960 (UTC) FILETIME=[89AD5500:01C675E0]
DKIM-Signature:	a=rsa-sha1; q=dns; l=962; t=1147451067; x=1148315067;
	c=relaxed/simple; s=sjdkim4001; h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=mratin@cisco.com; z=From:=22Ratin=20Rahman=20\(mratin\)=22=20<mratin@cisco.com>
	|Subject:RE=3A=20SOAP;
	X=v=3Dcisco.com=3B=20h=3DpkqlvQRZJCCcYqvcM/ZHl4u6qTk=3D; b=lfv+N2ghg+6t++U6yb4/hY4/w4SX5WhiRi4b1eYK1MsImjo53zGpEK0V1CA3cSfXMzDpJ1zQ
	e+RYImcRtrnXRw3JvEh541pPGpl2zFBNRbYDXgErBRX+OG/mRM4CHDK5;
Authentication-Results:	sj-dkim-4.cisco.com; header.From=mratin@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Return-Path: <mratin@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mratin@cisco.com
Precedence: bulk
X-list: linux-mips

Thanks, good to know about the illegal XML serialization patent that
Microsoft obtained from the patent office on that page. 
Ratin

-----Original Message-----
From: Ralf Roesch [mailto:ralf.roesch@rw-gmbh.de] 
Sent: Friday, May 12, 2006 12:51 AM
To: Ratin
Cc: linux-mips@linux-mips.org
Subject: Re: SOAP

we have successfully used gSOAP since years now on a mips based embedded
target runing linux from mips-org.
Further related information about the gSOAP project you can find at
http://www.cs.fsu.edu/~engelen/soap.html

Ralf

Roesch & Walter___________________________________________
Industrie-Elektronik GmbH * Tel.: +49-7824 / 6628-0
Im Heidenwinkel 5         * Fax:  +49-7824 / 6628-29
D-77963 Schwanau          * mailto:ralf.roesch@rw-gmbh.de
Germany                   * WWW: http://www.rw-gmbh.de




Ratin wrote:
> Is there an implementation of SOAP (Simple Object Access Protocol) for

> linux-mips?
>
> Ratin
>
