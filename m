Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 13:49:03 +0200 (CEST)
Received: from Smtp1.Lantiq.com ([195.219.66.200]:7895 "EHLO smtp1.lantiq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832655Ab3JHLtA6Vvwa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Oct 2013 13:49:00 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqAEAMfwU1IKQLW9/2dsb2JhbABZhBHBIoE2dIIlAQEBBCdSEAIBCA0IDSQyJQIEAQ0FCMJXjxExB4MfgQQDiQGVXY5Hgio
X-IronPort-AV: E=McAfee;i="5400,1158,7221"; a="2411853"
Received: from unknown (HELO MUCSVECH044.lantiq.com) ([10.64.181.189])
  by smtp1.lantiq.com with ESMTP; 08 Oct 2013 13:48:55 +0200
Received: from MUCSE039.lantiq.com ([169.254.3.108]) by MUCSVECH044.lantiq.com
 ([10.64.181.189]) with mapi id 14.02.0247.003; Tue, 8 Oct 2013 13:48:55 +0200
From:   <thomas.langer@lantiq.com>
To:     <markos.chandras@imgtec.com>, <linux-mips@linux-mips.org>
CC:     <Leonid.Yegoshin@imgtec.com>
Subject: RE: [PATCH] MIPS: Print correct PC in trace dump after NMI exception
Thread-Topic: [PATCH] MIPS: Print correct PC in trace dump after NMI
 exception
Thread-Index: AQHOxBshqs4+SS5ZNkq49qTjFbXjeJnqr81A
Date:   Tue, 8 Oct 2013 11:48:54 +0000
Message-ID: <593AEF6C47F46446852B067021A273D6D990182F@MUCSE039.lantiq.com>
References: <1381232371-25017-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1381232371-25017-1-git-send-email-markos.chandras@imgtec.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.175.92]
x-tm-as-product-ver: SMEX-10.0.0.1412-7.000.1014-20204.006
x-tm-as-result: No--39.117600-0.000000-31
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <thomas.langer@lantiq.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38262
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

Hello Markos,

Markos Chandras wrote on 2013-10-08:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> 
> An NMI exception delivered from YAMON delivers the PC in ErrorPC
> instead of EPC. It's also necessary to clear the Status.BEV
> bit for the page fault exception handler to work properly.
> 
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---


> @@ -1506,10 +1511,14 @@ int register_nmi_notifier(struct notifier_block
> *nb)
> 
>  void __noreturn nmi_exception_handler(struct pt_regs *regs)
>  {
> +	char str[100];
> +
>  	raw_notifier_call_chain(&nmi_chain, 0, regs);
>  	bust_spinlocks(1);
> -	printk("NMI taken!!!!\n");
> -	die("NMI", regs);
> +	snprintf(str, 100, "CPU%d NMI taken, CP0_EPC=%lx\n",
> +		 smp_processor_id(), regs->cp0_epc);
> +	regs->cp0_epc = read_c0_errorepc();

If this is a YAMON specific fix, why is it done in a common file?

> +	die(str, regs);
>  }
>  
>  #define VECTORSPACING 0x100	/* for EI/VI mode */

Best Regards,
Thomas
