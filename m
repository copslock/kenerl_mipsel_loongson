Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2004 18:45:49 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:24708
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225346AbUJHRpo> convert rfc822-to-8bit; Fri, 8 Oct 2004 18:45:44 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id i98HjMln025026;
	Fri, 8 Oct 2004 10:45:28 -0700 (PDT)
Received: from exchange.MIPS.COM (exchange [192.168.20.29])
	by mercury.mips.com (8.12.11/8.12.11) with ESMTP id i98HjMo4028394;
	Fri, 8 Oct 2004 10:45:22 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Yamon File system support 
Date: Fri, 8 Oct 2004 10:45:25 -0700
Message-ID: <3CB54817FDF733459B230DD27C690CEC77E203@Exchange.MIPS.COM>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Yamon File system support 
Thread-Index: AcStLOdKbN9riVocTmy+EWTtGIe4swAMYc6Q
From: "Mitchell, Earl" <earlm@mips.com>
To: "Wolfgang Denk" <wd@denx.de>, "Nigel Stephens" <nigel@mips.com>
Cc: "Vinay Nagendra" <Vinay.Nagendra@gnss.com>,
	<linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.39
Return-Path: <earlm@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: earlm@mips.com
Precedence: bulk
X-list: linux-mips


I believe Redboot already has port
available for Malta 4K/5K boards available 
and it supports JFFS. I've never tried it
before though so YMMV. 

-earlm

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Wolfgang Denk
> Sent: Friday, October 08, 2004 4:49 AM
> To: Nigel Stephens
> Cc: Vinay Nagendra; linux-mips@linux-mips.org
> Subject: Re: Yamon File system support 
> 
> 
> In message <41664DC7.30701@mips.com> you wrote:
> > 
> > It is not supported by the YAMON supplied by MIPS on the 
> MALTA board, 
> > though I suppose that it is possible that someone other 
> vendor has added 
> > this feature to their port.
> 
> Alternatively it should not be too difficult to port U-Boot.
> 
> Best regards,
> 
> Wolfgang Denk
> 
> -- 
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> Horses just naturally have mohawk haircuts.
> 
> 
