Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 14:57:30 +0200 (CEST)
Received: from Smtp1.Lantiq.com ([195.219.66.200]:13795 "EHLO smtp1.lantiq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868728Ab3JHM5YBe5gL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Oct 2013 14:57:24 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqEEAAAAVFIKQLW9/2dsb2JhbABZgz9SwSKBNXSCJQEBAQMBJ1IFCwIBCA0LCiQyJQIEDgUIh3gSukSPETEHFoMJgQQDiQGVXY5Hgio
X-IronPort-AV: E=McAfee;i="5400,1158,7221"; a="2412263"
Received: from unknown (HELO MUCSVECH044.lantiq.com) ([10.64.181.189])
  by smtp1.lantiq.com with ESMTP; 08 Oct 2013 14:57:17 +0200
Received: from MUCSE039.lantiq.com ([169.254.3.108]) by MUCSVECH044.lantiq.com
 ([10.64.181.189]) with mapi id 14.02.0247.003; Tue, 8 Oct 2013 14:57:18 +0200
From:   <thomas.langer@lantiq.com>
To:     <ralf@linux-mips.org>
CC:     <markos.chandras@imgtec.com>, <linux-mips@linux-mips.org>,
        <Leonid.Yegoshin@imgtec.com>
Subject: RE: [PATCH] MIPS: Print correct PC in trace dump after NMI exception
Thread-Topic: [PATCH] MIPS: Print correct PC in trace dump after NMI
 exception
Thread-Index: AQHOxBshqs4+SS5ZNkq49qTjFbXjeJnqr81A///qaYCAACLJ8A==
Date:   Tue, 8 Oct 2013 12:57:17 +0000
Message-ID: <593AEF6C47F46446852B067021A273D6D9901A5C@MUCSE039.lantiq.com>
References: <1381232371-25017-1-git-send-email-markos.chandras@imgtec.com>
 <593AEF6C47F46446852B067021A273D6D990182F@MUCSE039.lantiq.com>
 <20131008122905.GJ1615@linux-mips.org>
In-Reply-To: <20131008122905.GJ1615@linux-mips.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.175.92]
x-tm-as-product-ver: SMEX-10.0.0.1412-7.000.1014-20204.006
x-tm-as-result: No--42.748300-0.000000-31
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <thomas.langer@lantiq.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.langer@lantiq.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello Ralf,

Ralf Baechle wrote on 2013-10-08:

> On Tue, Oct 08, 2013 at 11:48:54AM +0000, thomas.langer@lantiq.com wrote:
> 
>>>  void __noreturn nmi_exception_handler(struct pt_regs *regs)
>>>  {
>>> +	char str[100];
>>> +
>>>  	raw_notifier_call_chain(&nmi_chain, 0, regs);
>>>  	bust_spinlocks(1);
>>> -	printk("NMI taken!!!!\n");
>>> -	die("NMI", regs);
>>> +	snprintf(str, 100, "CPU%d NMI taken, CP0_EPC=%lx\n",
>>> +		 smp_processor_id(), regs->cp0_epc);
>>> +	regs->cp0_epc = read_c0_errorepc();
>> 
>> If this is a YAMON specific fix, why is it done in a common file?
> 
> The installation of an NMI handler is platform specific - this handler
> however in all its simplicity is generic - or at least trying to.
> 
> The NMI on MIPS is notoriously hard to use.  The vectors is pointing to
> the boot ROM so firmware first gets its grubby hands on a fresh NMI and
> on most systems it'll do the firmware equivalent of a panic or reset
> the system outright.  If that's still working - it's about the worst
> tested functionality of firmware ...

I know, I am working on a chip which has working wrapper implemented in its bootrom:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/lantiq/falcon/prom.c#n90
Therefore I was triggered by the keyword NMI ;-)

So if this has nothing to do with YAMON and is some generic NMI specific fix:
Acked-By: Thomas Langer <thomas.langer@lantiq.com>

> 
>   Ralf

Best Regards,
Thomas
