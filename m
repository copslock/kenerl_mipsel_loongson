Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 06:21:45 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.185]:62086 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038697AbXBBGVl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 06:21:41 +0000
Received: by nf-out-0910.google.com with SMTP id l24so1049159nfc
        for <linux-mips@linux-mips.org>; Thu, 01 Feb 2007 22:20:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=pRuC6xlKpRlsBgNl+a7loxRjRKohRMaE919k9bV+Zs8/oKHd3ZQKz8hshd60xth8qW+uZntTapqvov2eU6mtFhQWRyzfZRloU6RZRGO+kVA0GUEnFOAge3joCDsFOl0cRCbJPVYl/P7WppHJz5xiJwHIuBnml1Ux8bhE9vNr7tI=
Received: by 10.82.136.4 with SMTP id j4mr1072778bud.1170397240062;
        Thu, 01 Feb 2007 22:20:40 -0800 (PST)
Received: by 10.82.126.7 with HTTP; Thu, 1 Feb 2007 22:20:39 -0800 (PST)
Message-ID: <1af677f80702012220w4c2bd04dj5ed9cdf366ea23c5@mail.gmail.com>
Date:	Fri, 2 Feb 2007 14:20:39 +0800
From:	"Dequan Yang" <ydq.mips@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Kernel system call problem
Cc:	qit@haier-ic.com
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_20906_15207972.1170397239963"
Return-Path: <ydq.mips@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ydq.mips@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_20906_15207972.1170397239963
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm porting Linux 2.6.12 to a MIPS 4KEC based SOC.
I have done some essential setup work,including CPU setup,
board setup, interrupt initialization, page table setup, etc.
In breaf, it can go through the kernel startup code in "main.c"
until it try to open "/sbin/init " file, here is the source code:

if (execute_command)
        run_init_process(execute_command);

    run_init_process("/sbin/init");
    run_init_process("/etc/init");
    run_init_process("/bin/init");
    run_init_process("/bin/sh");

" run_init_process(execute_command);"calls "execve "
which is a system call, then the kernel stopped without any information.
In trap_init( ), it has already installed exception vector,and I cann't
find the problem, can anyone give me some advices?
Thank you very much!

YDQ

------=_Part_20906_15207972.1170397239963
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I&#39;m porting Linux 2.6.12 to a MIPS 4KEC based SOC.<br>I have done some essential setup work,including CPU setup,<br>board setup, interrupt initialization, page table setup, etc.<br>In breaf, it can go through the kernel startup code in &quot;
main.c&quot;<br>until it try to open &quot;/sbin/init &quot; file, here is the source code:<br><br>if (execute_command)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; run_init_process(execute_command);<br><br>&nbsp;&nbsp;&nbsp; run_init_process(&quot;/sbin/init&quot;);<br>
&nbsp;&nbsp;&nbsp; run_init_process(&quot;/etc/init&quot;);<br>&nbsp;&nbsp;&nbsp; run_init_process(&quot;/bin/init&quot;);<br>&nbsp;&nbsp;&nbsp; run_init_process(&quot;/bin/sh&quot;);<br><br>&quot; run_init_process(execute_command);&quot;calls &quot;execve &quot;<br>
which is a system call, then the kernel stopped without any information.<br>In trap_init( ), it has already installed exception vector,and I cann&#39;t<br>find the problem, can anyone give me some advices?<br>Thank you very much!
<br><br>YDQ<br><br>

------=_Part_20906_15207972.1170397239963--
