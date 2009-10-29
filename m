Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 17:27:30 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19403 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493549AbZJ2Q1W (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2009 17:27:22 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ae9c1d90000>; Thu, 29 Oct 2009 09:25:02 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 29 Oct 2009 09:24:58 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 29 Oct 2009 09:24:58 -0700
Message-ID: <4AE9C1DA.4040406@caviumnetworks.com>
Date:	Thu, 29 Oct 2009 09:24:58 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Wu Zhangjin <wuzhangjin@gmail.com>
CC:	Richard Sandiford <rdsandiford@googlemail.com>,
	GCC Patches <gcc-patches@gcc.gnu.org>,
	linux-mips@linux-mips.org, Adam Nemet <anemet@caviumnetworks.com>,
	rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] MIPS: Add option to pass return address location to _mcount
References: <1256804045-31158-1-git-send-email-wuzhangjin@gmail.com>
In-Reply-To: <1256804045-31158-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2009 16:24:58.0375 (UTC) FILETIME=[5B5E6170:01CA58B4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
[...]
> 
> 2009-10-23  David Daney  <ddaney@caviumnetworks.com>
> 
>         * doc/invoke.texi (mmcount-ra-address): Document new command line option.
>         * config/mips/mips.opt (config/mips/mips.opt): New option.
>         * config/mips/mips-protos.h (mips_function_profiler): Declare new
>         function.
>         * config/mips/mips.c (struct mips_frame_info): Add ra_fp_offset member.
>         (mips_for_each_saved_gpr_and_fpr): Set ra_fp_offset.
>         (mips_function_profiler): Moved from FUNCTION_PROFILER, and rewritten.
>         * config/mips/mips.h (FUNCTION_PROFILER): Body of macro moved to
>         mips_function_profiler.
> 
> Tested-by: Wu Zhangjin <wuzhangjin@gmail.com>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Two things:

1) This is a GCC patch.  GCC doesn't use 'Signed-off-by'.

2) You cannot add my 'Signed-off-by', only I can do that.  I would 
request that you remove it.

Thanks,
David Daney
