Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 20:07:41 +0000 (GMT)
Received: from father.pmc-sierra.com ([IPv6:::ffff:216.241.224.13]:30093 "HELO
	father.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225214AbVAaUH0>; Mon, 31 Jan 2005 20:07:26 +0000
Received: (qmail 25322 invoked by uid 101); 31 Jan 2005 20:07:18 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by father.pmc-sierra.com with SMTP; 31 Jan 2005 20:07:18 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.12.9/8.12.7) with ESMTP id j0VIRMAt008525;
	Mon, 31 Jan 2005 10:27:22 -0800
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <CPW1JFF3>; Mon, 31 Jan 2005 10:27:22 -0800
Message-ID: <04781D450CFF604A9628C8107A62FCCF013DDC16@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Brad Larson <Brad_Larson@pmc-sierra.com>
To:	"'bkalthouse@comcast.net'" <bkalthouse@comcast.net>
Cc:	linux-mips@linux-mips.org
Subject: RE: Running RM9000 in SMP mode
Date:	Mon, 31 Jan 2005 10:27:18 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Brad_Larson@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Brad_Larson@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Bryan,

The following are available at ftp.pmc-sierra.com

cross tools: gcc-3.3+ with E9000 core compiler optimizations
 
userland: demo userland, monta-vista based, native compiler does not have E9000 optimizations

kernel snapshots: Yosemite/RM92xx SMP capable for 2.4.21, 2.4.26, 2.6.10

doc: pmon and linux readme and board docs.  www.pmon2000.com for online pmon2000 command reference.

Of course linux-mips.org for kernel sources and status, cvs-web, other userland pointers, all the port bits eventually get there.  The E9000 optimizations were committed to gcc.org, available in gcc-3.4.

Datasheets and docs requiring NDA contact support@pmc-sierra.com or your sales/FAE contact.

--Brad 

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of
> bkalthouse@comcast.net
> Sent: Monday, January 31, 2005 9:22 AM
> To: thomas.petazzoni@enix.org; mlachwani@mvista.com
> Cc: linux-mips@linux-mips.org
> Subject: Re: Running RM9000 in SMP mode
> 
> 
> Hi,
> 
> I am starting a project using a PMC Sierra  RM9222 processor. 
>  Could anyone that has used the RM9200 family please 
> recommend a distribution and tool-chain?  What has been your 
> experience with Linux on this processor?  What secrets and 
> limitations have you found along the way?  I am new to MIPS and SMP.
> 
> Thanks,
> Bryan Althouse 
 
