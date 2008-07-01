Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2008 19:21:42 +0100 (BST)
Received: from mx03.syneticon.net ([87.79.32.166]:56836 "EHLO
	mx03.syneticon.net") by ftp.linux-mips.org with ESMTP
	id S32706994AbYGASVf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Jul 2008 19:21:35 +0100
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by mx03.syneticon.net (Postfix) with ESMTP id 5AEB29601;
	Tue,  1 Jul 2008 20:21:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mx03.syneticon.net
Received: from mx03.syneticon.net ([192.168.113.4])
	by localhost (mx03.syneticon.net [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id BRg5Zo+0PuhB; Tue,  1 Jul 2008 20:21:19 +0200 (CEST)
Received: from [192.168.10.145] (koln-4d0b69d5.pool.mediaWays.net [77.11.105.213])
	by mx03.syneticon.net (Postfix) with ESMTP;
	Tue,  1 Jul 2008 20:21:19 +0200 (CEST)
Message-ID: <486A759D.6080803@wpkg.org>
Date:	Tue, 01 Jul 2008 20:21:17 +0200
From:	Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 2.0.0.12 (X11/20080305)
MIME-Version: 1.0
To:	Nicolas Schichan <nschichan@freebox.fr>
CC:	kexec@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: kexec on mips - anyone has it working?
References: <483BCB75.4050901@wpkg.org> <200807011542.29274.nschichan@freebox.fr> <486A6F0D.4070802@wpkg.org> <200807012000.40421.nschichan@freebox.fr>
In-Reply-To: <200807012000.40421.nschichan@freebox.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mangoo@wpkg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mangoo@wpkg.org
Precedence: bulk
X-list: linux-mips

Nicolas Schichan schrieb:

> +	printk("image->start = %lx", image->start);
> +
>  	reboot_code_buffer =
>  	  (unsigned long)page_address(image->control_code_page);

# kexec -e
b44: eth0: powering down PHY
Starting new kernel
image->start = 304000Will call new kernel at 00304000
Bye ...



-- 
Tomasz Chmielewski
http://wpkg.org
