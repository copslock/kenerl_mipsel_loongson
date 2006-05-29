Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2006 07:58:19 +0200 (CEST)
Received: from wx-out-0102.google.com ([66.249.82.207]:56224 "EHLO
	wx-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133357AbWE2F6H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 May 2006 07:58:07 +0200
Received: by wx-out-0102.google.com with SMTP id t5so324738wxc
        for <linux-mips@linux-mips.org>; Sun, 28 May 2006 22:58:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=s0Mmw+Hp7Ccr6fcNaicm8ua9u+FwlM6tITP87l9itLy4/PWBWGs0riCOaTjkOx3abkLvptBEFrhyyEVvmMZ7bU4Y2wiphuimnUQOXyqkP1t6r3XDHOMwcxukRVYl+djx+ARJhdVqw7xZ3HwGNZu0+eVqH2qf9YUc35Fek3s7i0I=
Received: by 10.70.35.8 with SMTP id i8mr184835wxi;
        Sun, 28 May 2006 22:58:06 -0700 (PDT)
Received: by 10.70.118.5 with HTTP; Sun, 28 May 2006 22:58:06 -0700 (PDT)
Message-ID: <d096a3ee0605282258y210244c7sbdf994d8c075a5e@mail.gmail.com>
Date:	Mon, 29 May 2006 11:28:06 +0530
From:	"Mayuresh Chitale" <mchitale@gmail.com>
To:	linux-mips@linux-mips.org
Subject: oprofile for mips 24k
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <mchitale@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mchitale@gmail.com
Precedence: bulk
X-list: linux-mips

Hi All,

I could compile oprofile on mips 24k. But when running it, I start it
as mentioned in the
oprofile manual ie setting vmlinux path and using opcontrol script, I
see this output:

# ./bin/opcontrol --start
Detected stale lock file. Removing.
Using 2.6+ OProfile kernel interface.
Reading module info.
Using log file /var/lib/oprofile/oprofiled.log
Daemon started.
Profiler running.

But ps -aef shows oprofiled is not running.
# ps -aef
 PID  Uid     VmSize Stat Command
   1 root        228 S   init
   2 root            SWN [ksoftirqd/0]
   3 root            SW< [events/0]
   4 root            SW< [khelper]
   5 root            SW< [kthread]
   6 root            SW< [kblockd/0]
   7 root            SW  [pdflush]
   8 root            SW  [pdflush]
  10 root            SW< [aio/0]
   9 root            SW  [kswapd0]
  11 root            SW< [kseriod]
  12 root            SW< [rpciod/0]
  58 root        396 S   -sh
  59 root        196 S   /sbin/syslogd -n -m 0
  60 root        180 S   /sbin/klogd -n
 266 root        208 R   ps -aef
#

Do we need to do some additional setup / init to get this working?
Any experience/suggestion is welcome.

Thanks,
Mayuresh.
