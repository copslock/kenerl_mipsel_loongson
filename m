Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 18:20:57 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2797 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493548AbZJ2RUu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2009 18:20:50 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ae9c3a50000>; Thu, 29 Oct 2009 09:32:42 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 29 Oct 2009 09:32:38 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 29 Oct 2009 09:32:38 -0700
Message-ID: <4AE9C3A6.1090400@caviumnetworks.com>
Date:	Thu, 29 Oct 2009 09:32:38 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	wuzhangjin@gmail.com
CC:	Richard Sandiford <rdsandiford@googlemail.com>,
	GCC Patches <gcc-patches@gcc.gnu.org>,
	linux-mips@linux-mips.org, Adam Nemet <anemet@caviumnetworks.com>,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] MIPS: Add option to pass return address location to _mcount.
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>	 <1256138686.18347.3039.camel@gandalf.stny.rr.com>	 <1256233679.23653.7.camel@falcon> <4AE0A5BE.8000601@caviumnetworks.com>	 <87y6n36plp.fsf@firetop.home> <4AE232AD.4050308@caviumnetworks.com>	 <87my3htau1.fsf@firetop.home> <4AE5F392.5020405@caviumnetworks.com>	 <87ljiwr0t9.fsf@firetop.home> <1256798674.6448.42.camel@falcon>
In-Reply-To: <1256798674.6448.42.camel@falcon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2009 16:32:38.0569 (UTC) FILETIME=[6DAA6990:01CA58B5]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin wrote:
> Hi,
> 
> On Tue, 2009-10-27 at 21:20 +0000, Richard Sandiford wrote:
> [...]
>> OK with those changes,
> 
> Just applied the above changes, and added one more for not getting the
> ra_fp_offset when -pg is not enabled:
> 
> @@ -9619,6 +9622,9 @@ mips_for_each_saved_gpr_and_fpr (HOST_WIDE_INT
> sp_offset,
>    for (regno = GP_REG_LAST; regno >= GP_REG_FIRST; regno--)
>      if (BITSET_P (cfun->machine->frame.mask, regno - GP_REG_FIRST))
>        {
> +       /* Record the ra offset for use by mips_function_profiler.  */
> +       if (crtl->profile && regno == RETURN_ADDR_REGNUM)
> +         cfun->machine->frame.ra_fp_offset = offset + sp_offset;
>         mips_save_restore_reg (word_mode, regno, offset, fn);
>         offset -= UNITS_PER_WORD;
>        }
> 
> "crtl->profile &&" was added.
> 

I am a little confused.

I don't think your change is needed.  The FUNCTION_PROFILER code is not 
invoked unless -pg is passed.

Were you getting wrong code without your change?  The ra_fp_offset field 
will be unused if -pg is not specified, but its existence shouldn't 
affect code generation.

David Daney
