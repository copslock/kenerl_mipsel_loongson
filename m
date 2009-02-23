Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2009 21:29:05 +0000 (GMT)
Received: from mx1.moondrake.net ([212.85.150.166]:11211 "EHLO
	mx1.mandriva.com") by ftp.linux-mips.org with ESMTP
	id S20808100AbZBWV3D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Feb 2009 21:29:03 +0000
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id EA290274006; Mon, 23 Feb 2009 22:29:01 +0100 (CET)
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id D4A92274002;
	Mon, 23 Feb 2009 22:28:58 +0100 (CET)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id 0D64682816;
	Mon, 23 Feb 2009 22:29:38 +0100 (CET)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id 70AD9FF855;
	Mon, 23 Feb 2009 22:29:00 +0100 (CET)
From:	Arnaud Patard <apatard@mandriva.com>
To:	wurststulle <wurststulle@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: kexec on mips - anyone has it working?
References: <483BCB75.4050901@wpkg.org>
	<200805271405.55346.nschichan@freebox.fr> <483C0135.9070203@wpkg.org>
	<200805271449.45124.nschichan@freebox.fr> <483C4F73.4040909@wpkg.org>
	<200805291347.05196.nschichan@freebox.fr> <483F0EF3.3060500@wpkg.org>
	<200805301327.11925.nschichan@freebox.fr> <483FE764.1090901@wpkg.org>
	<200807011542.29274.nschichan@freebox.fr> <486A6F0D.4070802@wpkg.org>
	<200807012000.40421.nschichan@freebox.fr> <486A759D.6080803@wpkg.org>
	<22148789.post@talk.nabble.com> <m3d4d9o5z7.fsf@anduin.mandriva.com>
	<22167417.post@talk.nabble.com>
Organization: Mandriva
Date:	Mon, 23 Feb 2009 22:29:00 +0100
In-Reply-To: <22167417.post@talk.nabble.com> (wurststulle@gmail.com's message of "Mon, 23 Feb 2009 10:42:35 -0800 (PST)")
Message-ID: <m3iqn0n8pv.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

wurststulle <wurststulle@gmail.com> writes:

> hi, thank you for the patch, but there is a mistake, that i can not fix:
>
> +#ifdef CONFIG_CRASH_DUMP
> +    if (crashk_res.start != crashk_res.end)
> +        reserve_bootmem(crashk_res.start,
> +                crashk_res.end - crashk_res.start + 1);
> +#endif
>
> the function reserve_bootmem need i think three arguments. while compiling
> this error occurs:
>
> arch/mips/kernel/setup.c: In function 'arch_mem_init':
> arch/mips/kernel/setup.c:493: error: too few arguments to function
> 'reserve_bootmem'

oops. Adding BOOTMEM_DEFAULT as 3rd parameter should cure the problem I
think.


Arnaud
