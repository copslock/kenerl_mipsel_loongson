Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2004 21:56:55 +0100 (BST)
Received: from [IPv6:::ffff:206.181.163.222] ([IPv6:::ffff:206.181.163.222]:3198
	"EHLO alfalfa.fortresstech.com") by linux-mips.org with ESMTP
	id <S8225474AbUC3U4y>; Tue, 30 Mar 2004 21:56:54 +0100
Received: from audev ([172.26.52.2]) by alfalfa.fortresstech.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 30 Mar 2004 15:56:49 -0500
Subject: Re: mips-linux cross-compiler
From: Steve Lazaridis <slaz@fortresstech.com>
Reply-To: slaz@fortresstech.com
To: Ronen Shitrit <rshitrit@il.marvell.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <40692540.9090800@il.marvell.com>
References: <40692540.9090800@il.marvell.com>
Content-Type: text/plain
Organization: Fortress Technologies
Message-Id: <1080680258.10476.4.camel@gigada>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 15:57:38 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Mar 2004 20:56:49.0427 (UTC) FILETIME=[853B2630:01C41699]
Return-Path: <SLaz@fortresstech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: slaz@fortresstech.com
Precedence: bulk
X-list: linux-mips

On Tue, 2004-03-30 at 02:44, Ronen Shitrit wrote:
> Hi
> 
> I have a mips-linux cross compiler on i686 host, which is using gcc 2.95.3 .
> This compiler doesn't support the MIPS 4 Instruction Set,
> So I'm trying to build a new mips-linux cross compiler using any gcc 3.3/2.*
> but without any luck,
> Did anyone succeed to build such a cross compiler??
> which gcc and binutils version did you use??
> what are the configure flags you used??
> Did you used any special steps?? (except for configure ... , make, make 
> install )
> 
> Thanks a lot

I've successfully built toolchains for mipsel using 
http://www.kegel.com/crosstool/

It's a great tool, makes crosstoolchains building a piece of cake.
The toolchain was built for gcc-3.3.2 and glibc-2.3.2

hope this helps..

cheers,

-- 
Steve Lazaridis
Software Engineer
Fortress Technologies
slaz@fortresstech.com | Ph:813.288.7388 x115
