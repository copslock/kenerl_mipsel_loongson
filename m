Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 02:19:24 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:50834
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225219AbUHRBTU> convert rfc822-to-8bit; Wed, 18 Aug 2004 02:19:20 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id i7I1J9RI001957;
	Tue, 17 Aug 2004 18:19:09 -0700 (PDT)
Received: from exchange.MIPS.COM (exchange [192.168.20.29])
	by mercury.mips.com (8.12.11/8.12.11) with ESMTP id i7I1JBma012780;
	Tue, 17 Aug 2004 18:19:11 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: MIPS Malta board linux problem 
Date: Tue, 17 Aug 2004 18:19:11 -0700
Message-ID: <3CB54817FDF733459B230DD27C690CEC0E72F6@Exchange.MIPS.COM>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: MIPS Malta board linux problem 
Thread-Index: AcSEv3o+6ckYLAMNTymBmSifKp+6lwAAXqtQ
From: "Mitchell, Earl" <earlm@mips.com>
To: "usha davuluri" <ranidavuluri@yahoo.com>,
	<linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.39
Return-Path: <earlm@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: earlm@mips.com
Precedence: bulk
X-list: linux-mips


I remember while back YAMON would get
"TFTP READ-REQ ERROR" when used with
the RH7.3 TFTP server. I believe this
was fixed in later revs. So if you are
using an old version of YAMON try a
more recent rev. 

-earlm

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of usha davuluri
> Sent: Tuesday, August 17, 2004 6:05 PM
> To: linux-mips@linux-mips.org
> Subject: MIPS Malta board linux problem 
> 
> 
> Hi,
>  I am trying to bring up the Malta board with the
> prebuils kernel. I am using TFTP server for that. I am
> pretty much sure that TFTP server is up on my host
> Redhat linux laptop. Some how I am not able to load
> the immage on to the board. Please any one can help me
> to solve this problem. 
> I tested the tftp with the $:xinetd -d command. The
> out put came well( TFTP is running). Following error
> messages I am getting when I try to load the linux
> kernel using tftp.
> 
> load
> tftp://192.168.0.115//vmlinux-2.4.3.malta.install.el-01.02.srec
> About to load
> tftp://192.168.0.115//vmlinux-2.4.3.malta.install.el-01.02.srec
> Press Ctrl-C to break
> Error : TFTP READ-REQ ERROR
> Diag  : Host returned: ErrorCode = 2, ErrorMsg =
> Access violation
> Hint  : Check TFTP-server: file-existence,
> directory/file-attributes
> Thank you,
> Usha.
> 
> 
> 		
> __________________________________
> Do you Yahoo!?
> Y! Messenger - Communicate in real time. Download now. 
> http://messenger.yahoo.com
> 
> 
