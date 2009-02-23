Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2009 18:42:39 +0000 (GMT)
Received: from kuber.nabble.com ([216.139.236.158]:57252 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S20808047AbZBWSmh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Feb 2009 18:42:37 +0000
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LbflD-0002RU-Ck
	for linux-mips@linux-mips.org; Mon, 23 Feb 2009 10:42:35 -0800
Message-ID: <22167417.post@talk.nabble.com>
Date:	Mon, 23 Feb 2009 10:42:35 -0800 (PST)
From:	wurststulle <wurststulle@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: kexec on mips - anyone has it working?
In-Reply-To: <m3d4d9o5z7.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: wurststulle@gmail.com
References: <483BCB75.4050901@wpkg.org> <200805271405.55346.nschichan@freebox.fr> <483C0135.9070203@wpkg.org> <200805271449.45124.nschichan@freebox.fr> <483C4F73.4040909@wpkg.org> <200805291347.05196.nschichan@freebox.fr> <483F0EF3.3060500@wpkg.org> <200805301327.11925.nschichan@freebox.fr> <483FE764.1090901@wpkg.org> <200807011542.29274.nschichan@freebox.fr> <486A6F0D.4070802@wpkg.org> <200807012000.40421.nschichan@freebox.fr> <486A759D.6080803@wpkg.org> <22148789.post@talk.nabble.com> <m3d4d9o5z7.fsf@anduin.mandriva.com>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wurststulle@gmail.com
Precedence: bulk
X-list: linux-mips


hi, thank you for the patch, but there is a mistake, that i can not fix:

+#ifdef CONFIG_CRASH_DUMP
+    if (crashk_res.start != crashk_res.end)
+        reserve_bootmem(crashk_res.start,
+                crashk_res.end - crashk_res.start + 1);
+#endif

the function reserve_bootmem need i think three arguments. while compiling
this error occurs:

arch/mips/kernel/setup.c: In function 'arch_mem_init':
arch/mips/kernel/setup.c:493: error: too few arguments to function
'reserve_bootmem'
make[6]: *** [arch/mips/kernel/setup.o] Error 1

thanks!


Arnaud Patard wrote:
> 
> wurststulle <wurststulle@gmail.com> writes:
> 
> Hi,
> 
>> is there any solution for this, i have the same problem
> 
> What's your exact problem ? It hangs right after saying 'Bye...' ?
> Some monthes ago, I played with the patch from M. Syrchin [ sorry, I don't
> remember if it was on linux-mips or on the kexec list ]. I've made on it
> a small modification (compare the machine_kexec_prepare function in my
> version [1] and the original function) and it was somewhat working on
> Qemu and on my box. It was not perfect but at least with a very minimal
> test system, it was working. Maybe you can try it and see if it works
> for you too. Depending on your platform, you may have to define machine
> specific hooks too.
> 
> Regards,
> Arnaud
> 
> [1] http://people.mandriva.com/~apatard/kexec_mips.patch
> 
> 
> 

-- 
View this message in context: http://www.nabble.com/kexec-on-mips---anyone-has-it-working--tp17485898p22167417.html
Sent from the linux-mips main mailing list archive at Nabble.com.
