Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2005 18:44:33 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:58810 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133622AbVJRRoP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Oct 2005 18:44:15 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j9IHhlH5022606;
	Tue, 18 Oct 2005 10:43:47 -0700 (PDT)
Received: from exchange.MIPS.COM (exchange [192.168.20.29])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id j9IHhl17000016;
	Tue, 18 Oct 2005 10:43:47 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: power management on mips
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date:	Tue, 18 Oct 2005 10:43:48 -0700
Message-ID: <3CB54817FDF733459B230DD27C690CEC01049435@Exchange.MIPS.COM>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: power management on mips
thread-index: AcXT/UXxtjROvuI1RHqdujEOm3SmWwADcSOA
From:	"Mitchell, Earl" <earlm@mips.com>
To:	"Ivan Korzakow" <ivan.korzakow@gmail.com>,
	<linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.39
Return-Path: <earlm@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: earlm@mips.com
Precedence: bulk
X-list: linux-mips


APM is dead replaced by ACPI which is primarily used for x86 laptops 
I think. While back I read that MontaVista and IBM were working on 
something called Dynamic Power Mgmt (DPM). Might want to check that out? 
See links below. 

-earlm
 
http://www.linuxdevices.com/news/NS4297534594.html
http://tree.celinuxforum.org/CelfPubWiki/PowerManagementDefinitionOfTerms_5fR2
 


> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Ivan Korzakow
> Sent: Tuesday, October 18, 2005 9:01 AM
> To: linux-mips@linux-mips.org
> Subject: power management on mips
> 
> 
> Hi list,
> 
> Does anyone knows what power management features are there for mips ?
> I know for example that ACPI have been porting to arm. Anything
> equivalent for mips ? Is it possible to do some power management under
> Linux if ACPI or APM is not ported to mips ? And if yes, what would be
> the work to do ?
> 
> Thanks in advance,
> 
> Ivan
> 
> 
