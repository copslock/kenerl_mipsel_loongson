Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jul 2009 00:14:55 +0200 (CEST)
Received: from gateway10.websitewelcome.com ([69.93.243.28]:38334 "HELO
	gateway10.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1492291AbZGBWOt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 3 Jul 2009 00:14:49 +0200
Received: (qmail 22428 invoked from network); 2 Jul 2009 22:14:37 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway10.websitewelcome.com with SMTP; 2 Jul 2009 22:14:37 -0000
Received: from 216-239-45-4.google.com ([216.239.45.4]:31919 helo=epiktistes.mtv.corp.google.com)
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1MMUSY-0003U7-AQ; Thu, 02 Jul 2009 17:08:50 -0500
Message-ID: <4A4D2FF2.8080408@paralogos.com>
Date:	Thu, 02 Jul 2009 15:08:50 -0700
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	"Gandham, Raghu" <raghu@mips.com>
CC:	linux-mips@linux-mips.org, "Dearman, Chris" <chris@mips.com>
Subject: Re: [PATCH 15/15] Do not rely on the initial state of TC/VPE bindings
 when doing cross VPE writes
References: <20090702023938.23268.65453.stgit@linux-raghu> <20090702024331.23268.98671.stgit@linux-raghu> <4A4C314B.2070907@paralogos.com> <94BD67F8AF3ED34FA362C662BA1F12C503BED88E@MTVEXCHANGE.mips.com>
In-Reply-To: <94BD67F8AF3ED34FA362C662BA1F12C503BED88E@MTVEXCHANGE.mips.com>
Content-Type: multipart/alternative;
 boundary="------------040608050003040609020009"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040608050003040609020009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gandham, Raghu wrote:
>   
>> -----Original Message-----
>> From: Kevin D. Kissell [mailto:kevink@paralogos.com]
>> Sent: Wednesday, July 01, 2009 9:02 PM
>> To: Gandham, Raghu
>> Cc: linux-mips@linux-mips.org; Dearman, Chris
>> Subject: Re: [PATCH 15/15] Do not rely on the initial state of TC/VPE
>> bindings when doing cross VPE writes
>>
>> Note that, regardless of the reset state, smtc_configure_tlb() should
>> have at least temporarily bound TC 1 to VPE1, which may be why this
>> never seemed to be a problem on the 34K.  If one wants to support
>> designs with more than 2 VPEs, then this is probably one of the things
>> that needs to be fixed.  That having been said, rather than adding a
>> usually-redundant write_vpe_c0_vpeconf0() in that clause, wouldn't it
>>     
> be
>   
>> cleaner to just move the MVP setting from the top of the loop to the
>> point in the loop just after the TCs have been bound to the VPE in
>> question, i.e.,
>>
>>  454                 if (slop) {
>>  455                         if (tc != 0) {
>>  456                                 smtc_tc_setup(vpe,tc, cpu);
>>  457                                 cpu++;
>>  458                         }
>>  459                         printk(" %d", tc);
>>  460                         tc++;
>>  461                         slop--;
>>  462                 }
>>
>>                         write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() |
>> VPECONF0_MVP);
>>
>>  463                 if (vpe != 0) {
>>  464                         /*
>>  465                          * Clear any stale software interrupts
>>     
> from
>   
>> VPE's Cause
>>  466                          */
>>
>> This should definitely be OK for a 34K, because it's being executed by
>> TC0 in VPE0 and the reset state of VPE0 has MVP set.  If it weren't,
>> smtc_configure_tlb() would have failed.
>>
>>           Regards,
>>
>>           Kevin K.
>>     
>
>
> I will resend this patch with your suggestion.
>
> Thanks,
> Raghu
>   
Just make sure it works, first!  ;o)  I'm thousands of miles away from 
my build/test systems.

          Regards,

          Kevn K.

--------------040608050003040609020009
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Gandham, Raghu wrote:
<blockquote
 cite="mid:94BD67F8AF3ED34FA362C662BA1F12C503BED88E@MTVEXCHANGE.mips.com"
 type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">-----Original Message-----
From: Kevin D. Kissell [<a class="moz-txt-link-freetext" href="mailto:kevink@paralogos.com">mailto:kevink@paralogos.com</a>]
Sent: Wednesday, July 01, 2009 9:02 PM
To: Gandham, Raghu
Cc: <a class="moz-txt-link-abbreviated" href="mailto:linux-mips@linux-mips.org">linux-mips@linux-mips.org</a>; Dearman, Chris
Subject: Re: [PATCH 15/15] Do not rely on the initial state of TC/VPE
bindings when doing cross VPE writes

Note that, regardless of the reset state, smtc_configure_tlb() should
have at least temporarily bound TC 1 to VPE1, which may be why this
never seemed to be a problem on the 34K.  If one wants to support
designs with more than 2 VPEs, then this is probably one of the things
that needs to be fixed.  That having been said, rather than adding a
usually-redundant write_vpe_c0_vpeconf0() in that clause, wouldn't it
    </pre>
  </blockquote>
  <pre wrap=""><!---->be
  </pre>
  <blockquote type="cite">
    <pre wrap="">cleaner to just move the MVP setting from the top of the loop to the
point in the loop just after the TCs have been bound to the VPE in
question, i.e.,

 454                 if (slop) {
 455                         if (tc != 0) {
 456                                 smtc_tc_setup(vpe,tc, cpu);
 457                                 cpu++;
 458                         }
 459                         printk(" %d", tc);
 460                         tc++;
 461                         slop--;
 462                 }

                        write_vpe_c0_vpeconf0(read_vpe_c0_vpeconf0() |
VPECONF0_MVP);

 463                 if (vpe != 0) {
 464                         /*
 465                          * Clear any stale software interrupts
    </pre>
  </blockquote>
  <pre wrap=""><!---->from
  </pre>
  <blockquote type="cite">
    <pre wrap="">VPE's Cause
 466                          */

This should definitely be OK for a 34K, because it's being executed by
TC0 in VPE0 and the reset state of VPE0 has MVP set.  If it weren't,
smtc_configure_tlb() would have failed.

          Regards,

          Kevin K.
    </pre>
  </blockquote>
  <pre wrap=""><!---->

I will resend this patch with your suggestion.

Thanks,
Raghu
  </pre>
</blockquote>
Just make sure it works, first!&nbsp; ;o)&nbsp; I'm thousands of miles away from
my build/test systems.<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Regards,<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Kevn K.<br>
</body>
</html>

--------------040608050003040609020009--
