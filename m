Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 18:17:10 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17080 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493711AbZJVQRE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 18:17:04 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ae0857c0002>; Thu, 22 Oct 2009 09:17:00 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Oct 2009 09:16:25 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Oct 2009 09:16:25 -0700
Message-ID: <4AE08559.40806@caviumnetworks.com>
Date:	Thu, 22 Oct 2009 09:16:25 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	rostedt@goodmis.org
CC:	wuzhangjin@gmail.com, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH -v4 9/9] tracing: add function graph tracer support for
 MIPS
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>	 <96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>	 <5dda13e8e3a9c9dba4bb7179183941bda502604f.1256135456.git.wuzhangjin@gmail.com>	 <af3ec1b5cd06b6f6a461c9fa7d09a51fabccb08d.1256135456.git.wuzhangjin@gmail.com>	 <a6f2959a69b6a77dd32cc36a5c8202f97d524f1e.1256135456.git.wuzhangjin@gmail.com>	 <53bdfdd95ec4fa00d4cc505bb5972cf21243a14d.1256135456.git.wuzhangjin@gmail.com>	 <1256141540.18347.3118.camel@gandalf.stny.rr.com>	 <4ADF38D5.9060100@caviumnetworks.com>	 <1256143568.18347.3169.camel@gandalf.stny.rr.com>	 <4ADF3FE0.5090104@caviumnetworks.com>	 <1256145813.18347.3210.camel@gandalf.stny.rr.com>	 <1256211516.3852.47.camel@falcon>  <4AE08173.7070500@caviumnetworks.com> <1256227916.20866.784.camel@gandalf.stny.rr.com>
In-Reply-To: <1256227916.20866.784.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2009 16:16:25.0743 (UTC) FILETIME=[00ECB1F0:01CA5333]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Steven Rostedt wrote:
> On Thu, 2009-10-22 at 08:59 -0700, David Daney wrote:
> 
>> This is what I was talking about up-thread.  Leaf functions may have no 
>> function prolog.  If you do code scanning you will fail.  While scanning 
>> backwards, there is no way to know when you have entered a new function. 
>>   Looking for function return sequences 'jr ra' doesn't work as there 
>> may be functions with multiple return sites, functions that never 
>> return, or arbitrary data before the function.  I think you have to 
>> force a frame pointer to be established if you want this to work.
> 
> Functions that run off into another function?? I guess the compiler
> could do that, but with -pg enable, I would think is broken.
> 

Use of GCC-4.5's __builtin_unreachable() can lead to this, as well as 
functions that call noreturn functions.


Note to self: Time to resend the __builtin_unreachable() patch set again...

David Daney
