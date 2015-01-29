Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 22:51:22 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52785 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012253AbbA2VvUvKQbb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 22:51:20 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 970B037566C4B
        for <linux-mips@linux-mips.org>; Thu, 29 Jan 2015 21:51:11 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 29 Jan 2015 21:51:14 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Thu, 29 Jan 2015 21:51:14 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <Paul.Burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: RE: [PATCH RFC v2 68/70] MIPS: kernel: elf: Improve the overall ABI
 and FPU mode checks
Thread-Topic: [PATCH RFC v2 68/70] MIPS: kernel: elf: Improve the overall
 ABI and FPU mode checks
Thread-Index: AQHQMXrA9oeMJlZFEEijQwuHHAdWD5zXtjxg
Date:   Thu, 29 Jan 2015 21:51:13 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320FBCA7C@LEMAIL01.le.imgtec.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
 <1421405389-15512-69-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1421405389-15512-69-git-send-email-markos.chandras@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.159.155]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

> +static inline unsigned get_fp_abi(struct elf32_hdr *ehdr, int in_abi)
>  {
>  	/* If the ABI requirement is provided, simply return that */
> -	if (in_abi != -1)
> +	if (in_abi != MIPS_ABI_FP_UNKNOWN)
>  		return in_abi;
> 
>  	/* If the EF_MIPS_FP64 flag was set, return MIPS_ABI_FP_64 */
>  	if (ehdr->e_flags & EF_MIPS_FP64)
> -		return MIPS_ABI_FP_64;
> +		return MIPS_ABI_FP_OLD_64;

Leonid spotting a bug here, the ehdr given to this function can be either elf32
or elf64.

I suggest finding a way to move this check for EF_MIPS_FP64 into arch_elf_pt_proc
where the elf class is known.  The fpabi can be set to MIPS_ABI_FP_OLD_64 if this
holds true and then overridden if a MIPS_ABIFLAGS segment is found so would go
as indicated below:

+	/* Lets see if this is an O32 ELF */
+	if (ehdr32->e_ident[EI_CLASS] == ELFCLASS32) {
+		/* FR = 1 for N32 */
+		if (ehdr32->e_flags & EF_MIPS_ABI2)
+			state->overall_fp_mode = FP_FR1;
+		else
+			/* Set a good default FPU mode for O32*/
+			state->overall_fp_mode = cpu_has_mips_r6 ?
+				FP_FRE : FP_FR0;

<<here>>

+		if (phdr32->p_type != PT_MIPS_ABIFLAGS)
+			return 0;

Thanks,
Matthew
