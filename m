Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 23:45:14 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:19280 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S28573767AbWLAXpK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 23:45:10 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Trouble with System V IPC on n32.
Date:	Fri, 1 Dec 2006 15:45:03 -0800
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D4B5F42@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Trouble with System V IPC on n32.
Thread-Index: AccVn4woxnreGnt4Qeu5SryUvIlOVgAAtm7g
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

My guess was wrong. The call is going through sys32_shmat.

Inside this function, the put_user call is returning -14/EFAULT.
