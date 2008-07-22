Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2008 23:01:47 +0100 (BST)
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:16308 "EHLO
	pd2mo1so-dmz.prod.shaw.ca") by ftp.linux-mips.org with ESMTP
	id S20026335AbYGVWBp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Jul 2008 23:01:45 +0100
Received: from pd2ml1so-ssvc.prod.shaw.ca ([10.0.141.139])
  by pd2mo1so-svcs.prod.shaw.ca with ESMTP; 22 Jul 2008 16:01:42 -0600
X-Cloudmark-SP-Filtered: true
X-Cloudmark-SP-Result: v=1.0 c=0 a=0qclRctcRgEnTNXAcOgA:9 a=nP7dw-zrc_IGmPUWUCcA:7 a=T3_prn14nlRHK8Y1c6q-vK293qAA:4 a=ON23U-DKQxkA:10 a=Tzxj9Ku9kecA:10
Received: from s0106000d88c2e56e.cg.shawcable.net (HELO localhost.localdomain) ([70.73.70.241])
  by pd2ml1so-dmz.prod.shaw.ca with ESMTP; 22 Jul 2008 16:01:42 -0600
Message-ID: <488657E5.8080003@aksysnetworks.com>
Date:	Tue, 22 Jul 2008 15:57:57 -0600
From:	Mandeep Ahuja <ahuja@aksysnetworks.com>
User-Agent: Thunderbird 2.0.0.6 (X11/20070926)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Ralf Baechle <ralf@linux-mips.org>, kevink@paralogos.com
Subject: Re: Load Average >=1, mips kernel 2.6.10
References: <48863A41.2020303@aksysnetworks.com> <20080722212900.GD22094@linux-mips.org>
In-Reply-To: <20080722212900.GD22094@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ahuja@aksysnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ahuja@aksysnetworks.com
Precedence: bulk
X-list: linux-mips

Here is what my command line shows

Thanks for the reply...
here is what the telnet session shows

# uptime
 19:45:38 up  2:45, load average: 1.00, 1.00, 0.94
# ps
  PID  Uid     VmSize Stat Command
    1 root        372 S   init      
    2 root            SW  [ksoftirqd/0]
    3 root            SW< [desched/0]
    4 root            SW< [events/0]
    5 root            SW< [khelper]
    6 root            SW< [kthread]
    7 root            SW< [kblockd/0]
    8 root            SW  [pdflush]
    9 root            SW  [pdflush]
   11 root            SW< [aio/0]
   10 root            SW  [kswapd0]
   13 root            SW  [mtdblockd]
   12 root            SW  [kseriod]
   14 root            SW< [IRQ 8]
   15 root            SWN [jffs2_gcd_mtd0]
   16 root            SW< [IRQ 15]
   56 root            SW< [IRQ 35]
   62 root        392 S   udhcpc -n -p /var/run/udhcpc.esw0.pid -i esw0
   68 root        364 S   /sbin/syslogd -n -m 0
   69 root        336 S   /sbin/klogd -n
   70 root        492 S   -sh
   76 root        316 S   telnetd
   99 root            SW< [IRQ 45]
  108 root        548 S   -sh
  189 root        552 S   -sh
  217 root        376 R   ps
# top
Mem: 5808K used, 8652K free, 0K shrd, 0K buff, 1364K cached
Load average: 1.00 1.00 0.94  (Status: S=sleeping R=running, W=waiting)
  PID USER     STATUS   RSS  PPID %CPU %MEM COMMAND
  220 root     R        388   189  1.9  2.6 top
  189 root     S        552    76  0.0  3.8 sh
  108 root     S        548    76  0.0  3.7 sh
   70 root     S        492     1  0.0  3.3 sh
   62 root     S        392     1  0.0  2.6 udhcpc
    1 root     S        372     0  0.0  2.5 init
   68 root     S        364     1  0.0  2.5 syslogd
   69 root     S        336     1  0.0  2.3 klogd
   76 root     S        316     1  0.0  2.1 telnetd
    2 root     SW         0     1  0.0  0.0 ksoftirqd/0
   15 root     SWN        0     1  0.0  0.0 jffs2_gcd_mtd0
    3 root     SW<        0     1  0.0  0.0 desched/0
   11 root     SW<        0     6  0.0  0.0 aio/0
    4 root     SW<        0     1  0.0  0.0 events/0
   14 root     SW<        0     6  0.0  0.0 IRQ 8
   16 root     SW<        0     6  0.0  0.0 IRQ 15
   56 root     SW<        0     6  0.0  0.0 IRQ 35
    5 root     SW<        0     1  0.0  0.0 khelper
    6 root     SW<        0     1  0.0  0.0 kthread
    7 root     SW<        0     6  0.0  0.0 kblockd/0
    8 root     SW         0     6  0.0  0.0 pdflush

There are no 'D' threads. What bothers me is that it slowly creeps up to 
1.00 when the system starts or resets..so there is something going on...

i would appreciate any help or insights...

regards
manjee

Ralf Baechle wrote:
> On Tue, Jul 22, 2008 at 01:51:29PM -0600, Mandeep Ahuja wrote:
>
>   
>> I have an embedded system thats has mips processor. I recently updated  
>> to Kernel 2.6.10 from 2.4.17.
>> I was able to run the kernel and mount the jffs2 file system.
>>
>> When the system starts the load average is low like 0.02 but, after  
>> about 2 minutes it becomes 1.00 and as long as the system is idle it  
>> stays at 1.00. If the system is not idle it would go up to like 1.21 but  
>> eventually come down  to 1.00 but NEVER goes below 1.
>>
>> There is no application running on the system. Only the busybox. Top  
>> shows all processes sleeping.
>>
>> this is the version of kernel
>> Linux version 2.6.10_dev-malta-mips2_fp_len (gcc version 3.4.6)
>>
>> Is there something holding the processor continuously? does anyone have  
>> any idea whats going on?.
>>
>> I need to figure this one out before I start my application on it!.
>>     
>
> Usually the reason would be something like a process stuck in
> noninterruptible sleep state.  That's status "D" in the ps output.  Such
> a process can't be killed and generally if a process is in this state for
> extended time this would be considered a bug.
>
>   Ralf
>
>
>   
