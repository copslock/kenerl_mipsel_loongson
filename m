Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2006 10:52:12 +0000 (GMT)
Received: from krt.tmd.ns.ac.yu ([147.91.177.65]:2055 "HELO krt.neobee.net")
	by ftp.linux-mips.org with SMTP id S20038501AbWKVKwI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Nov 2006 10:52:08 +0000
Received: from localhost (localhost [127.0.0.1])
	by krt.neobee.net (Postfix) with ESMTP id 42BD1E5378
	for <linux-mips@linux-mips.org>; Wed, 22 Nov 2006 11:52:03 +0100 (CET)
Received: from krt.neobee.net ([127.0.0.1])
 by localhost (krt.neobee.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 25475-07 for <linux-mips@linux-mips.org>;
 Wed, 22 Nov 2006 11:52:01 +0100 (CET)
Received: from had (unknown [192.168.0.92])
	by krt.neobee.net (Postfix) with ESMTP id 3D88AE5377
	for <linux-mips@linux-mips.org>; Wed, 22 Nov 2006 11:52:01 +0100 (CET)
From:	"Mile Davidovic" <Mile.Davidovic@micronasnit.com>
To:	<linux-mips@linux-mips.org>
Subject: RE: How to build the glibc for MIPS?
Date:	Wed, 22 Nov 2006 11:54:19 +0100
Message-ID: <005501c70e24$8f7a7fd0$5c00a8c0@niit.micronasnit.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AcbjWprI+4gIydQbSFat1vNz8Pp3SAqybeKg
In-Reply-To: <20060929000233.GG3394@linux-mips.org>
Return-Path: <Mile.Davidovic@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Mile.Davidovic@micronasnit.com
Precedence: bulk
X-list: linux-mips

Hello to all,
is it possible to get quick howto for building glibc? 

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-
> mips.org] On Behalf Of Ralf Baechle
> Sent: Friday, September 29, 2006 02:03
> To: Neo
> Cc: linux-mips@linux-mips.org
> Subject: Re: How to build the glibc for MIPS?
> 
> On Thu, Sep 28, 2006 at 05:58:03PM -0500, Neo wrote:
> 
> > I have successfully built the cross toolchain excluding glibc following
> > the steps of www.linux-mips.org. Now, I am wondering how to build the
> > glibc for MIPS. The websites provided by linux-mips are not accessible
> > any more or they cannot be built successfully.
> 
> Are you refering to the instructions in the old MIPS-HOWTO document?
> I've asked LDP to remove it because it was so obsolete.  Building glibc
> has fortunately become much easier these days; it's mostly a question of
> getting the build environment right.
> 
>   Ralf
