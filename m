Received:  by oss.sgi.com id <S553695AbRBGTDQ>;
	Wed, 7 Feb 2001 11:03:16 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:23282 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553671AbRBGTC4>;
	Wed, 7 Feb 2001 11:02:56 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f17IxD818266;
	Wed, 7 Feb 2001 10:59:13 -0800
Message-ID: <3A819B80.7946F866@mvista.com>
Date:   Wed, 07 Feb 2001 11:01:20 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Florian Lohoff <flo@rfc822.org>
CC:     linux-mips@oss.sgi.com, ralf@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
References: <20010207144857.B24485@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Florian Lohoff wrote:
> 
> Hi,
> i would like to know the way to go for NON-FPU cpus - Currently its
> partly an Compile Time thing and partly run time config.
> 

Flo,

My vote is to use config option.

Moving forward I see MIPS mainly used in embedded systems.  I think need of
using the same kernel binary for multiple CPUs is rare, especially for the
"same" CPU with or without FPU.  Therefore having run-time detection is a
waste of effort.  Half-config-half-runtime solution is pretty messy too.

For CPUs with the same PrID that may or may not have a FPU, we can add an
optional FPU selection in the config.in file.

To be complete, I probably would add a check for the existence of FPU, if we
can infer from PrID, when FPU config option is enabled.

Jun
