Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2008 13:42:09 +0100 (BST)
Received: from mx03.syneticon.net ([87.79.32.166]:21514 "HELO
	mx03.syneticon.net") by ftp.linux-mips.org with SMTP
	id S20044060AbYE0MmH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 May 2008 13:42:07 +0100
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by mx03.syneticon.net (Postfix) with ESMTP id C9F9895A1;
	Tue, 27 May 2008 14:42:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mx03.syneticon.net
Received: from mx03.syneticon.net ([192.168.113.4])
	by localhost (mx03.syneticon.net [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id XmSYyQjUzaBR; Tue, 27 May 2008 14:41:57 +0200 (CEST)
Received: from [192.168.10.145] (koln-4d0b6fdf.pool.mediaWays.net [77.11.111.223])
	by mx03.syneticon.net (Postfix) with ESMTP;
	Tue, 27 May 2008 14:41:56 +0200 (CEST)
Message-ID: <483C0135.9070203@wpkg.org>
Date:	Tue, 27 May 2008 14:40:21 +0200
From:	Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 2.0.0.12 (X11/20080305)
MIME-Version: 1.0
To:	Nicolas Schichan <nschichan@freebox.fr>
CC:	linux-mips@linux-mips.org,
	Kexec Mailing List <kexec@lists.infradead.org>
Subject: Re: kexec on mips - anyone has it working?
References: <483BCB75.4050901@wpkg.org> <200805271405.55346.nschichan@freebox.fr>
In-Reply-To: <200805271405.55346.nschichan@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mangoo@wpkg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mangoo@wpkg.org
Precedence: bulk
X-list: linux-mips

Nicolas Schichan schrieb:

>>  Ideas? Ways to debug it?
> 
> I am using a 2.6.20 kernel on a 32bit mips platform and it is working 
> fine. however I am using this userland code (make CROSS=$(your 
> cross-compiler prefix) to compile it) :
> 
> http://chac.le-poulpe.net/~nico/kexec.tar.gz
> 
> Could you try to add the following line in machine_kexec.c, just before 
> jumping to the trampoline:
> 
>        change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);

And machine_kexec.c file is in where? It's not in the above one, it's 
not in kexec-tools-testing-20080324?


-- 
Tomasz Chmielewski
http://wpkg.org
