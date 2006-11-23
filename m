Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2006 06:45:39 +0000 (GMT)
Received: from smtp1.infineon.com ([217.10.60.22]:3704 "EHLO
	smtp1.infineon.com") by ftp.linux-mips.org with ESMTP
	id S20037961AbWKWGpf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Nov 2006 06:45:35 +0000
Received: from unknown (HELO mucse312.eu.infineon.com) ([172.23.30.12])
  by smtp1.infineon.com with ESMTP; 23 Nov 2006 07:45:29 +0100
X-SBRS:	None
Received: from mucse307.eu.infineon.com ([172.23.30.7]) by mucse312.eu.infineon.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 23 Nov 2006 07:45:28 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: init cannot spawn shell
Date:	Thu, 23 Nov 2006 07:45:25 +0100
Message-ID: <B0956DED3DE3CD47BF0398D4E0ECE59F011B70C9@mucse307.eu.infineon.com>
In-Reply-To: <1164246953.6511.25.camel@sandbar.kenati.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: init cannot spawn shell
Thread-Index: AccOoPLXatL7OO9KTTyBLahSUZKDuAAKWwBg
From:	<Andre.Messerschmidt@infineon.com>
To:	<ashlesha@kenati.com>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 23 Nov 2006 06:45:28.0313 (UTC) FILETIME=[F661B690:01C70ECA]
Return-Path: <Andre.Messerschmidt@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andre.Messerschmidt@infineon.com
Precedence: bulk
X-list: linux-mips

Hi,
 

> I m sure that the endianness is not an issue - everything is big 
> endian.

We had some problem in the past, where the reverse endianess bit was
set, that would result in a crash when the system starts init. Not sure
what bootloader you are using, but maybe it is worth checking the RE bit
in CP0.STATUS, since otherwise your userspace applications will run in
little endian.

Regards
Andre
