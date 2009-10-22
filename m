Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 20:35:39 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3211 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493439AbZJVSfd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 20:35:33 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ae0a5ea0001>; Thu, 22 Oct 2009 11:35:22 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Oct 2009 11:34:38 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Oct 2009 11:34:38 -0700
Message-ID: <4AE0A5BE.8000601@caviumnetworks.com>
Date:	Thu, 22 Oct 2009 11:34:38 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	wuzhangjin@gmail.com,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Adam Nemet <anemet@caviumnetworks.com>
CC:	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH -v4 4/9] tracing: add static function tracer support for
 MIPS
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>	 <1256138686.18347.3039.camel@gandalf.stny.rr.com> <1256233679.23653.7.camel@falcon>
In-Reply-To: <1256233679.23653.7.camel@falcon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2009 18:34:38.0843 (UTC) FILETIME=[4FFF54B0:01CA5346]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin wrote:
> On Wed, 2009-10-21 at 11:24 -0400, Steven Rostedt wrote:
[...]
>>> +
>>> +NESTED(_mcount, PT_SIZE, ra)
>>> +	RESTORE_SP_FOR_32BIT
>>> +	PTR_LA	t0, ftrace_stub
>>> +	PTR_L	t1, ftrace_trace_function /* please don't use t1 later, safe? */
>> Is t0 and t1 safe for mcount to use? Remember, mcount does not follow
>> the dynamics of C function ABI.
> 
> So, perhaps we can use the saved registers(a0,a1...) instead.
> 

a0..a7 may not always be saved.

You can use at, v0, v1 and all the temporary registers.  Note that for 
the 64-bit ABIs sometimes the names t0-t4 shadow a4-a7.  So for a 64-bit 
kernel, you can use: $1, $2, $3, $12, $13, $14, $15, $24, $25, noting 
that at == $1 and contains the callers ra.  For a 32-bit kernel you can 
add $8, $9, $10, and $11

This whole thing seems a little fragile.

I think it might be a good idea to get input from Richard Sandiford, 
and/or Adam Nemet about this approach (so I add them to the CC).

This e-mail thread starts here:

http://www.linux-mips.org/archives/linux-mips/2009-10/msg00286.html

and here:

http://www.linux-mips.org/archives/linux-mips/2009-10/msg00290.html

David Daney


> Regards!
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
