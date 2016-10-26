Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2016 11:02:36 +0200 (CEST)
Received: from sandesh.cdotd.ernet.in ([196.1.105.47]:58117 "HELO
        sandesh.cdotd.ernet.in" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S23992226AbcJZJCYlz1EN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Oct 2016 11:02:24 +0200
Received: from mail.cdot.in (webmail.cdotd.ernet.in [196.1.105.198])
        by sandesh.cdotd.ernet.in (Postfix) with ESMTP id 5B9BD1DDE4C6
        for <linux-mips@linux-mips.org>; Wed, 26 Oct 2016 14:30:47 +0530 (IST)
Received: from cdot.in (localhost [127.0.0.1])
        by mail.cdot.in (8.14.7/8.13.8) with ESMTP id u9Q91p2D019052
        for <linux-mips@linux-mips.org>; Wed, 26 Oct 2016 14:31:51 +0530
From:   "Deepak Gaur" <dgaur@cdot.in>
To:     linux-mips@linux-mips.org
Subject: System clock going slow/fast with ntpdate
Date:   Wed, 26 Oct 2016 14:31:51 +0530
Message-Id: <20161026090102.M12530@cdot.in>
In-Reply-To: <20161026085306.M18729@cdot.in>
References: <20161026081208.M10605@cdot.in> <20161026085306.M18729@cdot.in>
X-Mailer: OpenWebMail 2.54 
X-OriginatingIP: 192.168.3.57 (dgaur)
MIME-Version: 1.0
Content-Type: text/plain;
        charset=utf-8
Return-Path: <dgaur@cdot.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dgaur@cdot.in
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

Hello,

 I have board with MIPS 34Kc processor and linux-2.6.29 with CONFIG_HZ_250=y set in kernel configuration (i.e 250 timer 
 interrupts per 1 real second in /proc/interrupts). When I try to synchronize time using ntpdate command, the time gets 
 synchronized. This resync is being done every 5 min using cron. The clocksource is set to jiffies and is the only source 
 available. After some time (1 hr and more) the system clock (kernel/software) sometimes starts slowing down and sometime 
 goes fast. System time increments very slowly i.e 1 sec on system takes 8-9 real seconds (as per wrist watch) or fast 2 
 sec in 1 real second.

 #date 
 Tue Oct 25 15:14:05 IST 2016 
 # date 
 Tue Oct 25 15:14:05 IST 2016 
 # date 
 Tue Oct 25 15:14:05 IST 2016 
 # date 
 Tue Oct 25 15:14:05 IST 2016 
 # date 
 Tue Oct 25 15:14:05 IST 2016 
 # date 
 Tue Oct 25 15:14:05 IST 2016 
 # date 
 Tue Oct 25 15:14:05 IST 2016 
 # date 
 Tue Oct 25 15:14:05 IST 2016 
 # date 
 Tue Oct 25 15:14:05 IST 2016 
 # date 
 Tue Oct 25 15:14:06 IST 2016 
 # date 
 Tue Oct 25 15:14:06 IST 2016

 (It took 10 date commands to increment from 14:05 to 15:06)

 On further analysing the system we found the number of timer interrupts in /proc/interrupts has actually gone down from 
 250 to 40 every 1 real second

 (1) Normal Operation 10 real sec watch window

 cat /proc/interrupts

 Start of timer  MIPS timer intr count 3856633 
 End of Timer   MIPS timer intr count 3859268

 Timing approximately 10-11 real sec, the interrupts are 263 per sec.

 (2) Clock Slow (Less Timer Interrupts) 
 After ntpdate run for 1 hr once per 5 min

 cat /proc/interrupts

 Start of timer  MIPS timer intr count 985072 
 End of Timer   MIPS timer intr count 985492

 985492 - 985072 = 420 in 10 sec (real) = 42 in 1 sec

 (3) Fast Clock with ntpdate (More Timer interrupts)

 Start of timer  MIPS timer intr count 4068301 
 End of Timer   MIPS timer intr count 4073411 
 985492 - 985072 = 5110 in 10 sec (real) = 511 in 1 real sec

 ntpdate uses ntp_adjtime()/adjtimex() GNU libc system call for changing system clock and can change it but by a very 
 small amount.

 But the issue is it is changing system clock so much that other application have started behaving erratically, timers 
 are not expiring in required time etc.. and once the system clock has slowed down/fast it remains in that state.

 # cat /sys/devices/system/clocksource/clocksource0/available_clocksource 
 jiffies 
   
 # cat /sys/devices/system/clocksource/clocksource0/current_clocksource   
 jiffies

 We are using gcc version 4.5.2  and gnu libc

 Please help me in understanding this behaviour of NTP with MIPS Linux and possible fixes if any. Is it a kernel bug or a 
 configuration issue?

 regards,

 Deepak Gaur
