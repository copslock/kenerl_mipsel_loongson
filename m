Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Feb 2009 16:50:35 +0000 (GMT)
Received: from kuber.nabble.com ([216.139.236.158]:47782 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S21103522AbZBVQuc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Feb 2009 16:50:32 +0000
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LbHX9-0006Bo-0D
	for linux-mips@linux-mips.org; Sun, 22 Feb 2009 08:50:28 -0800
Message-ID: <22148789.post@talk.nabble.com>
Date:	Sun, 22 Feb 2009 08:50:27 -0800 (PST)
From:	wurststulle <wurststulle@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: kexec on mips - anyone has it working?
In-Reply-To: <486A759D.6080803@wpkg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: wurststulle@gmail.com
References: <483BCB75.4050901@wpkg.org> <200805271405.55346.nschichan@freebox.fr> <483C0135.9070203@wpkg.org> <200805271449.45124.nschichan@freebox.fr> <483C4F73.4040909@wpkg.org> <200805291347.05196.nschichan@freebox.fr> <483F0EF3.3060500@wpkg.org> <200805301327.11925.nschichan@freebox.fr> <483FE764.1090901@wpkg.org> <200807011542.29274.nschichan@freebox.fr> <486A6F0D.4070802@wpkg.org> <200807012000.40421.nschichan@freebox.fr> <486A759D.6080803@wpkg.org>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wurststulle@gmail.com
Precedence: bulk
X-list: linux-mips


is there any solution for this, i have the same problem

mangoo wrote:
> 
> Nicolas Schichan schrieb:
> 
>> +	printk("image->start = %lx", image->start);
>> +
>>  	reboot_code_buffer =
>>  	  (unsigned long)page_address(image->control_code_page);
> 
> # kexec -e
> b44: eth0: powering down PHY
> Starting new kernel
> image->start = 304000Will call new kernel at 00304000
> Bye ...
> 
> 
> 
> -- 
> Tomasz Chmielewski
> http://wpkg.org
> 
> 
> 

-- 
View this message in context: http://www.nabble.com/kexec-on-mips---anyone-has-it-working--tp17485898p22148789.html
Sent from the linux-mips main mailing list archive at Nabble.com.
