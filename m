Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2003 21:49:19 +0000 (GMT)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:63451 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225248AbTA2VtT>;
	Wed, 29 Jan 2003 21:49:19 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h0TLn667019942;
	Wed, 29 Jan 2003 13:49:07 -0800 (PST)
Received: from xchange.mips.com (xchange [192.168.20.31])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id NAA04263;
	Wed, 29 Jan 2003 13:49:08 -0800 (PST)
Received: by xchange.mips.com with Internet Mail Service (5.5.2653.19)
	id <S30VWH61>; Wed, 29 Jan 2003 13:46:45 -0800
Message-ID: <0C5F4C7A1E3ED51194E200508B2CE32A01B03304@xchange.mips.com>
From: "Mitchell, Earl" <earlm@mips.com>
To: "'Chien-Lung Wu'" <cwu@deltartp.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: verify/test a new cross-compiler
Date: Wed, 29 Jan 2003 13:46:44 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <earlm@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: earlm@mips.com
Precedence: bulk
X-list: linux-mips

Read this. May be different for cross-compiler.
These instructions assume native compiler I think.

http://gcc.gnu.org/install/test.html

-earlm

-----Original Message-----
From: Chien-Lung Wu [mailto:cwu@deltartp.com] 
Sent: Wednesday, January 29, 2003 12:57 PM
To: 'linux-mips@linux-mips.org'
Subject: verify/test a new cross-compiler

Hi, 

I built a cross-compiler (mips-linux) on i686-linux host using
	binutil-2.13
	gcc-3.0
	glibc-2.2.3


Now the question is 
	how can I verify/test this cross-compiler work?

Are there any test-cases/methods I can download to verify it?
Thanks for your help.

Chien-Lung
