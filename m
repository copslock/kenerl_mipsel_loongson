Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2004 20:27:39 +0000 (GMT)
Received: from clarify-web.lantronix.com ([IPv6:::ffff:164.109.144.217]:30929
	"EHLO sjwc380101.int.lantronix.com") by linux-mips.org with ESMTP
	id <S8225557AbUA2U1i> convert rfc822-to-8bit; Thu, 29 Jan 2004 20:27:38 +0000
Received: from sj580004wcom.int.lantronix.com ([10.107.100.143]) by sjwc380101.int.lantronix.com with Microsoft SMTPSVC(5.0.2195.5329);
	 Thu, 29 Jan 2004 12:25:16 -0800
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: Gcc - can't branch to undefined symbol
Date: Thu, 29 Jan 2004 12:25:16 -0800
Message-ID: <603BA0CFF3788E46A0DB0918D9AA95100A0E3088@sj580004wcom.int.lantronix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Gcc - can't branch to undefined symbol
Thread-Index: AcPmdWp/fYznQKtrQPCC4kvxZPh9SgAMD8zQ
From: "Jerry Walden" <jerry.walden@lantronix.com>
To: <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 29 Jan 2004 20:25:16.0897 (UTC) FILETIME=[01FF3D10:01C3E6A6]
Return-Path: <jerry.walden@lantronix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerry.walden@lantronix.com
Precedence: bulk
X-list: linux-mips

Hello -

I am using gcc 3.3.2 - when I assemble a file that has a branch to a
label, and the label is not defined in the .S file (i.e. there is no
extern - the label exists in another .S file) the error "cannot branch
to an undefined symbol" results.  Using an older version of
mipsel-gnu-linux-gcc does not report this error.  Any idea what I am
doing wrong?

Thanks
