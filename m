Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4A6Bd322948
	for linux-mips-outgoing; Wed, 9 May 2001 23:11:39 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4A6BdF22945
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 23:11:39 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA05201;
	Wed, 9 May 2001 23:11:45 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA22967;
	Wed, 9 May 2001 23:11:42 -0700 (PDT)
Received: from mips.com (coppccl [172.17.27.2])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id IAA08099;
	Thu, 10 May 2001 08:10:46 +0200 (MEST)
Message-ID: <3AFA3101.B86D47A1@mips.com>
Date: Thu, 10 May 2001 08:11:13 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Nguyen <tnguyen@drawbridge3.simpletech.com>
CC: linux-mips@oss.sgi.com
Subject: Re: MIPS 5Kc
References: <4.3.2.7.2.20010509095019.00a90830@sti-sun4>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

There is no module support in the pre-compiled kernel images on the MIPS FTP
site, but you can just take the sources and recompile the kernel with module
support enabled.

/Carsten

Tim Nguyen wrote:

> Hello all,
>
> Does anybody have any comments concerning the Alta board with a MIPS 5Kc
> running Linux.  I hear that Linux modules aren't fully supported in their
> reference 2.2.12 kernel.  Are there any other known issues with that kernel
> -- how about the 2.4.1 kernel?  Any help will be greatly appreciated.
> Regards,
> Tim Nguyen
>
> ******************************************************
> Tim Nguyen
> Sr. Software Engineer
> SimpleTech
> 3001 Daimler Street
> Santa Ana, CA  92705
> PH:     949-476-1180 x8838
> FX:     949-851-2398
> tnguyen@simpletech.com  www.simpletech.com
> ******************************************************
